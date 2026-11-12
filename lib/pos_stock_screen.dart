import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models.dart';

class PosStockScreen extends StatefulWidget {
  const PosStockScreen({super.key});

  @override
  State<PosStockScreen> createState() => _PosStockScreenState();
}

class _PosStockScreenState extends State<PosStockScreen> {
  final Color parrotGreen = const Color(0xFF7CB342);
  final Color creamColor = const Color(0xFFFFFDD0); // ★ یہ لائن مس ہو گئی تھی ★
  final Color darkGreenText = const Color(0xFF2E7D32);
  final Color bgColor = const Color(0xFFF5F6F8);

  String _selectedFilter = 'All Products';
  final List<String> _filters = ['All Products', 'Non-Zero', 'Zero', 'Negative', 'Low Stock', 'Active', 'Inactive'];

  List<PosProduct> get filteredStock {
    return posProducts.where((p) {
      if (_selectedFilter == 'Non-Zero') return p.stockQuantity > 0;
      if (_selectedFilter == 'Zero') return p.stockQuantity == 0;
      if (_selectedFilter == 'Negative') return p.stockQuantity < 0;
      if (_selectedFilter == 'Low Stock') return p.lowStockWarning && p.stockQuantity <= p.reorderPoint && p.stockQuantity > 0;
      if (_selectedFilter == 'Active') return p.isActive;
      if (_selectedFilter == 'Inactive') return !p.isActive;
      return true; // All Products
    }).toList();
  }

  void _printStockReport() {
    List<List<String>> rows = filteredStock.map((p) => [
      p.stockQuantity.toStringAsFixed(1),
      p.sellingPrice.toStringAsFixed(0),
      p.costPrice.toStringAsFixed(0),
      p.groupName,
      p.name,
    ]).toList();

    generateAndShareUniversalPdf(
      title: 'STOCK REPORT',
      subtitle: 'Filter: $_selectedFilter | Total Items: ${filteredStock.length}',
      headers: ['مقدار (Qty)', 'فروخت قیمت (Selling)', 'خرید قیمت (Cost)', 'گروپ (Group)', 'پروڈکٹ (Product)'],
      rows: rows,
      fileName: 'stock_report.pdf',
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalCostValue = filteredStock.fold(0, (sum, p) => sum + (p.costPrice * p.stockQuantity));
    double totalSellingValue = filteredStock.fold(0, (sum, p) => sum + (p.sellingPrice * p.stockQuantity));

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('Live Stock', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: parrotGreen,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(icon: const Icon(Icons.picture_as_pdf), onPressed: _printStockReport, tooltip: 'Download PDF'),
        ],
      ),
      body: Column(
        children: [
          // فلٹرز (Filters)
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _filters.map((filter) {
                  bool isSelected = _selectedFilter == filter;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(filter, style: TextStyle(color: isSelected ? Colors.white : darkGreenText, fontWeight: FontWeight.bold)),
                      selected: isSelected,
                      selectedColor: parrotGreen,
                      backgroundColor: creamColor, // ★ یہاں اب کوئی ایرر نہیں آئے گا ★
                      onSelected: (val) => setState(() => _selectedFilter = filter),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          
          // سٹاک لسٹ
          Expanded(
            child: filteredStock.isEmpty
                ? const Center(child: Text('کوئی سٹاک موجود نہیں', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)))
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: filteredStock.length,
                    itemBuilder: (context, index) {
                      final p = filteredStock[index];
                      
                      Color stockColor = Colors.green;
                      String statusText = 'Available';
                      if (p.stockQuantity == 0) { stockColor = Colors.grey; statusText = 'Zero Stock'; }
                      else if (p.stockQuantity < 0) { stockColor = Colors.red; statusText = 'Negative'; }
                      else if (p.lowStockWarning && p.stockQuantity <= p.reorderPoint) { stockColor = Colors.orange; statusText = 'Low Stock'; }

                      return Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Container(
                                width: 5, height: 50,
                                decoration: BoxDecoration(color: stockColor, borderRadius: BorderRadius.circular(10)),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(p.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                    Text('${p.groupName} | Cost: Rs ${p.costPrice} | Sell: Rs ${p.sellingPrice}', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                                    const SizedBox(height: 4),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(color: stockColor.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                                      child: Text(statusText, style: TextStyle(fontSize: 10, color: stockColor, fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('${p.stockQuantity}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: stockColor)),
                                  Text(p.uom, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      // ٹوٹل ویلیو (Total Valuation)
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 10, offset: const Offset(0, -3))]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Total Cost Value', style: TextStyle(fontSize: 12, color: Colors.grey)),
                Text('Rs ${NumberFormat('#,##0').format(totalCostValue)}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: darkGreenText)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text('Total Selling Value', style: TextStyle(fontSize: 12, color: Colors.grey)),
                Text('Rs ${NumberFormat('#,##0').format(totalSellingValue)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}