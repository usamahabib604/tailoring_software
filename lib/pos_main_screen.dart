import 'package:flutter/material.dart';

// یہاں ہم نے تینوں نئی سکرینز کو امپورٹ کر لیا ہے
import 'pos_products_screen.dart';
import 'pos_stock_screen.dart';
import 'pos_reports_screen.dart';

class PosMainScreen extends StatefulWidget {
  const PosMainScreen({super.key});

  @override
  State<PosMainScreen> createState() => _PosMainScreenState();
}

class _PosMainScreenState extends State<PosMainScreen> {
  final Color parrotGreen = const Color(0xFF7CB342);
  final Color creamColor = const Color(0xFFFFFDD0);
  final Color darkGreenText = const Color(0xFF2E7D32);
  final Color bgColor = const Color(0xFFF5F6F8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('Point of Sale (POS)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1)),
        backgroundColor: parrotGreen,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('POS Dashboard', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: darkGreenText)),
              const SizedBox(height: 8),
              Text('Manage your products, track live stock, and generate reports.', style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
              const SizedBox(height: 32),

              // ==========================================
              // 1. Products Management Button
              // ==========================================
              _buildPosMenuCard(
                title: '1. Products',
                subtitle: 'Manage Groups, Subgroups & Product Items (4-Tabs)',
                icon: Icons.inventory_2_rounded,
                color: Colors.blue.shade600,
                onTap: () {
                  // اب یہاں سے Products کی سکرین کھلے گی
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PosProductsScreen()));
                },
              ),
              
              // ==========================================
              // 2. Stock Management Button
              // ==========================================
              _buildPosMenuCard(
                title: '2. Stock',
                subtitle: 'View Live Stock, Filters & Valuation (Cost & Selling)',
                icon: Icons.storefront_rounded,
                color: Colors.orange.shade600,
                onTap: () {
                  // اب یہاں سے Stock کی سکرین کھلے گی
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PosStockScreen()));
                },
              ),

              // ==========================================
              // 3. Reports Button
              // ==========================================
              _buildPosMenuCard(
                title: '3. Reports',
                subtitle: 'Print & PDF Reports for Groups, Stock & Values',
                icon: Icons.analytics_rounded,
                color: Colors.purple.shade600,
                onTap: () {
                  // اب یہاں سے Reports کی سکرین کھلے گی
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PosReportsScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Khubsurat Menu Buttons Banane Ka Function
  Widget _buildPosMenuCard({required String title, required String subtitle, required IconData icon, required Color color, required VoidCallback onTap}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      elevation: 3,
      shadowColor: color.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), 
        side: BorderSide(color: color.withOpacity(0.2), width: 1.5)
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
                child: Icon(icon, size: 36, color: color),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
                    const SizedBox(height: 6),
                    Text(subtitle, style: TextStyle(fontSize: 13, color: Colors.grey.shade600, height: 1.3)),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey.shade400, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}