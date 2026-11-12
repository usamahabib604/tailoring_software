import 'package:flutter/material.dart';
import 'models.dart';

class PosReportsScreen extends StatelessWidget {
  const PosReportsScreen({super.key});

  final Color parrotGreen = const Color(0xFF7CB342);

  void _generateReport(BuildContext context, String reportType) {
    String title = '';
    List<String> headers = [];
    List<List<String>> rows = [];

    switch (reportType) {
      case 'Product Groups':
        title = 'PRODUCT GROUPS REPORT';
        headers = ['کل پروڈکٹس', 'گروپ کا نام'];
        for (var g in posGroups) {
          int count = posProducts.where((p) => p.groupName == g.name).length;
          rows.add([count.toString(), g.name]);
        }
        break;

      case 'Zero / Negative Stock':
        title = 'ZERO & NEGATIVE STOCK REPORT';
        headers = ['مقدار', 'گروپ', 'پروڈکٹ'];
        for (var p in posProducts.where((p) => p.stockQuantity <= 0)) {
          rows.add([p.stockQuantity.toStringAsFixed(1), p.groupName, p.name]);
        }
        break;

      case 'Valuation Report':
        title = 'STOCK VALUATION REPORT';
        headers = ['فروخت مالیت', 'خرید مالیت', 'مقدار', 'پروڈکٹ'];
        for (var p in posProducts.where((p) => p.stockQuantity > 0)) {
          double cVal = p.costPrice * p.stockQuantity;
          double sVal = p.sellingPrice * p.stockQuantity;
          rows.add([sVal.toStringAsFixed(0), cVal.toStringAsFixed(0), p.stockQuantity.toStringAsFixed(1), p.name]);
        }
        break;
        
      case 'Active / Inactive':
        title = 'ACTIVE & INACTIVE PRODUCTS';
        headers = ['سٹیٹس', 'قیمت', 'پروڈکٹ'];
        for (var p in posProducts) {
          rows.add([p.isActive ? 'Active' : 'Inactive', p.sellingPrice.toStringAsFixed(0), p.name]);
        }
        break;
    }

    if (rows.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('اس رپورٹ کے لیے کوئی ڈیٹا موجود نہیں ہے۔')));
      return;
    }

    generateAndShareUniversalPdf(
      title: title,
      subtitle: 'Generated on: ${DateTime.now().toString().split('.')[0]}',
      headers: headers,
      rows: rows,
      fileName: '${reportType.replaceAll(' ', '_')}.pdf',
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> reportTypes = [
      {'title': 'Product Groups Report', 'icon': Icons.category, 'type': 'Product Groups'},
      {'title': 'Zero / Negative Stock Report', 'icon': Icons.warning_amber_rounded, 'type': 'Zero / Negative Stock'},
      {'title': 'Stock Valuation (Cost & Selling)', 'icon': Icons.monetization_on_rounded, 'type': 'Valuation Report'},
      {'title': 'Active / Inactive Products', 'icon': Icons.rule_rounded, 'type': 'Active / Inactive'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: AppBar(
        title: const Text('POS Reports', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: parrotGreen,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: reportTypes.length,
        itemBuilder: (context, index) {
          final r = reportTypes[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: CircleAvatar(backgroundColor: parrotGreen.withOpacity(0.2), child: Icon(r['icon'], color: parrotGreen)),
              title: Text(r['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
              trailing: const Icon(Icons.picture_as_pdf, color: Colors.red),
              onTap: () => _generateReport(context, r['type']),
            ),
          );
        },
      ),
    );
  }
}