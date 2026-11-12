import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopProfileScreen extends StatefulWidget {
  const ShopProfileScreen({super.key});

  @override
  State<ShopProfileScreen> createState() => _ShopProfileScreenState();
}

class _ShopProfileScreenState extends State<ShopProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final Color parrotGreen = const Color(0xFF7CB342);
  final Color darkGreenText = const Color(0xFF2E7D32);

  // ان پٹ فیلڈز کو کنٹرول کرنے کے لیے Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  String? logoPath;

  @override
  void initState() {
    super.initState();
    _loadProfileData(); // سکرین کھلتے ہی پرانا سیو شدہ ڈیٹا لے آؤ
  }

  // ڈیٹا بیس (SharedPreferences) سے ڈیٹا نکالنے کا فنکشن
  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nameController.text = prefs.getString('shopName') ?? "آپ کی دکان کا نام";
      subtitleController.text = prefs.getString('shopSubtitle') ?? "Premium Stitching Center";
      addressController.text = prefs.getString('shopAddress') ?? "";
      phoneController.text = prefs.getString('shopPhone') ?? "";
      emailController.text = prefs.getString('shopEmail') ?? "";
      logoPath = prefs.getString('shopLogo');
    });
  }

  // گیلری سے تصویر (لوگو) سلیکٹ کرنے کا فنکشن
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      setState(() {
        logoPath = image.path;
      });
    }
  }

  // ڈیٹا کو پکا سیو کرنے کا فنکشن
  Future<void> _saveProfileData() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('shopName', nameController.text);
      await prefs.setString('shopSubtitle', subtitleController.text);
      await prefs.setString('shopAddress', addressController.text);
      await prefs.setString('shopPhone', phoneController.text);
      await prefs.setString('shopEmail', emailController.text);
      
      if (logoPath != null) {
        await prefs.setString('shopLogo', logoPath!);
      }
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('پروفائل کامیابی سے محفوظ ہو گئی!'), backgroundColor: Colors.green)
        );
        Navigator.pop(context); // سیو کرنے کے بعد واپس مین سکرین پر بھیج دو
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: AppBar(
        title: const Text('دکان کی پروفائل (Shop Profile)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: parrotGreen,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // لوگو اپلوڈ
            Center(
              child: GestureDetector(
                onTap: _pickImage, // تصویر پر کلک کرنے سے گیلری کھلے گی
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: parrotGreen.withOpacity(0.15),
                      backgroundImage: logoPath != null
                          ? (kIsWeb ? NetworkImage(logoPath!) : FileImage(File(logoPath!))) as ImageProvider
                          : null,
                      child: logoPath == null ? Icon(Icons.storefront, size: 60, color: parrotGreen) : null,
                    ),
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: parrotGreen,
                      child: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(child: Text('تصویر بدلنے کے لیے کلک کریں', style: TextStyle(fontSize: 12, color: Colors.grey.shade600, fontWeight: FontWeight.bold))),
            const SizedBox(height: 24),

            _buildInputCard('دکان کا نام (Shop Name)', nameController, Icons.store, TextInputType.text),
            _buildInputCard('سب ٹائٹل (Subtitle)', subtitleController, Icons.subtitles, TextInputType.text),
            _buildInputCard('ایڈریس (Shop Address)', addressController, Icons.location_on, TextInputType.streetAddress),
            _buildInputCard('موبائل نمبر (Phone Number)', phoneController, Icons.phone, TextInputType.phone),
            _buildInputCard('ای میل (Email ID)', emailController, Icons.email, TextInputType.emailAddress),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: parrotGreen, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                onPressed: _saveProfileData,
                icon: const Icon(Icons.save),
                label: const Text('پروفائل محفوظ کریں (Save Profile)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildInputCard(String label, TextEditingController controller, IconData icon, TextInputType keyType) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: parrotGreen.withOpacity(0.4), width: 1.5)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: TextFormField(
          controller: controller,
          keyboardType: keyType,
          decoration: InputDecoration(
            icon: Icon(icon, color: parrotGreen),
            labelText: label,
            labelStyle: TextStyle(color: darkGreenText, fontWeight: FontWeight.bold, fontSize: 14),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}