import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'models.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {

  Future<void> _contactCustomer(String phone, String name, double amount) async {
    String formattedPhone = phone.trim();
    if (formattedPhone.startsWith('0')) formattedPhone = '92${formattedPhone.substring(1)}';
    formattedPhone = formattedPhone.replaceAll(RegExp(r'[^0-9]'), '');

    String message = "السلام علیکم $name صاحب!\nآپ کی طرف ہماری دکان کے Rs ${amount.toStringAsFixed(0)} بقایا ہیں۔ براہ کرم جلد ادا کر کے شکریہ کا موقع دیں۔\nشکریہ!";
    final Uri url = Uri.parse("https://wa.me/$formattedPhone?text=${Uri.encodeComponent(message)}");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not open WhatsApp.')));
    }
  }

  void _addPayment(CustomerRecord customer) {
    final paymentController = TextEditingController(text: customer.remaining.toStringAsFixed(0));
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Receive Payment (وصولی)'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Customer: ${customer.name}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Remaining: Rs ${customer.remaining.toStringAsFixed(0)}', style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: paymentController, keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount Received (Rs)', border: OutlineInputBorder(), prefixIcon: Icon(Icons.money)),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          FilledButton.icon(
            style: FilledButton.styleFrom(backgroundColor: const Color(0xFF7CB342)),
            onPressed: () {
              double received = double.tryParse(paymentController.text) ?? 0.0;
              if (received <= 0) return;
              setState(() {
                customer.advance += received;
                customer.remaining -= received;
                if (customer.remaining < 0) customer.remaining = 0;
              });
              saveAppData();
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment updated!'), backgroundColor: Colors.green));
            },
            icon: const Icon(Icons.check), label: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _addExpenseDialog() {
    final titleController = TextEditingController();
    final amountController = TextEditingController();
    String selectedType = 'Daily';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: const Text('Add Expense (خرچہ)'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Expense Detail (e.g. Tea, Bill)', border: OutlineInputBorder())),
                const SizedBox(height: 10),
                TextField(controller: amountController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Amount (Rs)', border: OutlineInputBorder(), prefixIcon: Icon(Icons.money_off))),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: selectedType,
                  decoration: const InputDecoration(labelText: 'Type', border: OutlineInputBorder()),
                  items: ['Daily', 'Weekly', 'Monthly'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (val) => setDialogState(() => selectedType = val!),
                )
              ],
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
              FilledButton(
                style: FilledButton.styleFrom(backgroundColor: const Color(0xFF7CB342)),
                onPressed: () {
                  if (titleController.text.isEmpty || amountController.text.isEmpty) return;
                  setState(() {
                    shopExpenses.add(ExpenseRecord(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      title: titleController.text,
                      amount: double.tryParse(amountController.text) ?? 0.0,
                      date: DateTime.now(),
                      type: selectedType,
                    ));
                  });
                  saveAppData();
                  Navigator.pop(ctx);
                },
                child: const Text('Save Expense'),
              )
            ],
          );
        }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final udhaarCustomers = savedCustomers.where((c) => c.status == 'Delivered' && c.remaining > 0).toList();
    double totalUdhaar = udhaarCustomers.fold(0, (sum, c) => sum + c.remaining);

    final paidCustomers = savedCustomers.where((c) => c.advance > 0).toList();
    double totalIncome = paidCustomers.fold(0, (sum, c) => sum + c.advance);

    final readyCustomers = savedCustomers.where((c) => c.status == 'Ready' && c.remaining > 0).toList();
    double expectedFromReady = readyCustomers.fold(0, (sum, c) => sum + c.remaining);

    double totalExpenses = shopExpenses.fold(0, (sum, e) => sum + e.amount);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F6F8),
        appBar: AppBar(
          title: const Text(
            'ادائگی / آمدنی (Payments & Income)',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xFF7CB342),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            tabs: [
              Tab(icon: Icon(Icons.money_off), text: 'Udhaar'),
              Tab(icon: Icon(Icons.account_balance_wallet), text: 'Income'),
              Tab(icon: Icon(Icons.receipt_long), text: 'Expenses'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // 1. UDHAAR
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.red.shade50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Market Credit:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)),
                      Text('Rs ${totalUdhaar.toStringAsFixed(0)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red)),
                    ],
                  ),
                ),
                Expanded(
                  child: udhaarCustomers.isEmpty
                      ? const Center(child: Text('Great! No pending Udhaar.', style: TextStyle(color: Colors.green, fontSize: 16)))
                      : ListView.builder(
                          padding: const EdgeInsets.all(12),
                          itemCount: udhaarCustomers.length,
                          itemBuilder: (context, index) {
                            final c = udhaarCustomers[index];
                            return Card(
                              child: ListTile(
                                title: Text('${c.tokenNumber} - ${c.name}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                subtitle: const Text('Status: Delivered'),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('Rs ${c.remaining.toStringAsFixed(0)}', style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16)),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(icon: const Icon(Icons.wechat, color: Colors.green, size: 20), onPressed: () => _contactCustomer(c.mobile, c.name, c.remaining)),
                                        TextButton(onPressed: () => _addPayment(c), child: const Text('Receive', style: TextStyle(color: Colors.blue))),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),

            // 2. INCOME
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.green.shade50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Cash Received:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
                      Text('Rs ${totalIncome.toStringAsFixed(0)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)),
                    ],
                  ),
                ),
                if (expectedFromReady > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    color: Colors.orange.shade50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Expected Cash (Ready Suits):', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.deepOrange)),
                        Text('Rs ${expectedFromReady.toStringAsFixed(0)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepOrange)),
                      ],
                    ),
                  ),
                Expanded(
                  child: paidCustomers.isEmpty
                      ? const Center(child: Text('No income recorded yet.'))
                      : ListView.builder(
                          padding: const EdgeInsets.all(12),
                          itemCount: paidCustomers.length,
                          itemBuilder: (context, index) {
                            final c = paidCustomers[index];
                            return Card(
                              child: ListTile(
                                leading: const CircleAvatar(backgroundColor: Colors.green, child: Icon(Icons.arrow_downward, color: Colors.white)),
                                title: Text(c.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                                subtitle: Text('Token: ${c.tokenNumber}'),
                                trailing: Text('+ Rs ${c.advance.toStringAsFixed(0)}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16)),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),

            // 3. EXPENSES
            Scaffold(
              backgroundColor: const Color(0xFFF5F6F8),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: _addExpenseDialog,
                backgroundColor: const Color(0xFF7CB342),
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text('Add Expense', style: TextStyle(color: Colors.white)),
              ),
              body: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.orange.shade50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Shop Expenses:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepOrange)),
                        Text('Rs ${totalExpenses.toStringAsFixed(0)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepOrange)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: shopExpenses.isEmpty
                        ? const Center(child: Text('No expenses recorded.'))
                        : ListView.builder(
                            padding: const EdgeInsets.all(12),
                            itemCount: shopExpenses.length,
                            itemBuilder: (context, index) {
                              final e = shopExpenses[index];
                              return Card(
                                child: ListTile(
                                  leading: const CircleAvatar(backgroundColor: Colors.red, child: Icon(Icons.money_off, color: Colors.white)),
                                  title: Text(e.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  subtitle: Text('${e.date.day}/${e.date.month}/${e.date.year} - ${e.type} Expense'),
                                  trailing: Text('- Rs ${e.amount.toStringAsFixed(0)}', style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16)),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}