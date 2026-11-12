import 'package:flutter/material.dart';

// ★ تمام الگ الگ سکرینز کی فائلز کو امپورٹ کرنا ★
import 'management/dashboard_content.dart';
import 'management/documents_content.dart';
import 'management/products_content.dart';
import 'management/stock_content.dart';
import 'management/reporting_content.dart';
import 'management/customers_content.dart';
import 'management/payment_types_content.dart';
import 'management/my_company_content.dart';

class PosManagementScreen extends StatefulWidget {
  const PosManagementScreen({super.key});

  @override
  State<PosManagementScreen> createState() => _PosManagementScreenState();
}

class _PosManagementScreenState extends State<PosManagementScreen> {
  final Color parrotGreen = const Color(0xFF7CB342);
  final Color darkGreenText = const Color(0xFF2E7D32);
  final Color bgColor = const Color(0xFFF5F6F8);

  String selectedMenu = 'Dashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          // 1. Top Title Bar
          Container(
            height: 50,
            color: parrotGreen,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Tooltip(
                  message: 'Close',
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_back, color: Colors.white, size: 22),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Management • $selectedMenu',
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 22),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          ),
          
          // 2. Main Body (Sidebar + Dynamic Routing)
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Left Sidebar ---
                Container(
                  width: 220,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(right: BorderSide(color: Colors.grey.shade300, width: 2)),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          children: [
                            _buildMenuItem('Dashboard', Icons.dashboard_outlined),
                            _buildMenuItem('Documents', Icons.description_outlined),
                            _buildMenuItem('Products', Icons.local_offer_outlined),
                            _buildMenuItem('Price lists', Icons.request_quote_outlined),
                            _buildMenuItem('Stock', Icons.inventory_2_outlined),
                            _buildMenuItem('Reporting', Icons.bar_chart_outlined),
                            _buildMenuItem('Customers & suppliers', Icons.people_outline),
                            _buildMenuItem('Promotions', Icons.favorite_border),
                            _buildMenuItem('Users & security', Icons.vpn_key_outlined),
                            _buildMenuItem('Payment types', Icons.payment_outlined),
                            _buildMenuItem('Countries', Icons.public),
                            _buildMenuItem('Tax rates', Icons.percent),
                            _buildMenuItem('My company', Icons.business),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade200))),
                        child: Icon(Icons.keyboard_double_arrow_left, color: Colors.grey.shade500, size: 20),
                      )
                    ],
                  ),
                ),

                // --- Right Main Content (Auto Switch using Switch/If) ---
                Expanded(
                  child: _buildRightContent(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // سائیڈ بار کے بٹن کا ڈیزائن
  Widget _buildMenuItem(String title, IconData icon) {
    bool isSelected = selectedMenu == title;
    return InkWell(
      onTap: () {
        setState(() {
          selectedMenu = title;
        });
      },
      child: Container(
        color: isSelected ? parrotGreen.withOpacity(0.15) : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? darkGreenText : Colors.grey.shade700, size: 20),
            const SizedBox(width: 12),
            Text(
              title, 
              style: TextStyle(
                color: isSelected ? darkGreenText : Colors.black87, 
                fontSize: 14, 
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500
              )
            ),
          ],
        ),
      ),
    );
  }

  // ★ یہاں تمام فولڈر والی سکرینز آپس میں جڑ رہی ہیں ★
  Widget _buildRightContent() {
    switch (selectedMenu) {
      case 'Dashboard':
        return const DashboardContent();
      case 'Documents':
        return const DocumentsContent();
      case 'Products':
        return const ProductsContent();
      case 'Stock':
        return const StockContent();
      case 'Reporting':
        return const ReportingContent();
      case 'Customers & suppliers':
        return const CustomersContent();
      case 'Payment types':
        return const PaymentTypesContent();
      case 'My company':
        return const MyCompanyContent();
      default:
        return Center(
          child: Text(
            '$selectedMenu Content Here', 
            style: TextStyle(color: darkGreenText, fontSize: 24, fontWeight: FontWeight.bold)
          ),
        );
    }
  }
}