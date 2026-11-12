import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:typed_data';
import 'models.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String selectedTimeRange = 'All Time';
  DateTime startDate = DateTime(2020);
  DateTime endDate = DateTime.now();

  final Color parrotGreen = const Color(0xFF7CB342);
  final Color darkGreenText = const Color(0xFF2E7D32);

  String _formatDate(DateTime d) => '${d.day}/${d.month}/${d.year}';

  void _setTimeRange(String range) {
    DateTime now = DateTime.now();
    setState(() {
      selectedTimeRange = range;
      if (range == 'Today') {
        startDate = DateTime(now.year, now.month, now.day);
        endDate = DateTime(now.year, now.month, now.day, 23, 59, 59);
      } else if (range == 'This Week') {
        startDate = now.subtract(Duration(days: now.weekday - 1));
        endDate = now;
      } else if (range == 'This Month') {
        startDate = DateTime(now.year, now.month, 1);
        endDate = now;
      } else if (range == 'This Year') {
        startDate = DateTime(now.year, 1, 1);
        endDate = now;
      } else if (range == 'All Time') {
        startDate = DateTime(2020);
        endDate = now;
      }
    });
  }

  // دو الگ الگ کیلنڈر (Left to Right Swipe والے)
  Future<void> _pickCustomDateRange() async {
    // 1. شروع کی تاریخ کا کیلنڈر
    DateTime? start = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      helpText: 'شروع کی تاریخ منتخب کریں (Start Date)',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: parrotGreen, onPrimary: Colors.white, onSurface: Colors.black),
          ),
          child: child!,
        );
      },
    );

    if (start != null) {
      // 2. ختم ہونے کی تاریخ کا کیلنڈر
      DateTime? end = await showDatePicker(
        context: context,
        initialDate: start,
        firstDate: start,
        lastDate: DateTime(2030),
        helpText: 'ختم ہونے کی تاریخ منتخب کریں (End Date)',
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(primary: parrotGreen, onPrimary: Colors.white, onSurface: Colors.black),
            ),
            child: child!,
          );
        },
      );

      if (end != null) {
        setState(() {
          selectedTimeRange = 'Manual';
          startDate = start;
          endDate = DateTime(end.year, end.month, end.day, 23, 59, 59);
        });
      }
    }
  }

  bool _isDateInRange(DateTime date) {
    return date.isAfter(startDate.subtract(const Duration(seconds: 1))) && 
           date.isBefore(endDate.add(const Duration(seconds: 1)));
  }

  Future<void> _printPDFReport(int newC, int cutC, int stitchC, int readyC, int deliveredC, int totalActive) async {
    try {
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(32),
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Production Dashboard Report', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold, color: PdfColors.green800)),
                    pw.Text('Date: ${_formatDate(DateTime.now())}', style: const pw.TextStyle(fontSize: 12)),
                  ]
                ),
                pw.SizedBox(height: 10),
                pw.Text('Report Range: ${selectedTimeRange == 'All Time' ? 'All Data' : '${_formatDate(startDate)}  to  ${_formatDate(endDate)}'}', style: const pw.TextStyle(fontSize: 14, color: PdfColors.grey700)),
                pw.SizedBox(height: 30),
                
                pw.Text('Production Status (پروڈکشن تفصیل)', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, color: PdfColors.blue800)),
                pw.Divider(),
                pw.SizedBox(height: 10),
                
                _buildPdfRow('New Orders (نئے آرڈرز):', '$newC Suits'),
                _buildPdfRow('In Cutting (کٹنگ ہو گئے):', '$cutC Suits'),
                _buildPdfRow('In Stitching (سلائی مشین پر):', '$stitchC Suits'),
                _buildPdfRow('Ready (تیار سوٹ):', '$readyC Suits'),
                pw.Divider(),
                _buildPdfRow('Total In Process (کل موجود سوٹ):', '$totalActive Suits', isBold: true),
                pw.SizedBox(height: 20),
                
                pw.Text('Delivery Status', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, color: PdfColors.orange800)),
                pw.Divider(),
                _buildPdfRow('Delivered (مکمل ہو چکے):', '$deliveredC Suits', isBold: true),
              ],
            );
          },
        ),
      );

      final Uint8List bytes = await pdf.save();
      await Printing.sharePdf(
        bytes: bytes,
        filename: 'Production_Dashboard_${_formatDate(DateTime.now()).replaceAll('/', '-')}.pdf',
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error generating PDF: $e'), backgroundColor: Colors.red));
      }
    }
  }

  pw.Widget _buildPdfRow(String title, String value, {bool isBold = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 6),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(title, style: pw.TextStyle(fontSize: 14, fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal)),
          pw.Text(value, style: pw.TextStyle(fontSize: 14, fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<CustomerRecord> filteredCustomers = savedCustomers.where((c) {
      return _isDateInRange(c.bookingDate);
    }).toList();

    int newCount = filteredCustomers.where((c) => c.status == 'New Order').length;
    int cutCount = filteredCustomers.where((c) => c.status == 'Cutting').length;
    int stitchCount = filteredCustomers.where((c) => c.status == 'Stitching').length;
    int readyCount = filteredCustomers.where((c) => c.status == 'Ready').length;
    int deliveredCount = filteredCustomers.where((c) => c.status == 'Delivered').length;

    // کل سوٹس جو اس وقت دکان میں موجود ہیں
    int totalInShop = newCount + cutCount + stitchCount + readyCount;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: AppBar(
        backgroundColor: parrotGreen,
        elevation: 0,
        title: const Text(
          'ڈیش بورڈ (Production Status)',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _printPDFReport(newCount, cutCount, stitchCount, readyCount, deliveredCount, totalInShop),
        backgroundColor: parrotGreen,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.picture_as_pdf),
        label: const Text('Export PDF', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          // ==============================
          // سلائیڈنگ ٹائم فلٹر (Horizontal Scroll)
          // ==============================
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('وقت منتخب کریں (Time Filter)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: darkGreenText)),
                    if (selectedTimeRange == 'Manual')
                      Text('${_formatDate(startDate)} - ${_formatDate(endDate)}', style: const TextStyle(color: Colors.grey, fontSize: 11)),
                  ],
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...['Today', 'This Week', 'This Month', 'This Year', 'All Time'].map((range) {
                        bool isSelected = selectedTimeRange == range;
                        String labelText = range == 'Today' ? 'آج (Today)' :
                                         range == 'This Week' ? 'ہفتہ (Week)' :
                                         range == 'This Month' ? 'مہینہ (Month)' :
                                         range == 'This Year' ? 'سال (Year)' : 'سب (All)';
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ChoiceChip(
                            label: Text(labelText),
                            selected: isSelected,
                            onSelected: (val) => _setTimeRange(range),
                            selectedColor: parrotGreen.withOpacity(0.2),
                            labelStyle: TextStyle(color: isSelected ? darkGreenText : Colors.black87, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: isSelected ? parrotGreen : Colors.grey.shade300)),
                          ),
                        );
                      }),
                      ActionChip(
                        avatar: Icon(Icons.date_range, size: 16, color: selectedTimeRange == 'Manual' ? darkGreenText : Colors.grey.shade700),
                        label: Text('Manual (اپنی مرضی)', style: TextStyle(color: selectedTimeRange == 'Manual' ? darkGreenText : Colors.black87, fontWeight: selectedTimeRange == 'Manual' ? FontWeight.bold : FontWeight.normal)),
                        onPressed: _pickCustomDateRange,
                        backgroundColor: selectedTimeRange == 'Manual' ? parrotGreen.withOpacity(0.2) : Colors.grey.shade100,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: selectedTimeRange == 'Manual' ? parrotGreen : Colors.grey.shade300)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),

          // ==============================
          // 6 برابر باکسز (Grid View)
          // ==============================
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(16),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.1,
              children: [
                _buildProductionCard('New Order', 'نئے آرڈرز', '$newCount', Icons.new_releases_rounded, Colors.blue),
                _buildProductionCard('Cutting', 'کٹنگ ہو گئے', '$cutCount', Icons.content_cut_rounded, Colors.orange),
                _buildProductionCard('Stitching', 'سلائی مشین پر', '$stitchCount', Icons.accessibility_new_rounded, Colors.purple),
                _buildProductionCard('Ready', 'تیار (ڈیلیوری کے لیے)', '$readyCount', Icons.check_circle_rounded, Colors.green),
                _buildProductionCard('Delivered', 'مکمل / ڈیلیور ہو چکے', '$deliveredCount', Icons.local_shipping_rounded, Colors.grey.shade700),
                _buildProductionCard('In Process', 'زیرِ تکمیل (کل موجود سوٹ)', '$totalInShop', Icons.inventory_2_rounded, parrotGreen),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 6 باکسز کا ڈیزائن 
  Widget _buildProductionCard(String title, String urduTitle, String count, IconData icon, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: color.withOpacity(0.4), width: 1.5),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: color.withOpacity(0.15), shape: BoxShape.circle),
                  child: Icon(icon, size: 24, color: color),
                ),
                const SizedBox(width: 8),
                Text(count, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: color)),
              ],
            ),
            const SizedBox(height: 10),
            Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey.shade800)),
            const SizedBox(height: 2),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(urduTitle, style: TextStyle(fontSize: 12, color: Colors.grey.shade600, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}