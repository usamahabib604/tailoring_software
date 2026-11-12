import 'dart:math';
import 'package:flutter/material.dart';

class CloudSyncScreen extends StatefulWidget {
  const CloudSyncScreen({super.key});

  @override
  State<CloudSyncScreen> createState() => _CloudSyncScreenState();
}

class _CloudSyncScreenState extends State<CloudSyncScreen> {
  final Color parrotGreen = const Color(0xFF7CB342);
  final Color darkGreenText = const Color(0xFF2E7D32);
  
  bool isSyncing = false;
  String lastSynced = "آج 12:45 PM";

  // فرضی جڑی ہوئی ڈیوائسز (یہ بعد میں فائر بیس سے آئیں گی)
  List<Map<String, String>> linkedDevices = [
    {'name': 'مین کاؤنٹر (This Device)', 'type': 'Mobile', 'status': 'Online'},
    {'name': 'کٹنگ ماسٹر کا موبائل', 'type': 'Mobile', 'status': 'Offline'},
    {'name': 'دکان کا لیپ ٹاپ', 'type': 'Laptop', 'status': 'Online'},
  ];

  // لائیو سنک کا اینیمیشن دکھانے کے لیے
  void _startSync() {
    setState(() {
      isSyncing = true;
    });
    
    // 3 سیکنڈ بعد سنک مکمل ہونے کا میسج
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          isSyncing = false;
          DateTime now = DateTime.now();
          // 12-hour format manually
          int hour = now.hour > 12 ? now.hour - 12 : (now.hour == 0 ? 12 : now.hour);
          String amPm = now.hour >= 12 ? 'PM' : 'AM';
          String minute = now.minute.toString().padLeft(2, '0');
          lastSynced = "آج $hour:$minute $amPm";
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('ڈیٹا کامیابی سے کلاؤڈ پر سنک ہو گیا ہے!'), backgroundColor: Colors.green)
        );
      }
    });
  }

  // نئی ڈیوائس کو جوڑنے کے لیے کوڈ دکھانا
  void _showGenerateCodeDialog() {
    // 6 ہندسوں کا رینڈم کوڈ
    String pairingCode = (Random().nextInt(900000) + 100000).toString();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('نئی ڈیوائس جوڑیں', style: TextStyle(color: darkGreenText, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('اپنے دوسرے موبائل یا لیپ ٹاپ میں ایپ کھولیں اور یہ 6 ہندسوں کا کوڈ درج کریں:', textAlign: TextAlign.center),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: parrotGreen.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: parrotGreen, width: 2),
              ),
              child: Text(pairingCode, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 4, color: darkGreenText)),
            ),
            const SizedBox(height: 20),
            const Text('یہ کوڈ 5 منٹ تک کارآمد ہے۔', style: TextStyle(color: Colors.red, fontSize: 12)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('بند کریں (Close)')),
        ],
      ),
    );
  }

  // دوسری دکان/ڈیوائس کے ساتھ جڑنے کے لیے کوڈ داخل کرنا
  void _showEnterCodeDialog() {
    final codeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('مین ڈیوائس سے جڑیں', style: TextStyle(color: darkGreenText, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('مین موبائل/لیپ ٹاپ پر شو ہونے والا 6 ہندسوں کا کوڈ یہاں درج کریں:', textAlign: TextAlign.center),
            const SizedBox(height: 16),
            TextField(
              controller: codeController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 4, color: darkGreenText),
              decoration: InputDecoration(
                hintText: '000000',
                counterText: '',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: parrotGreen, width: 2)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('منسوخ')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: parrotGreen),
            onPressed: () {
              if (codeController.text.length == 6) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('ڈیوائس کامیابی سے لنک ہو گئی ہے! ڈیٹا لوڈ ہو رہا ہے...'), backgroundColor: Colors.green)
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('براہ کرم درست 6 ہندسوں کا کوڈ درج کریں!'), backgroundColor: Colors.red)
                );
              }
            },
            child: const Text('لنک کریں (Connect)'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: AppBar(
        title: const Text('ڈیٹا سنک (Cloud Sync)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: parrotGreen,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ==============================
          // 1. Cloud Status Card
          // ==============================
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: parrotGreen, width: 1.5)),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  isSyncing 
                    ? const CircularProgressIndicator(color: Color(0xFF7CB342))
                    : Icon(Icons.cloud_done_rounded, size: 70, color: parrotGreen),
                  const SizedBox(height: 12),
                  
                  Text(isSyncing ? 'ڈیٹا کلاؤڈ پر اپلوڈ ہو رہا ہے...' : 'Cloud Synchronization', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkGreenText)),
                  const SizedBox(height: 4),
                  
                  Text(isSyncing ? 'براہ کرم انتظار کریں' : 'آخری بار سنک کیا گیا: $lastSynced', style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                  const Divider(height: 30),
                  
                  // سنک بٹن
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: parrotGreen, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                      onPressed: isSyncing ? null : _startSync,
                      icon: const Icon(Icons.sync),
                      label: const Text('ابھی ڈیٹا سنک کریں (Sync Now)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),

          // ==============================
          // 2. Device Management
          // ==============================
          Text('ڈیوائسز جوڑیں (Device Pairing)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkGreenText)),
          const SizedBox(height: 12),
          
          Row(
            children: [
              Expanded(
                child: _buildActionCard('نئی ڈیوائس\nکوڈ بنائیں', Icons.phonelink_setup, Colors.blue, _showGenerateCodeDialog),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionCard('مین ڈیوائس\nسے جڑیں', Icons.login, Colors.orange, _showEnterCodeDialog),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // ==============================
          // 3. Linked Devices List
          // ==============================
          Text('جڑی ہوئی ڈیوائسز (Linked Devices)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkGreenText)),
          const SizedBox(height: 12),

          ...linkedDevices.map((device) => Card(
            elevation: 1,
            margin: const EdgeInsets.only(bottom: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade300)),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: parrotGreen.withOpacity(0.15), shape: BoxShape.circle),
                child: Icon(device['type'] == 'Mobile' ? Icons.phone_android : Icons.laptop_mac, color: parrotGreen),
              ),
              title: Text(device['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Row(
                children: [
                  Icon(Icons.circle, size: 10, color: device['status'] == 'Online' ? Colors.green : Colors.red),
                  const SizedBox(width: 4),
                  Text(device['status']!, style: TextStyle(color: device['status'] == 'Online' ? Colors.green : Colors.red, fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () {
                  // ڈیوائس ہٹانے کا فرضی ایکشن
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('یہ ڈیوائس ہٹا دی گئی ہے۔')));
                },
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.5), width: 1.5),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2))],
        ),
        child: Column(
          children: [
            Icon(icon, size: 36, color: color),
            const SizedBox(height: 10),
            Text(title, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey.shade800)),
          ],
        ),
      ),
    );
  }
}