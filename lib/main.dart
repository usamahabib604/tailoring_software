import 'package:flutter/foundation.dart'; // کسٹم پلیٹ فارم چیک کے لیے (kIsWeb وغیرہ)
import 'package:flutter/material.dart';

// ★ Isar اور Path Provider کے امپورٹس ★
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'main_screen_windows.dart'; // ونڈوز کے لیے الگ فائل
import 'main_screen_mobile.dart';  // موبائل کے لیے الگ فائل
import 'models.dart'; // ماڈل اور loadAppData کے لیے

// ★ Isar کا گلوبل ویری ایبل جو پوری ایپ میں استعمال ہوگا ★
Isar? isar;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // ★ Isar ڈیٹا بیس کو اوپن کرنے کا کوڈ (صرف ڈیسک ٹاپ/موبائل پر، ویب/Chrome پر نہیں) ★
  if (!kIsWeb) {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [
        StaffRecordSchema, 
        CustomerRecordSchema, 
        ExpenseRecordSchema, 
        PosGroupSchema, 
        PosProductSchema, 
        InvoiceRecordSchema
      ],
      directory: dir.path,
    );
  }

  // ایپ شروع ہونے سے پہلے سارا پرانا سیو شدہ ڈیٹا (SharedPreferences والا) لوڈ کریں
  await loadAppData();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tailoring & POS Software',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF7CB342)),
        useMaterial3: true,
      ),
      // ★ اگر Chrome (Web) ہے یا موبائل سائز سکرین ہے تو موبائل سکرین دکھائیں ★
      home: LayoutBuilder(
        builder: (context, constraints) {
          if (kIsWeb ||
              constraints.maxWidth < 900 ||
              defaultTargetPlatform == TargetPlatform.android ||
              defaultTargetPlatform == TargetPlatform.iOS) {
            return const MainScreenMobile();
          }
          return const MainScreenWindows();
        },
      ),
    );
  }
}