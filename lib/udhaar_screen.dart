import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'models.dart';

class UdhaarScreen extends StatefulWidget {
  const UdhaarScreen({super.key});

  @override
  State<UdhaarScreen> createState() => _UdhaarScreenState();
}

class _UdhaarScreenState extends State<UdhaarScreen> {
  
  // واٹس ایپ پر تقاضا کرنے کا میسج
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

  // بقایا پیسے وصول کرنے کا فنکشن
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
            Text('Total Remaining: Rs ${customer.remaining.toStringAsFixed(0)}', style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),
            TextField(
              controller: paymentController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount Received Now (Rs)', border: OutlineInputBorder(), prefixIcon: Icon(Icons.money)),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          FilledButton.icon(
            style: FilledButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () {
              double received = double.tryParse(paymentController.text) ?? 0.0;
              if (received <= 0) return;

              setState(() {
                customer.advance += received; // جتنا وصول ہوا وہ ایڈوانس میں جمع
                customer.remaining -= received; // بقایا میں سے مائنس
                if (customer.remaining < 0) customer.remaining = 0; // مائنس میں نہ جائے
              });
              
              saveAppData(); // میموری میں سیو
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment updated successfully!'), backgroundColor: Colors.green));
            },
            icon: const Icon(Icons.check),
            label: const Text('Save Payment'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // پوری ایپ میں سے وہ کسٹمرز نکالیں جن کے پیسے بقایا ہیں
    final udhaarCustomers = savedCustomers.where((c) => c.remaining > 0).toList();
    
    // مارکیٹ میں ٹوٹل ادھار کیلکولیٹ کریں
    double totalUdhaar = udhaarCustomers.fold(0.0, (sum, item) => sum + item.remaining);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Udhaar / Credit Book', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.red.shade800,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // ٹوٹل ادھار کی سمری (اوپر لال رنگ کی پٹی)
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
          
          // ادھار والوں کی لسٹ
          Expanded(
            child: udhaarCustomers.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle_outline, color: Colors.green, size: 60),
                        SizedBox(height: 10),
                        Text('Great! No pending payments.', style: TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: udhaarCustomers.length,
                    itemBuilder: (context, index) {
                      final customer = udhaarCustomers[index];
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // کسٹمر کا نام اور تفصیل
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${customer.tokenNumber} - ${customer.name}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                    const SizedBox(height: 4),
                                    Text('Phone: ${customer.mobile}', style: const TextStyle(color: Colors.grey)),
                                    Text('Status: ${customer.status}', style: const TextStyle(color: Colors.grey)),
                                  ],
                                ),
                              ),
                              // بقایا رقم اور ایکشن بٹنز
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('Rs ${customer.remaining.toStringAsFixed(0)}', style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18)),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      // واٹس ایپ بٹن
                                      InkWell(
                                        onTap: () => _contactCustomer(customer.mobile, customer.name, customer.remaining),
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(8)),
                                          child: const Icon(Icons.wechat, color: Colors.green, size: 20),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      // پیمنٹ وصول کرنے کا بٹن
                                      InkWell(
                                        onTap: () => _addPayment(customer),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                          decoration: BoxDecoration(color: Colors.blue.shade600, borderRadius: BorderRadius.circular(8)),
                                          child: const Text('Add Payment', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                                        ),
                                      ),
                                    ],
                                  )
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
    );
  }
}