import 'dart:math';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'models.dart'; 

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final Color parrotGreen = const Color(0xFF7CB342);
  final Color darkGreenText = const Color(0xFF2E7D32);

  void _showAddUserDialog({StaffRecord? existingStaff}) {
    final _formKey = GlobalKey<FormState>();
    final nameController = TextEditingController(text: existingStaff?.name ?? '');
    final phoneController = TextEditingController(text: existingStaff?.phone ?? '');
    
    final cuttingRateController = TextEditingController(text: existingStaff != null ? existingStaff.cuttingRate.toString() : '0');
    final singleStitchController = TextEditingController(text: existingStaff != null ? existingStaff.singleStitchRate.toString() : '0');
    final doubleStitchController = TextEditingController(text: existingStaff != null ? existingStaff.doubleStitchRate.toString() : '0');

    String selectedRole = existingStaff?.role ?? 'Tailor';
    List<String> roles = ['Admin', 'Cutting Master', 'Tailor'];

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            bool isTailor = selectedRole == 'Tailor';
            bool isCuttingMaster = selectedRole == 'Cutting Master';
            
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: Text(existingStaff == null ? 'Add New Staff' : 'Edit Staff Details', style: TextStyle(color: darkGreenText, fontWeight: FontWeight.bold, fontSize: 18)),
              content: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person, color: parrotGreen), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                        validator: (val) => val!.isEmpty ? 'Name is required' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(labelText: 'Mobile Number', prefixIcon: Icon(Icons.phone, color: parrotGreen), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                      ),
                      const SizedBox(height: 12),
                      
                      // ★ Overflow ایرر کو ختم کرنے کے لیے isExpanded: true ★
                      DropdownButtonFormField<String>(
                        isExpanded: true, 
                        value: selectedRole,
                        decoration: InputDecoration(labelText: 'Staff Role', prefixIcon: Icon(Icons.admin_panel_settings, color: parrotGreen), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                        items: roles.map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
                        onChanged: (val) {
                          setDialogState(() => selectedRole = val!);
                        },
                      ),
                      const SizedBox(height: 12),
                      
                      if (isCuttingMaster) ...[
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.orange.shade200)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Set Cutting Rate:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: cuttingRateController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(labelText: 'Cutting Rate per suit (Rs)', isDense: true, border: OutlineInputBorder()),
                              ),
                            ],
                          ),
                        )
                      ],

                      if (isTailor) ...[
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.purple.shade200)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Set Stitching Rates:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple)),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: singleStitchController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(labelText: 'Single Stitch Rate (Rs)', isDense: true, border: OutlineInputBorder()),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: doubleStitchController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(labelText: 'Double Stitch Rate (Rs)', isDense: true, border: OutlineInputBorder()),
                              ),
                            ],
                          ),
                        )
                      ],
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: parrotGreen, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        if (existingStaff == null) {
                          shopStaff.add(
                            StaffRecord(
                              id: DateTime.now().millisecondsSinceEpoch.toString(),
                              name: nameController.text.trim(),
                              role: selectedRole,
                              phone: phoneController.text.trim(),
                              cuttingRate: isCuttingMaster ? (double.tryParse(cuttingRateController.text) ?? 0) : 0,
                              singleStitchRate: isTailor ? (double.tryParse(singleStitchController.text) ?? 0) : 0,
                              doubleStitchRate: isTailor ? (double.tryParse(doubleStitchController.text) ?? 0) : 0,
                              balance: 0.0,
                            )
                          );
                        } else {
                          existingStaff.name = nameController.text.trim();
                          existingStaff.phone = phoneController.text.trim();
                          existingStaff.role = selectedRole;
                          existingStaff.cuttingRate = isCuttingMaster ? (double.tryParse(cuttingRateController.text) ?? 0) : 0;
                          existingStaff.singleStitchRate = isTailor ? (double.tryParse(singleStitchController.text) ?? 0) : 0;
                          existingStaff.doubleStitchRate = isTailor ? (double.tryParse(doubleStitchController.text) ?? 0) : 0;
                        }
                        saveAppData();
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved successfully!'), backgroundColor: Colors.green));
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          }
        );
      },
    );
  }

  void _showLinkDeviceDialog(StaffRecord staff) {
    String linkCode = (Random().nextInt(900000) + 100000).toString();
    String qrData = "SHOP_LINK:${staff.id}:$linkCode";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Column(
          children: [
            Icon(Icons.phonelink_setup, size: 40, color: parrotGreen),
            const SizedBox(height: 8),
            Text('Link ${staff.name}\'s Device', textAlign: TextAlign.center, style: TextStyle(color: darkGreenText, fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Scan this QR code from staff\'s mobile:', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade300)),
              child: QrImageView(data: qrData, version: QrVersions.auto, size: 180.0, backgroundColor: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text('Or enter this code on staff\'s app:', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(color: parrotGreen.withOpacity(0.15), borderRadius: BorderRadius.circular(12), border: Border.all(color: parrotGreen, width: 2)),
              child: Text(linkCode, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 8, color: darkGreenText)),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
        ],
      ),
    );
  }

  void _showPaymentDialog(StaffRecord staff) {
    final amountController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Pay Cash / Advance', style: TextStyle(color: darkGreenText, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Staff: ${staff.name}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount (Rs)', prefixIcon: Icon(Icons.money), border: OutlineInputBorder()),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.teal),
            onPressed: () {
              double payment = double.tryParse(amountController.text) ?? 0.0;
              if (payment > 0) {
                setState(() {
                  staff.balance -= payment;
                  saveAppData();
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment recorded!'), backgroundColor: Colors.green));
              }
            },
            child: const Text('Pay Amount'),
          ),
        ],
      ),
    );
  }

  Color _getRoleColor(String role) {
    if (role == 'Admin') return Colors.blue;
    if (role == 'Cutting Master') return Colors.orange;
    return Colors.purple; // Tailor
  }
  
  IconData _getRoleIcon(String role) {
    if (role == 'Admin') return Icons.admin_panel_settings;
    if (role == 'Cutting Master') return Icons.content_cut;
    return Icons.accessibility_new; // Tailor
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: AppBar(
        title: const Text('Staff & Ledger', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: parrotGreen,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddUserDialog(),
        backgroundColor: parrotGreen,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.person_add),
        label: const Text('Add New Staff', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: shopStaff.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_outline, size: 80, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  Text('No staff members added yet.', style: TextStyle(color: Colors.grey.shade600, fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: shopStaff.length,
              itemBuilder: (context, index) {
                final staff = shopStaff[index];
                Color roleColor = _getRoleColor(staff.role);
                
                bool isAdvance = staff.balance < 0; 
                Color balanceColor = staff.balance == 0 ? Colors.grey : (isAdvance ? Colors.red : Colors.green);
                String balanceStatus = staff.balance == 0 ? 'Clear' : (isAdvance ? 'Advance Taken' : 'Payable by Shop');

                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: Colors.grey.shade200)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(color: roleColor.withOpacity(0.15), shape: BoxShape.circle),
                              child: Icon(_getRoleIcon(staff.role), color: roleColor, size: 28),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(staff.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(color: roleColor.withOpacity(0.1), borderRadius: BorderRadius.circular(4), border: Border.all(color: roleColor)),
                                    child: Text(staff.role, style: TextStyle(color: roleColor, fontSize: 11, fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(staff.phone.isEmpty ? 'No Phone' : staff.phone, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text('Balance', style: TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 2),
                                Text(
                                  '${isAdvance ? "-" : (staff.balance > 0 ? "+" : "")}Rs ${staff.balance.abs().toStringAsFixed(0)}', 
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: balanceColor)
                                ),
                                Text(balanceStatus, style: TextStyle(fontSize: 10, color: balanceColor)),
                              ],
                            ),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Divider()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton.icon(
                              onPressed: () => _showAddUserDialog(existingStaff: staff),
                              icon: const Icon(Icons.edit, size: 18, color: Colors.blue),
                              label: const Text('Edit', style: TextStyle(color: Colors.blue)),
                            ),
                            TextButton.icon(
                              onPressed: () => _showPaymentDialog(staff),
                              icon: const Icon(Icons.money, size: 18, color: Colors.teal),
                              label: const Text('Pay Cash', style: TextStyle(color: Colors.teal)),
                            ),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(backgroundColor: parrotGreen, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                              onPressed: () => _showLinkDeviceDialog(staff),
                              icon: const Icon(Icons.qr_code_scanner, size: 18),
                              label: const Text('Link App'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}