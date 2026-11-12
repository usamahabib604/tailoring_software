import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'models.dart';

// ==========================================
// 1. MAIN LEDGER LIST SCREEN (Khata List)
// ==========================================
class StaffLedgerScreen extends StatefulWidget {
  const StaffLedgerScreen({super.key});

  @override
  State<StaffLedgerScreen> createState() => _StaffLedgerScreenState();
}

class _StaffLedgerScreenState extends State<StaffLedgerScreen> {
  final Color parrotGreen = const Color(0xFF7CB342);
  final Color creamColor = const Color(0xFFFFFDD0);
  final Color darkGreenText = const Color(0xFF2E7D32);
  final Color bgColor = const Color(0xFFF5F6F8);
  
  final Color gotColor = const Color(0xFF2E7D32); 
  final Color gaveColor = const Color(0xFFD32F2F);  

  void _showAddAccountDialog() {
    final _formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final infoController = TextEditingController(); 

    final nameFocus = FocusNode();
    final phoneFocus = FocusNode();
    final infoFocus = FocusNode();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: parrotGreen, width: 2)),
        title: Row(
          children: [
            Icon(Icons.person_add_alt_1, color: parrotGreen, size: 28),
            const SizedBox(width: 8),
            Text('Add New Account', style: TextStyle(color: darkGreenText, fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                focusNode: nameFocus,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(phoneFocus),
                decoration: InputDecoration(
                  labelText: 'Name', 
                  prefixIcon: Icon(Icons.person, color: parrotGreen),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (val) => val!.isEmpty ? 'Name is required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: phoneController,
                focusNode: phoneFocus,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(infoFocus),
                decoration: InputDecoration(
                  labelText: 'Mobile Number', 
                  prefixIcon: Icon(Icons.phone, color: parrotGreen),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: infoController,
                focusNode: infoFocus,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: 'Info / Role (e.g., Customer, Supplier)', 
                  prefixIcon: Icon(Icons.info_outline, color: parrotGreen),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (val) => val!.isEmpty ? 'Info is required' : null,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel', style: TextStyle(color: Colors.grey))),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: parrotGreen, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  shopStaff.add(StaffRecord(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: nameController.text.trim(),
                    role: infoController.text.trim(), 
                    phone: phoneController.text.trim(),
                    balance: 0.0,
                  ));
                  saveAppData();
                });
                Navigator.pop(context);
              }
            },
            child: const Text('SAVE', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _deleteAccountDialog(StaffRecord staff) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.red, size: 28),
            SizedBox(width: 8),
            Text('Move to Bin?', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ],
        ),
        content: SingleChildScrollView(
          child: Text('Are you sure you want to delete ${staff.name}\'s account? It will be moved to Recycle Bin.', 
            style: const TextStyle(fontSize: 15)
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                recycleBin.add({
                  'type': 'staff_account',
                  'deletedAt': DateTime.now().toIso8601String(),
                  'data': staff.toJson(),
                });
                shopStaff.removeWhere((e) => e.id == staff.id);
                saveAppData();
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Account moved to Recycle Bin.'), backgroundColor: Colors.red));
            },
            child: const Text('Move to Bin'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('Accounts & Ledger', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: parrotGreen,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddAccountDialog,
        backgroundColor: parrotGreen,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.person_add),
        label: const Text('Add Account', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: shopStaff.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.menu_book_rounded, size: 80, color: parrotGreen.withOpacity(0.3)),
                  const SizedBox(height: 16),
                  Text('No accounts found. Add a new account.', style: TextStyle(color: darkGreenText.withOpacity(0.6), fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: shopStaff.length,
              itemBuilder: (context, index) {
                final staff = shopStaff[index];
                bool isClear = staff.balance == 0;
                bool isAdvance = staff.balance < 0; 
                
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: Colors.grey.shade200)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => LedgerDetailScreen(staff: staff)
                      )).then((_) => setState(() {})); 
                    },
                    onLongPress: () => _deleteAccountDialog(staff),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: parrotGreen.withOpacity(0.15),
                            child: Icon(Icons.person, color: parrotGreen, size: 28),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(staff.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: darkGreenText)),
                                const SizedBox(height: 4),
                                Text(staff.role, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Rs ${staff.balance.abs().toStringAsFixed(0)}', 
                                style: TextStyle(
                                  fontWeight: FontWeight.bold, 
                                  fontSize: 18, 
                                  color: isClear ? Colors.grey.shade700 : (isAdvance ? gaveColor : gotColor)
                                )
                              ),
                              const SizedBox(height: 4),
                              Text(
                                isClear ? 'Clear' : (isAdvance ? 'Advance' : 'Payable'), 
                                style: TextStyle(
                                  fontSize: 10, 
                                  fontWeight: FontWeight.bold,
                                  color: isClear ? Colors.grey.shade500 : (isAdvance ? gaveColor : gotColor)
                                )
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// ==========================================
// 2. DETAIL LEDGER SCREEN (Gave / Got View)
// ==========================================
class LedgerDetailScreen extends StatefulWidget {
  final StaffRecord staff;
  const LedgerDetailScreen({super.key, required this.staff});

  @override
  State<LedgerDetailScreen> createState() => _LedgerDetailScreenState();
}

class _LedgerDetailScreenState extends State<LedgerDetailScreen> {
  final Color parrotGreen = const Color(0xFF7CB342);
  final Color creamColor = const Color(0xFFFFFDD0);
  final Color darkGreenText = const Color(0xFF2E7D32);
  final Color bgColor = const Color(0xFFF5F6F8);
  final Color gotColor = const Color(0xFF2E7D32); 
  final Color gaveColor = const Color(0xFFD32F2F);  

  void _showEntryDialog(bool isPaymentGiven, {LedgerEntry? existingEntry}) {
    final isEditing = existingEntry != null;
    final amountController = TextEditingController(
      text: isEditing ? (existingEntry.gaveAmount > 0 ? existingEntry.gaveAmount.toStringAsFixed(0) : existingEntry.gotAmount.toStringAsFixed(0)) : ''
    );
    final detailsController = TextEditingController(text: isEditing ? existingEntry.description : '');
    
    final amountFocus = FocusNode();
    final detailsFocus = FocusNode();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: parrotGreen, width: 2)),
        title: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: isPaymentGiven ? gaveColor.withOpacity(0.1) : gotColor.withOpacity(0.1), shape: BoxShape.circle),
              child: Icon(
                isPaymentGiven ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded, 
                color: isPaymentGiven ? gaveColor : gotColor, 
                size: 32
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isEditing ? (isPaymentGiven ? 'Edit Gave Entry' : 'Edit Got Entry') : (isPaymentGiven ? 'You Gave' : 'You Got / Work Done'), 
              style: TextStyle(color: isPaymentGiven ? gaveColor : gotColor, fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: amountController,
              focusNode: amountFocus,
              autofocus: true,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => FocusScope.of(context).requestFocus(detailsFocus),
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: darkGreenText),
              decoration: InputDecoration(
                labelText: 'Amount (Rs)', 
                labelStyle: TextStyle(color: parrotGreen),
                prefixIcon: Icon(Icons.money, color: parrotGreen), 
                filled: true,
                fillColor: creamColor.withOpacity(0.3),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: parrotGreen)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: parrotGreen.withOpacity(0.5))),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: parrotGreen, width: 2)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: detailsController,
              focusNode: detailsFocus,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: 'Details / Description', 
                labelStyle: TextStyle(color: parrotGreen),
                prefixIcon: Icon(Icons.edit_note, color: parrotGreen), 
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: parrotGreen.withOpacity(0.5))),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: parrotGreen, width: 2)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel', style: TextStyle(color: Colors.grey))),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: isPaymentGiven ? gaveColor : parrotGreen,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)
            ),
            onPressed: () {
              double amount = double.tryParse(amountController.text) ?? 0.0;
              if (amount > 0) {
                setState(() {
                  if (isEditing) {
                    if (existingEntry.gaveAmount > 0) {
                      widget.staff.balance += existingEntry.gaveAmount;
                    } else if (existingEntry.gotAmount > 0) {
                      widget.staff.balance -= existingEntry.gotAmount;
                    }

                    existingEntry.description = detailsController.text.trim().isEmpty ? (isPaymentGiven ? 'Cash Paid' : 'Work Done') : detailsController.text.trim();
                    existingEntry.gaveAmount = isPaymentGiven ? amount : 0.0;
                    existingEntry.gotAmount = isPaymentGiven ? 0.0 : amount;

                    if (isPaymentGiven) {
                      widget.staff.balance -= amount;
                    } else {
                      widget.staff.balance += amount;
                    }
                  } else {
                    widget.staff.ledger.insert(0, LedgerEntry(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      date: DateTime.now(),
                      description: detailsController.text.trim().isEmpty ? (isPaymentGiven ? 'Cash Paid' : 'Work Done') : detailsController.text.trim(),
                      gaveAmount: isPaymentGiven ? amount : 0.0,
                      gotAmount: isPaymentGiven ? 0.0 : amount,
                      isAutoEntry: false, 
                    ));
                    
                    if (isPaymentGiven) {
                      widget.staff.balance -= amount;
                    } else {
                      widget.staff.balance += amount;
                    }
                  }
                  saveAppData();
                });
                Navigator.pop(context);
              }
            },
            child: Text(isEditing ? 'UPDATE ENTRY' : 'SAVE ENTRY', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showEntryOptions(LedgerEntry entry) {
    if (entry.isAutoEntry) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Auto entry cannot be edited or deleted from here.'), backgroundColor: Colors.orange));
      return;
    }

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Manage Entry', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkGreenText)),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.blue),
              title: const Text('Edit Entry', style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
                bool isGiven = entry.gaveAmount > 0;
                _showEntryDialog(isGiven, existingEntry: entry);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Delete / Move to Bin', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _deleteEntryDialog(entry);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _deleteEntryDialog(LedgerEntry entry) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.red, size: 28),
            SizedBox(width: 8),
            Text('Move to Bin?', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ],
        ),
        content: const Text('Do you want to move this entry to Recycle Bin? The balance will be adjusted automatically.', style: TextStyle(fontSize: 15)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                recycleBin.add({
                  'type': 'ledger_entry',
                  'deletedAt': DateTime.now().toIso8601String(),
                  'staffName': widget.staff.name,
                  'data': entry.toJson(),
                });

                if (entry.gaveAmount > 0) {
                  widget.staff.balance += entry.gaveAmount; 
                } else if (entry.gotAmount > 0) {
                  widget.staff.balance -= entry.gotAmount;  
                }
                widget.staff.ledger.removeWhere((e) => e.id == entry.id);
                saveAppData();
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Entry moved to Recycle Bin and ledger updated.'), backgroundColor: Colors.red));
            },
            child: const Text('Move to Bin'),
          ),
        ],
      ),
    );
  }

  void _showReportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.bar_chart_rounded, color: parrotGreen),
            const SizedBox(width: 8),
            Text('${widget.staff.name} Report', style: TextStyle(color: darkGreenText, fontWeight: FontWeight.bold)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Role: ${widget.staff.role}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Phone: ${widget.staff.phone.isEmpty ? "N/A" : widget.staff.phone}'),
            const SizedBox(height: 8),
            Text('Total Transactions: ${widget.staff.ledger.length}'),
            const SizedBox(height: 8),
            Text('Current Balance: Rs ${widget.staff.balance.toStringAsFixed(0)}', 
              style: TextStyle(fontWeight: FontWeight.bold, color: widget.staff.balance < 0 ? gaveColor : gotColor)
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: const Text('Close', style: TextStyle(color: Colors.grey))
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: parrotGreen),
            onPressed: () {
              Navigator.pop(context);
              _generateAndSharePdf(); 
            },
            child: const Text('Convert to PDF'),
          ),
        ],
      ),
    );
  }

  // ★ سیفٹی کے لیے فلٹر موجود رہے گا لیکن اب کریش کا چانس زیرو ہے ★
  String sanitizeUrdu(String input) {
    if (input.isEmpty) return input;
    return input
        .replaceAll('\uFB90', '\u06A9')
        .replaceAll('\uFB8E', '\u06A9')
        .replaceAll('\uFB8F', '\u06A9')
        .replaceAll('\uFB91', '\u06A9')
        .replaceAll('\u0643', '\u06A9')
        .replaceAll('\uFEEB', '\u06D2')
        .replaceAll('\uFEEA', '\u06D2');
  }

  // ★ ڈائریکٹ اور محفوظ طریقہ (لوکل فولڈر والے فونٹ کا چکر ختم) ★
  Future<void> _generateAndSharePdf() async {
    try {
      final pdf = pw.Document();

      // براہ راست انٹرنیٹ سے گوگل کا صاف ستھرا فونٹ استعمال کر رہے ہیں جو کبھی کریش نہیں ہوتا
      final urduFont = await PdfGoogleFonts.notoNaskhArabicRegular();

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          theme: pw.ThemeData.withFont(base: urduFont, bold: urduFont),
          textDirection: pw.TextDirection.rtl,
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'TAILORING SHOP LEDGER REPORT', 
                  style: pw.TextStyle(font: urduFont, fontSize: 20, fontWeight: pw.FontWeight.bold)
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  sanitizeUrdu('نام: ${widget.staff.name}\nرول: ${widget.staff.role}\nفون: ${widget.staff.phone}\nبقایا بیلنس: Rs ${widget.staff.balance.toStringAsFixed(0)}'), 
                  style: pw.TextStyle(font: urduFont, fontSize: 14)
                ),
                pw.Divider(thickness: 2),
                pw.SizedBox(height: 10),
                pw.Table.fromTextArray(
                  headers: [
                    sanitizeUrdu('ملا (Got)'), 
                    sanitizeUrdu('دیا (Gave)'), 
                    sanitizeUrdu('تفصیل (Description)'), 
                    sanitizeUrdu('تاریخ (Date)')
                  ],
                  headerStyle: pw.TextStyle(
                    font: urduFont, 
                    color: PdfColors.white, 
                    fontWeight: pw.FontWeight.bold,
                  ),
                  headerDecoration: const pw.BoxDecoration(color: PdfColor.fromInt(0xFF7CB342)),
                  cellStyle: pw.TextStyle(font: urduFont, fontSize: 12),
                  cellAlignment: pw.Alignment.centerRight,
                  data: widget.staff.ledger.map((e) => [
                    e.gotAmount > 0 ? e.gotAmount.toStringAsFixed(0) : '-',
                    e.gaveAmount > 0 ? e.gaveAmount.toStringAsFixed(0) : '-',
                    sanitizeUrdu(e.description),
                    DateFormat('dd/MM/yyyy').format(e.date),
                  ]).toList(),
                ),
              ],
            );
          },
        ),
      );

      await Printing.sharePdf(bytes: await pdf.save(), filename: '${widget.staff.name}_ledger.pdf');
      
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('ایرر: پی ڈی ایف بناتے وقت مسئلہ پیش آیا ہے۔\n$e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 6),
          )
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.staff.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
            Text(widget.staff.role, style: TextStyle(color: creamColor, fontSize: 12)),
          ],
        ),
        backgroundColor: parrotGreen,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart_rounded),
            onPressed: _showReportDialog,
            tooltip: 'View Report',
          ),
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: _generateAndSharePdf,
            tooltip: 'Download / Share PDF',
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: parrotGreen.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 4))],
              border: Border.all(color: parrotGreen, width: 1.5)
            ),
            child: Column(
              children: [
                Text('NET BALANCE', style: TextStyle(fontSize: 12, color: darkGreenText.withOpacity(0.7), fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                const SizedBox(height: 8),
                Text(
                  'Rs ${widget.staff.balance.abs().toStringAsFixed(0)}', 
                  style: TextStyle(
                    fontSize: 40, 
                    fontWeight: FontWeight.bold, 
                    color: widget.staff.balance == 0 ? darkGreenText : (widget.staff.balance < 0 ? gaveColor : gotColor)
                  )
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: widget.staff.balance == 0 ? creamColor : (widget.staff.balance < 0 ? gaveColor.withOpacity(0.1) : gotColor.withOpacity(0.1)),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: widget.staff.balance == 0 ? parrotGreen : Colors.transparent)
                  ),
                  child: Text(
                    widget.staff.balance == 0 ? 'Account Clear' : (widget.staff.balance < 0 ? 'Advance' : 'Payable'), 
                    style: TextStyle(
                      fontSize: 12, 
                      fontWeight: FontWeight.bold,
                      color: widget.staff.balance == 0 ? darkGreenText : (widget.staff.balance < 0 ? gaveColor : gotColor)
                    )
                  ),
                ),
              ],
            ),
          ),
          
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(color: creamColor, border: Border.symmetric(horizontal: BorderSide(color: parrotGreen.withOpacity(0.3)))),
            child: Row(
              children: [
                Expanded(flex: 2, child: Text('Date & Details', style: TextStyle(fontWeight: FontWeight.bold, color: darkGreenText, fontSize: 12))),
                Expanded(flex: 1, child: Text('GAVE', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, color: gaveColor, fontSize: 12))),
                Expanded(flex: 1, child: Text('GOT', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, color: gotColor, fontSize: 12))),
              ],
            ),
          ),

          Expanded(
            child: widget.staff.ledger.isEmpty
                ? Center(child: Text('No entries yet.', style: TextStyle(color: darkGreenText.withOpacity(0.5), fontWeight: FontWeight.bold)))
                : ListView.separated(
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: widget.staff.ledger.length,
                    separatorBuilder: (context, index) => Divider(height: 1, color: parrotGreen.withOpacity(0.2)),
                    itemBuilder: (context, index) {
                      final entry = widget.staff.ledger[index];
                      return InkWell(
                        onTap: () => _showEntryOptions(entry),
                        onLongPress: () => _showEntryOptions(entry),
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(DateFormat('dd MMM yyyy, hh:mm a').format(entry.date), style: TextStyle(fontSize: 11, color: darkGreenText.withOpacity(0.6), fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 6),
                                    Text(entry.description, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: darkGreenText)),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                  decoration: BoxDecoration(color: entry.gaveAmount > 0 ? gaveColor.withOpacity(0.05) : Colors.transparent, borderRadius: BorderRadius.circular(4)),
                                  child: Text(
                                    entry.gaveAmount > 0 ? entry.gaveAmount.toStringAsFixed(0) : '-', 
                                    textAlign: TextAlign.right, 
                                    style: TextStyle(color: entry.gaveAmount > 0 ? gaveColor : Colors.grey, fontWeight: FontWeight.bold, fontSize: 15)
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                  decoration: BoxDecoration(color: entry.gotAmount > 0 ? gotColor.withOpacity(0.05) : Colors.transparent, borderRadius: BorderRadius.circular(4)),
                                  child: Text(
                                    entry.gotAmount > 0 ? entry.gotAmount.toStringAsFixed(0) : '-', 
                                    textAlign: TextAlign.right, 
                                    style: TextStyle(color: entry.gotAmount > 0 ? gotColor : Colors.grey, fontWeight: FontWeight.bold, fontSize: 15)
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: parrotGreen.withOpacity(0.15), blurRadius: 10, offset: const Offset(0, -5))],
          ),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 54,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: gaveColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.remove_circle_outline, size: 22),
                    label: const Text('GAVE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1)),
                    onPressed: () => _showEntryDialog(true), 
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 54,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: parrotGreen,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.add_circle_outline, size: 22),
                    label: const Text('GOT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1)),
                    onPressed: () => _showEntryDialog(false), 
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}