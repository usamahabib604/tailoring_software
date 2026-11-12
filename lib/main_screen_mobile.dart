import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// تمام مین سکرینز (ٹیلرنگ کے لیے)
import 'new_order_screen.dart'; 
import 'orders_screen.dart'; 
import 'production_screen.dart';
import 'dashboard.dart';
import 'reports_screen.dart';

// ہیمبرگر مینو کی فائلیں (ٹیلرنگ / سسٹم کے لیے)
import 'payments_screen.dart';
import 'users_screen.dart';
import 'settings_screen.dart';
import 'shop_profile_screen.dart';
import 'cloud_sync_screen.dart';
import 'help_guide_screen.dart';
import 'contact_us_screen.dart';

// سٹاف لیجر
import 'staff_ledger_screen.dart'; 

class MainScreenMobile extends StatefulWidget {
  const MainScreenMobile({super.key});

  @override
  State<MainScreenMobile> createState() => _MainScreenMobileState();
}

class _MainScreenMobileState extends State<MainScreenMobile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String shopName = "Your Shop Name"; 
  String shopSubtitle = "Premium Stitching Center";
  String? logoImagePath; 

  final Color parrotGreen = const Color(0xFF7CB342);
  final Color creamColor = const Color(0xFFFFFDD0);
  final Color darkGreenText = const Color(0xFF2E7D32);
  final Color bgColor = const Color(0xFFF5F6F8); 

  @override
  void initState() {
    super.initState();
    _loadShopData();
  }

  Future<void> _loadShopData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      shopName = prefs.getString('shopName') ?? "Your Shop Name";
      shopSubtitle = prefs.getString('shopSubtitle') ?? "Premium Stitching Center";
      logoImagePath = prefs.getString('shopLogo');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: parrotGreen,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white), 
        title: Row(
          children: [
            CircleAvatar(
              radius: 20, 
              backgroundColor: creamColor,
              backgroundImage: logoImagePath != null
                  ? (kIsWeb ? NetworkImage(logoImagePath!) : FileImage(File(logoImagePath!))) as ImageProvider
                  : null,
              child: logoImagePath == null ? Text('MH', style: TextStyle(color: parrotGreen, fontWeight: FontWeight.bold, fontSize: 18)) : null, 
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(shopName, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                  Text(shopSubtitle, style: const TextStyle(color: Colors.white70, fontSize: 11)),
                ],
              ),
            ),
          ],
        ),
      ),
      
      // موبائل کے لیے ٹیلرنگ اور سسٹم کا ہیمبرگر مینو (بائیں طرف سے)
      drawer: Drawer(
        backgroundColor: bgColor, 
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(color: parrotGreen),
              currentAccountPicture: CircleAvatar(
                backgroundColor: creamColor,
                backgroundImage: logoImagePath != null
                    ? (kIsWeb ? NetworkImage(logoImagePath!) : FileImage(File(logoImagePath!))) as ImageProvider
                    : null,
                child: logoImagePath == null ? const Icon(Icons.storefront, size: 40, color: Color(0xFF7CB342)) : null,
              ),
              accountName: Text(shopName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              accountEmail: Text(shopSubtitle, style: const TextStyle(color: Colors.white70)),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(top: 8, bottom: 20),
                children: [
                  _buildModernDrawerItem('Switch Workspace', Icons.swap_horizontal_circle_rounded, const CloudSyncScreen(), color: Colors.purple, isSpecial: true),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: Text('SHOP MANAGEMENT', style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2))),
                  _buildModernDrawerItem('Shop Profile', Icons.store_mall_directory_rounded, const ShopProfileScreen()),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: Text('ACCOUNTS & STAFF', style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2))),
                  _buildModernDrawerItem('Payments', Icons.payment_rounded, const PaymentsScreen()),
                  _buildModernDrawerItem('Staff & Users', Icons.people_alt_rounded, const UsersScreen()),
                  _buildModernDrawerItem('Staff Ledger', Icons.menu_book_rounded, const StaffLedgerScreen(), color: Colors.teal),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: Text('SYSTEM', style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2))),
                  _buildModernDrawerItem('Cloud Sync', Icons.cloud_sync_rounded, const CloudSyncScreen(), color: Colors.blue),
                  _buildModernDrawerItem('Settings', Icons.settings_rounded, const SettingsScreen(), color: Colors.grey.shade700),
                  _buildModernDrawerItem('Help & Guide', Icons.help_outline_rounded, const HelpGuideScreen()),
                  _buildModernDrawerItem('Contact Us', Icons.headset_mic_rounded, const ContactUsScreen()),
                ],
              ),
            ),
            Padding(padding: const EdgeInsets.all(16.0), child: Text('Version 1.0.0 (Mobile)', style: TextStyle(color: Colors.grey.shade500, fontSize: 12))),
          ],
        ),
      ),
      
      // موبائل سکرین کے لیے خالص ٹیلرنگ مینجمنٹ 6 باکسز کا لے آؤٹ
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Text('Tailoring Management System', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: darkGreenText)),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.3,
                children: [
                  _buildGridCard('New Order', 'نیا آرڈر', Icons.add_box_rounded, context, const NewOrderScreen()),
                  _buildGridCard('Customer Search', 'کسٹمر تلاش', Icons.person_search_rounded, context, const OrdersScreen(title: 'کسٹمر سرچ (Customer Search)')),
                  _buildGridCard('Order List', 'آرڈر لسٹ', Icons.receipt_long_rounded, context, const OrdersScreen(title: 'آرڈر لسٹ (Orders List)')),
                  _buildGridCard('Production', 'پروڈکشن بورڈ', Icons.cut_rounded, context, const ProductionScreen()),
                  _buildGridCard('Dashboard', 'ڈیش بورڈ', Icons.dashboard_customize_rounded, context, const Dashboard()),
                  _buildGridCard('Reports', 'رپورٹس', Icons.bar_chart_rounded, context, const ReportsScreen()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernDrawerItem(String title, IconData icon, Widget destination, {Color color = const Color(0xFF7CB342), bool isSpecial = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(color: isSpecial ? color.withOpacity(0.1) : Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: isSpecial ? color : Colors.transparent, width: 1), boxShadow: isSpecial ? [] : [BoxShadow(color: Colors.grey.shade200, blurRadius: 4, offset: const Offset(0, 2))]),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: color.withOpacity(0.15), shape: BoxShape.circle), child: Icon(icon, color: color, size: 22)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87)),
        trailing: Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey.shade400),
        onTap: () {
          Navigator.pop(context); 
          Navigator.push(context, MaterialPageRoute(builder: (context) => destination)).then((_) {
            _loadShopData(); 
            setState(() {}); 
          });
        },
      ),
    );
  }

  Widget _buildGridCard(String title, String urduTitle, IconData icon, BuildContext context, Widget destinationScreen) {
    return Card(
      elevation: 2,
      shadowColor: parrotGreen.withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: parrotGreen, width: 1.2)),
      color: Colors.white,
      child: InkWell(
        onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => destinationScreen)); },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: parrotGreen, shape: BoxShape.circle), child: Icon(icon, size: 26, color: creamColor)),
            const SizedBox(height: 8),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: darkGreenText)),
            const SizedBox(height: 2),
            Text(urduTitle, style: TextStyle(fontSize: 12, color: darkGreenText.withOpacity(0.8), fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}