import 'package:flutter/material.dart';
import 'models.dart';
import 'orders_screen.dart'; // کسٹمر فولڈر کے لیے

class ProductionScreen extends StatefulWidget {
  const ProductionScreen({super.key});

  @override
  State<ProductionScreen> createState() => _ProductionScreenState();
}

class _ProductionScreenState extends State<ProductionScreen> {

  @override
  Widget build(BuildContext context) {
    final Color parrotGreen = const Color(0xFF7CB342);
    final Color creamColor = const Color(0xFFFFFDD0);
    final Color darkGreenText = const Color(0xFF2E7D32);

    // ہر کیٹیگری کے سوٹس کی تعداد (Counts) نکالنا
    int newOrdersCount = savedCustomers.where((c) => c.status == 'New Order').length;
    int cuttingCount = savedCustomers.where((c) => c.status == 'Cutting').length;
    int stitchingCount = savedCustomers.where((c) => c.status == 'Stitching').length;
    int readyCount = savedCustomers.where((c) => c.status == 'Ready').length;
    int deliveredCount = savedCustomers.where((c) => c.status == 'Delivered').length;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: AppBar(
        title: const Text(
          'پروڈکشن بورڈ (Production Board)',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: parrotGreen,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _buildProductionCard(
            context, 
            'New Orders', 
            'نئے آرڈرز', 
            newOrdersCount, 
            Icons.new_releases_rounded, 
            Colors.blue, 
            parrotGreen, 
            creamColor, 
            'New Order'
          ),
          _buildProductionCard(
            context, 
            'Cutting', 
            'کٹنگ', 
            cuttingCount, 
            Icons.content_cut_rounded, 
            Colors.orange, 
            parrotGreen, 
            creamColor, 
            'Cutting'
          ),
          _buildProductionCard(
            context, 
            'Stitching', 
            'سلائی', 
            stitchingCount, 
            Icons.accessibility_new_rounded, 
            Colors.purple, 
            parrotGreen, 
            creamColor, 
            'Stitching'
          ),
          _buildProductionCard(
            context, 
            'Ready', 
            'تیار سوٹ', 
            readyCount, 
            Icons.check_circle_rounded, 
            Colors.green, 
            parrotGreen, 
            creamColor, 
            'Ready'
          ),
          _buildProductionCard(
            context, 
            'Delivered', 
            'ڈلیور شدہ', 
            deliveredCount, 
            Icons.local_shipping_rounded, 
            Colors.grey.shade700, 
            parrotGreen, 
            creamColor, 
            'Delivered'
          ),
        ],
      ),
    );
  }

  // مین سکرین جیسے خوبصورت کارڈز بنانے کا فنکشن
  Widget _buildProductionCard(
    BuildContext context, 
    String title, 
    String urduTitle, 
    int count, 
    IconData icon, 
    Color accentColor, 
    Color parrotGreen, 
    Color creamColor, 
    String targetStatus
  ) {
    return Card(
      elevation: 2,
      shadowColor: parrotGreen.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: parrotGreen, width: 1.5), 
      ),
      color: Colors.white,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => ProductionDetailListScreen(
                statusFilter: targetStatus, 
                screenTitle: '$urduTitle ($title)'
              )
            ),
          ).then((_) => setState(() {})); // واپس آنے پر کاؤנט ریفریش ہو جائے گا
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: accentColor.withOpacity(0.15), shape: BoxShape.circle),
                    child: Icon(icon, size: 36, color: accentColor), 
                  ),
                  // لائیو نمبر (Count Badge)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(color: accentColor, shape: BoxShape.circle),
                      constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
                      child: Text(
                        '$count',
                        style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: accentColor)),
              const SizedBox(height: 2),
              Text(urduTitle, style: TextStyle(fontSize: 12, color: Colors.grey.shade700, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// کسی بھی باکس کو کھولنے پر اس کی لسٹ شو کرنے والی سکرین
// ============================================================
class ProductionDetailListScreen extends StatefulWidget {
  final String statusFilter;
  final String screenTitle;

  const ProductionDetailListScreen({super.key, required this.statusFilter, required this.screenTitle});

  @override
  State<ProductionDetailListScreen> createState() => _ProductionDetailListScreenState();
}

class _ProductionDetailListScreenState extends State<ProductionDetailListScreen> {

  int _getCustomerVisitCount(String mobile, String name) {
    if (mobile.trim().isEmpty && name.trim().isEmpty) return 1;
    return savedCustomers.where((c) => 
      (mobile.isNotEmpty && c.mobile == mobile) || 
      (name.isNotEmpty && c.name.toLowerCase() == name.toLowerCase())
    ).length;
  }

  @override
  Widget build(BuildContext context) {
    // صرف اس سٹیٹس والے کسٹمرز فلٹر کریں
    final filteredList = savedCustomers.where((c) => c.status == widget.statusFilter).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: AppBar(
        title: Text(widget.screenTitle, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF7CB342),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: filteredList.isEmpty
          ? Center(child: Text('اس کیٹیگری میں کوئی آرڈر موجود نہیں ہے۔', style: TextStyle(color: Colors.grey.shade600, fontSize: 15)))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final customer = filteredList[index];
                int visitCount = _getCustomerVisitCount(customer.mobile, customer.name);

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Color(0xFF7CB342), width: 1.2),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CustomerFolderScreen(
                            customer: customer,
                            visitCount: visitCount,
                          ),
                        ),
                      ).then((_) => setState(() {}));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: const Color(0xFF7CB342),
                                child: Text(customer.tokenNumber, style: const TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    customer.name.isEmpty ? 'Unnamed Customer' : customer.name,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        customer.mobile.isEmpty ? 'N/A' : customer.mobile, 
                                        style: const TextStyle(fontSize: 12, color: Color(0xFF2E7D32), fontWeight: FontWeight.w600)
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '(${customer.quantity} Suits)', 
                                        style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold)
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: customer.status == 'Delivered' ? Colors.grey : const Color(0xFF7CB342),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              customer.status,
                              style: const TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}