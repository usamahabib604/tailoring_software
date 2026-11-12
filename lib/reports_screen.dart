import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:typed_data';
import 'models.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  String selectedTimeRange = 'This Month';
  DateTime startDate = DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime endDate = DateTime.now();

  // کون سی ڈیٹیل نیچے شو کرنی ہے اس کا اسٹیٹ
  String activeReportCategory = 'Summary'; 

  final Color parrotGreen = const Color(0xFF7CB342);
  final Color darkGreenText = const Color(0xFF2E7D32);

  String _formatDate(DateTime d) => '${d.day}/${d.month}/${d.year}';

  void _setTimeRange(String range) {
    DateTime now = DateTime.now();
    setState(() {
      selectedTimeRange = range;
      if (range == 'Today') {
        startDate = DateTime(now.year, now.month, now.day);
        endDate = DateTime(now.year, now.month, now.day, 23, 59, 59);
      } else if (range == 'This Week') {
        startDate = now.subtract(Duration(days: now.weekday - 1));
        endDate = now;
      } else if (range == 'This Month') {
        startDate = DateTime(now.year, now.month, 1);
        endDate = now;
      } else if (range == 'This Year') {
        startDate = DateTime(now.year, 1, 1);
        endDate = now;
      } else if (range == 'All Time') {
        startDate = DateTime(2020);
        endDate = now;
      }
    });
  }

  // دو الگ الگ کیلنڈر (Left to Right Swipe والے)
  Future<void> _pickCustomDateRange() async {
    DateTime? start = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      helpText: 'شروع کی تاریخ منتخب کریں',
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(colorScheme: ColorScheme.light(primary: parrotGreen, onPrimary: Colors.white, onSurface: Colors.black)),
        child: child!,
      ),
    );

    if (start != null) {
      DateTime? end = await showDatePicker(
        context: context,
        initialDate: start,
        firstDate: start,
        lastDate: DateTime(2030),
        helpText: 'ختم ہونے کی تاریخ منتخب کریں',
        builder: (context, child) => Theme(
          data: Theme.of(context).copyWith(colorScheme: ColorScheme.light(primary: parrotGreen, onPrimary: Colors.white, onSurface: Colors.black)),
          child: child!,
        ),
      );

      if (end != null) {
        setState(() {
          selectedTimeRange = 'Manual';
          startDate = start;
          endDate = DateTime(end.year, end.month, end.day, 23, 59, 59);
        });
      }
    }
  }

  bool _isWithinRange(DateTime date) {
    return date.isAfter(startDate.subtract(const Duration(seconds: 1))) && 
           date.isBefore(endDate.add(const Duration(seconds: 1)));
  }

  Future<void> _printPDFReport() async {
    // پی ڈی ایف پرنٹ کرنے کا فیچر (یہ بعد میں مزید بہتر کیا جا سکتا ہے)
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Generating PDF Report...')));
  }

  @override
  Widget build(BuildContext context) {
    final filteredCustomers = savedCustomers.where((c) => _isWithinRange(c.bookingDate)).toList();
    final filteredExpenses = shopExpenses.where((e) => _isWithinRange(e.date)).toList();

    // ==========================================
    // 1. CASH IN (پیسے جو دکان میں آئے ہیں)
    // ==========================================
    // ایڈوانس: وہ سوٹ جو ابھی دکان میں ہیں (Delivered نہیں ہوئے) اور ان پر ایڈوانس مل چکا ہے
    double advanceCash = filteredCustomers.where((c) => c.status != 'Delivered').fold(0, (sum, c) => sum + c.advance);
    
    // ڈیلیوری کیش: وہ سوٹ جو کسٹمر لے گیا ہے اور ان کی کل وصول شدہ رقم
    double deliveryCash = filteredCustomers.where((c) => c.status == 'Delivered').fold(0, (sum, c) => sum + c.advance);
    
    // کپڑے کی سیل: فی الحال 0 کیونکہ ماڈل موجود نہیں
    double fabricSalesCash = 0.0; 

    // کل موصول شدہ رقم (دراز میں کتنا کیش ہے)
    double totalCashIn = advanceCash + deliveryCash + fabricSalesCash;

    // ==========================================
    // 2. RECEIVABLES (پیسے جو لینے باقی ہیں)
    // ==========================================
    // بقیہ / پینڈنگ: سوٹ دکان میں ہے، پیسے لینے باقی ہیں
    final pendingList = filteredCustomers.where((c) => c.status != 'Delivered' && c.remaining > 0).toList();
    double pendingCash = pendingList.fold(0, (sum, c) => sum + c.remaining);

    // ادھار کھاتہ: سوٹ ڈیلیور ہو گیا، پیسے ابھی نہیں ملے
    final udhaarList = filteredCustomers.where((c) => c.status == 'Delivered' && c.remaining > 0).toList();
    double udhaarCash = udhaarList.fold(0, (sum, c) => sum + c.remaining);

    // ==========================================
    // 3. OUTFLOW (پیسے جو دکان سے گئے / دینے ہیں)
    // ==========================================
    double totalExpenses = filteredExpenses.fold(0, (sum, e) => sum + e.amount);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: AppBar(
        title: const Text('مالیاتی رپورٹس (Financial Reports)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: parrotGreen,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _printPDFReport,
        backgroundColor: parrotGreen,
        foregroundColor: Colors.white,
        child: const Icon(Icons.picture_as_pdf),
      ),
      body: Column(
        children: [
          // ==============================
          // ٹائم فلٹر (سلائیڈنگ)
          // ==============================
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('وقت منتخب کریں (Time Filter)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: darkGreenText)),
                    if (selectedTimeRange == 'Manual')
                      Text('${_formatDate(startDate)} - ${_formatDate(endDate)}', style: const TextStyle(color: Colors.grey, fontSize: 11)),
                  ],
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...['Today', 'This Week', 'This Month', 'This Year', 'All Time'].map((range) {
                        bool isSelected = selectedTimeRange == range;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ChoiceChip(
                            label: Text(range == 'Today' ? 'آج' : range == 'This Week' ? 'ہفتہ' : range == 'This Month' ? 'مہینہ' : range == 'This Year' ? 'سال' : 'سب'),
                            selected: isSelected,
                            onSelected: (val) => _setTimeRange(range),
                            selectedColor: parrotGreen.withOpacity(0.2),
                            labelStyle: TextStyle(color: isSelected ? darkGreenText : Colors.black87, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: isSelected ? parrotGreen : Colors.grey.shade300)),
                          ),
                        );
                      }),
                      ActionChip(
                        avatar: Icon(Icons.date_range, size: 16, color: selectedTimeRange == 'Manual' ? darkGreenText : Colors.grey.shade700),
                        label: Text('Manual', style: TextStyle(color: selectedTimeRange == 'Manual' ? darkGreenText : Colors.black87)),
                        onPressed: _pickCustomDateRange,
                        backgroundColor: selectedTimeRange == 'Manual' ? parrotGreen.withOpacity(0.2) : Colors.grey.shade100,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: selectedTimeRange == 'Manual' ? parrotGreen : Colors.grey.shade300)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // ==============================
          // 8 مالیاتی باکسز (Grids) جن پر کلک ہو سکے
          // ==============================
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // 1. کل کیش ان (بڑا کارڈ)
                _buildClickableTotalCard('کل وصول شدہ کیش (Total Cash In)', 'Rs ${totalCashIn.toStringAsFixed(0)}', Icons.account_balance_wallet, parrotGreen),
                const SizedBox(height: 16),
                
                Text('کیش ان (آمدنی / ایڈوانس)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: darkGreenText)),
                const SizedBox(height: 10),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.85,
                  children: [
                    _buildClickableCard('ایڈوانس', 'Rs ${advanceCash.toStringAsFixed(0)}', Icons.payments_rounded, Colors.blue, 'Advance'),
                    _buildClickableCard('ڈیلیوری کیش', 'Rs ${deliveryCash.toStringAsFixed(0)}', Icons.task_alt_rounded, Colors.teal, 'DeliveryCash'),
                    _buildClickableCard('کپڑے کی سیل', 'Rs ${fabricSalesCash.toStringAsFixed(0)}', Icons.checkroom_rounded, Colors.indigo, 'FabricCash'),
                  ],
                ),
                
                const SizedBox(height: 20),
                Text('لینے والے پیسے (Receivables)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.orange.shade800)),
                const SizedBox(height: 10),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.3,
                  children: [
                    _buildClickableCard('بقیہ (سوٹ دکان میں ہے)', 'Rs ${pendingCash.toStringAsFixed(0)}', Icons.pending_actions_rounded, Colors.orange, 'Pending'),
                    _buildClickableCard('ادھار (سوٹ ڈیلیور ہو گیا)', 'Rs ${udhaarCash.toStringAsFixed(0)}', Icons.money_off_rounded, Colors.red, 'Udhaar'),
                  ],
                ),

                const SizedBox(height: 20),
                Text('اخراجات اور کاریگر (Outflow)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.purple.shade800)),
                const SizedBox(height: 10),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.3,
                  children: [
                    _buildClickableCard('دکان کے اخراجات', 'Rs ${totalExpenses.toStringAsFixed(0)}', Icons.receipt_long_rounded, Colors.deepOrange, 'Expenses'),
                    _buildClickableCard('سٹاف کا کھاتہ', 'View', Icons.engineering_rounded, Colors.purple, 'Staff'),
                  ],
                ),

                const SizedBox(height: 30),
                // ==============================
                // تفصیلی لسٹ (جس کارڈ پر کلک کریں گے، وہ شو ہوگی)
                // ==============================
                const Divider(thickness: 2),
                const SizedBox(height: 10),
                _buildDetailedSection(pendingList, udhaarList, filteredExpenses),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClickableTotalCard(String title, String value, IconData icon, Color bgColor) {
    return InkWell(
      onTap: () => setState(() => activeReportCategory = 'Summary'),
      child: Card(
        elevation: 4,
        color: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(padding: const EdgeInsets.all(8), decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: Icon(icon, color: bgColor, size: 30)),
                  const SizedBox(width: 12),
                  Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                ],
              ),
              Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClickableCard(String title, String value, IconData icon, Color color, String categoryId) {
    bool isActive = activeReportCategory == categoryId;
    return InkWell(
      onTap: () => setState(() => activeReportCategory = categoryId),
      borderRadius: BorderRadius.circular(12),
      child: Card(
        elevation: isActive ? 4 : 1,
        color: isActive ? color.withOpacity(0.05) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: isActive ? color : color.withOpacity(0.3), width: isActive ? 2 : 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: color.withOpacity(0.15), shape: BoxShape.circle), child: Icon(icon, color: color, size: 28)),
              const SizedBox(height: 8),
              FittedBox(fit: BoxFit.scaleDown, child: Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: color))),
              const SizedBox(height: 2),
              FittedBox(fit: BoxFit.scaleDown, child: Text(title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11, color: Colors.grey.shade800))),
            ],
          ),
        ),
      ),
    );
  }

  // منتخب کردہ کارڈ کے حساب سے نیچے لسٹ دکھانے والا ویجیٹ
  Widget _buildDetailedSection(List<CustomerRecord> pendingList, List<CustomerRecord> udhaarList, List<ExpenseRecord> expenses) {
    if (activeReportCategory == 'Summary') {
      return const Center(child: Text('کسی بھی کارڈ پر کلک کر کے اس کی مکمل تفصیل یہاں دیکھیں۔', style: TextStyle(color: Colors.grey, fontSize: 14)));
    } else if (activeReportCategory == 'FabricCash') {
      return const Center(child: Text('کپڑے کی سیل (POS) کا فیچر جلد شامل کیا جائے گا۔', style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)));
    } else if (activeReportCategory == 'Pending') {
      return _buildCustomerList('بقیہ وصولی (سوٹ دکان میں ہیں)', pendingList, Colors.orange);
    } else if (activeReportCategory == 'Udhaar') {
      return _buildCustomerList('ادھار کھاتہ (سوٹ ڈیلیور ہو چکے)', udhaarList, Colors.red);
    } else if (activeReportCategory == 'Expenses') {
      return _buildExpenseList(expenses);
    } else if (activeReportCategory == 'Staff') {
      return _buildStaffList();
    } else {
      return const Center(child: Text('تفصیل دستیاب نہیں ہے۔'));
    }
  }

  Widget _buildCustomerList(String title, List<CustomerRecord> list, Color color) {
    if (list.isEmpty) return Center(child: Text('اس کھاتے میں کوئی ریکارڈ موجود نہیں ہے۔', style: TextStyle(color: color)));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 10),
        ...list.map((c) => Card(
          child: ListTile(
            leading: CircleAvatar(backgroundColor: color.withOpacity(0.2), child: Text(c.tokenNumber, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold))),
            title: Text(c.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Status: ${c.status}'),
            trailing: Text('Rs ${c.remaining.toStringAsFixed(0)}', style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 16)),
          ),
        )),
      ],
    );
  }

  Widget _buildExpenseList(List<ExpenseRecord> list) {
    if (list.isEmpty) return const Center(child: Text('کوئی اخراجات درج نہیں ہیں۔'));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('تفصیلِ اخراجات', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepOrange)),
        const SizedBox(height: 10),
        ...list.map((e) => Card(
          child: ListTile(
            leading: const Icon(Icons.receipt, color: Colors.deepOrange),
            title: Text(e.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${e.date.day}/${e.date.month}/${e.date.year}'),
            trailing: Text('Rs ${e.amount.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange)),
          ),
        )),
      ],
    );
  }

  Widget _buildStaffList() {
    if (shopStaff.isEmpty) return const Center(child: Text('کوئی سٹاف موجود نہیں ہے۔'));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('سٹاف کا موجودہ بیلنس', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.purple)),
        const SizedBox(height: 10),
        ...shopStaff.map((s) => Card(
          child: ListTile(
            leading: const Icon(Icons.engineering, color: Colors.purple),
            title: Text(s.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(s.role),
            trailing: Text('Rs ${s.balance.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.purple, fontSize: 16)),
          ),
        )),
      ],
    );
  }
}