import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_selector/file_selector.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isLoading = false;

  Future<void> _backupData() async {
    setState(() => isLoading = true);
    try {
      final prefs = await SharedPreferences.getInstance();
      
      Map<String, dynamic> backupData = {
        'customers_data': prefs.getStringList('customers_data') ?? [],
        'staff_data': prefs.getStringList('staff_data') ?? [],
        'expenses_data': prefs.getStringList('expenses_data') ?? [],
        'next_token_number': prefs.getInt('next_token_number') ?? 1001,
      };

      String jsonString = jsonEncode(backupData);

      final directory = await getTemporaryDirectory();
      String dateStr = "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}";
      final file = File('${directory.path}/TailorShop_Backup_$dateStr.json');
      
      await file.writeAsString(jsonString);

      setState(() => isLoading = false);

      await Share.shareXFiles(
        [XFile(file.path)], 
        text: 'میری دکان کا بیک اپ ڈیٹا (اسے سنبھال کر رکھیں)'
      );

    } catch (e) {
      setState(() => isLoading = false);
      _showMessage('Backup failed: $e', Colors.red);
    }
  }

  Future<void> _restoreData() async {
    try {
      const XTypeGroup jsonType = XTypeGroup(
        label: 'JSON Backup File',
        extensions: ['json'],
      );
      
      final XFile? file = await openFile(acceptedTypeGroups: [jsonType]);

      if (file != null) {
        setState(() => isLoading = true);
        
        String jsonString = await file.readAsString();
        Map<String, dynamic> backupData = jsonDecode(jsonString);

        final prefs = await SharedPreferences.getInstance();
        
        if (backupData.containsKey('customers_data')) {
          await prefs.setStringList('customers_data', List<String>.from(backupData['customers_data']));
        }
        if (backupData.containsKey('staff_data')) {
          await prefs.setStringList('staff_data', List<String>.from(backupData['staff_data']));
        }
        if (backupData.containsKey('expenses_data')) {
          await prefs.setStringList('expenses_data', List<String>.from(backupData['expenses_data']));
        }
        if (backupData.containsKey('next_token_number')) {
          await prefs.setInt('next_token_number', backupData['next_token_number']);
        }

        await loadAppData();

        setState(() => isLoading = false);
        _showMessage('ماشاءاللہ! ڈیٹا کامیابی سے ری-سٹور ہو گیا ہے۔', Colors.green);
      }
    } catch (e) {
      setState(() => isLoading = false);
      _showMessage('Restore failed! Invalid file or error.', Colors.red);
    }
  }

  void _showMessage(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), backgroundColor: color));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: AppBar(
        title: const Text(
          'سیٹنگز / بیک اپ (Settings)',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF7CB342),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const SizedBox(height: 20),
                const Icon(Icons.security, size: 80, color: Color(0xFF7CB342)),
                const SizedBox(height: 10),
                const Text(
                  'Data Security & Backup',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
                ),
                const Text(
                  'اپنے دکان کے ڈیٹا کو محفوظ رکھیں',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 30),

                Card(
                  elevation: 2,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: const CircleAvatar(backgroundColor: Colors.green, child: Icon(Icons.cloud_upload, color: Colors.white)),
                    title: const Text('Backup Data (ڈیٹا محفوظ کریں)', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text('سارا ڈیٹا واٹس ایپ یا گوگل ڈرائیو پر بھیجیں'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: _backupData,
                  ),
                ),
                const SizedBox(height: 10),

                Card(
                  elevation: 2,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: const CircleAvatar(backgroundColor: Colors.blue, child: Icon(Icons.settings_backup_restore, color: Colors.white)),
                    title: const Text('Restore Data (ڈیٹا واپس لائیں)', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text('پرانی بیک اپ فائل سے ڈیٹا ریکور کریں'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: _restoreData,
                  ),
                ),
                
                const Divider(height: 40),

                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: const CircleAvatar(backgroundColor: Colors.orange, child: Icon(Icons.delete_outline, color: Colors.white)),
                    title: const Text('Dustbin (کوڑے دان)', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange)),
                    subtitle: const Text('غلطی سے ڈیلیٹ کیا ہوا ڈیٹا یہاں سے واپس لائیں'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const DustbinScreen()));
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

class DustbinScreen extends StatelessWidget {
  const DustbinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: AppBar(
        title: const Text(
          'Dustbin (کوڑے دان)',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF7CB342),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.delete_outline, size: 120, color: Colors.grey),
            SizedBox(height: 20),
            Text(
              'آپ کا ڈسٹ بن ابھی خالی ہے',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            SizedBox(height: 10),
            Text(
              'آئندہ جو کسٹمر یا سوٹ آپ ڈیلیٹ کریں گے\nوہ ہمیشہ کے لیے ختم ہونے کے بجائے پہلے یہاں آئے گا۔',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}