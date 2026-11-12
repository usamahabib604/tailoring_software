import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color parrotGreen = const Color(0xFF7CB342);
    final Color darkGreenText = const Color(0xFF2E7D32);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: AppBar(
        title: const Text('رابطہ کریں (Contact Us)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: parrotGreen,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // اوپر والی ہیڈنگ
          Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Icon(Icons.headset_mic_rounded, size: 70, color: parrotGreen),
                const SizedBox(height: 12),
                Text('کیا آپ کو کسی مدد کی ضرورت ہے؟', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkGreenText)),
                const SizedBox(height: 6),
                Text('ہم چوبیس گھنٹے آپ کی خدمت کے لیے تیار ہیں!', style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // رابطہ کارڈز
          _buildContactCard('ہمیں کال کریں (Call Support)', '0300-1234567', Icons.phone, Colors.blue),
          _buildContactCard('واٹس ایپ چیٹ (WhatsApp Message)', '0300-1234567', Icons.chat, Colors.green),
          _buildContactCard('ای میل بھیجیں (Email Support)', 'support@tailorapp.com', Icons.email, Colors.red),
          _buildContactCard('ہماری ویب سائٹ (Visit Website)', 'www.tailorapp.com', Icons.language, Colors.deepPurple),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildContactCard(String title, String value, IconData icon, Color iconColor) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: iconColor.withOpacity(0.3), width: 1.2)),
      color: Colors.white,
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: iconColor.withOpacity(0.12), shape: BoxShape.circle),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(value, style: TextStyle(color: Colors.grey.shade800, fontWeight: FontWeight.bold, fontSize: 15)),
        trailing: Icon(Icons.arrow_forward_ios_rounded, size: 14, color: iconColor),
        onTap: () {},
      ),
    );
  }
}