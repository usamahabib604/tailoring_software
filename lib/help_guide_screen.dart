import 'package:flutter/material.dart';

class HelpGuideScreen extends StatelessWidget {
  const HelpGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color parrotGreen = const Color(0xFF7CB342);
    final Color darkGreenText = const Color(0xFF2E7D32);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: AppBar(
        title: const Text('استعمال کا طریقہ (Help & Guide)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: parrotGreen,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // اوپر والی ہائی لائٹ
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: parrotGreen.withOpacity(0.12), borderRadius: BorderRadius.circular(12), border: Border.all(color: parrotGreen)),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: darkGreenText, size: 28),
                const SizedBox(width: 12),
                Expanded(child: Text('ایپلیکیشن کو کامیابی سے چلانے کے لیے نیچے دی گئی معلومات کو غور سے پڑھیں۔', style: TextStyle(color: darkGreenText, fontWeight: FontWeight.w600, fontSize: 13))),
              ],
            ),
          ),
          const SizedBox(height: 24),

          Text('عام پوچھے جانے والے سوالات (FAQs)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkGreenText)),
          const SizedBox(height: 12),

          _buildHelpTile('نیا آرڈر کیسے بک کریں؟', 'مین سکرین پر "نیا آرڈر (New Order)" پر کلک کریں، کسٹمر کا نام، موبائل نمبر اور سوٹوں کی تعداد درج کر کے آگے پیمائش لیں۔', Icons.add_box),
          _buildHelpTile('آرڈرز کا سٹیٹس کیسے اپڈیٹ کریں؟', 'پروڈکشن بورڈ میں جائیں۔ وہاں "Cutting, Stitching, Ready" کے آپشنز کے ذریعے باری باری کام کو آگے بڑھائیں۔', Icons.loop),
          _buildHelpTile('ڈیٹا کو لیپ ٹاپ یا کمپیوٹر سے کیسے جوڑیں؟', 'مینیو میں جائیں اور "Data Sync" کے آپشن پر کلک کر کے کمپیوٹر پر شو ہونے والا کوڈ درج کریں۔', Icons.cloud_sync),
          _buildHelpTile('ادھار کھاتہ کہاں سے چیک کریں؟', '"رپورٹس (Reports)" یا "ڈیش بورڈ (Dashboard)" میں جائیں اور "ادھار کھاتہ (Udhaar/Credit)" کے باکس پر کلک کریں۔', Icons.money_off),
          
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildHelpTile(String title, String desc, IconData icon) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        leading: Icon(icon, color: const Color(0xFF7CB342)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(desc, style: TextStyle(color: Colors.grey.shade700, height: 1.5, fontSize: 13)),
          )
        ],
      ),
    );
  }
}