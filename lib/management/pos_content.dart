import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

// یہاں AppData کو امپورٹ کریں تاکہ پروڈکٹ لسٹ مل سکے۔
// اگر ProductsContent والی کلاس اور AppData ایک الگ فائل 'products_content.dart' میں ہیں 
// تو نیچے دی گئی لائن کو ان کمنٹ (uncomment) کر کے اپنی فائل کا نام لکھ لیں۔
// import 'products_content.dart'; 

class PosContent extends StatefulWidget {
  const PosContent({super.key});

  @override
  State<PosContent> createState() => _PosContentState();
}

class _PosContentState extends State<PosContent> {
  final Color parrotGreen = const Color(0xFF7CB342);
  final Color darkGreenText = const Color(0xFF2E7D32);
  
  final TextEditingController searchCtrl = TextEditingController();
  
  List<Map<String, String>> searchResults = [];
  List<Map<String, dynamic>> cartItems = [];

  void _searchProduct(String query) {
    if (query.isEmpty) {
      setState(() {
        searchResults = [];
      });
      return;
    }
    setState(() {
      searchResults = AppData.productsList.where((p) {
        String name = p['name']?.toLowerCase() ?? '';
        String code = p['code']?.toLowerCase() ?? '';
        return name.contains(query.toLowerCase()) || code.contains(query.toLowerCase());
      }).toList();
    });
  }

  void _addToCart(Map<String, String> product) {
    setState(() {
      int existingIndex = cartItems.indexWhere((item) => item['code'] == product['code']);
      
      if (existingIndex != -1) {
        cartItems[existingIndex]['qty']++;
      } else {
        cartItems.add({
          'code': product['code'],
          'name': product['name'] ?? 'Unknown',
          'price': double.tryParse(product['price'] ?? '0') ?? 0.0,
          'qty': 1,
        });
      }
      searchCtrl.clear();
      searchResults.clear();
    });
  }

  double get _cartTotal {
    return cartItems.fold(0, (sum, item) => sum + (item['price'] * item['qty']));
  }

  // =========================================================
  // اصل انوائس / بل (PDF) بنانے اور پرنٹ کرنے کا فنکشن
  // =========================================================
  Future<void> _generateAndPrintInvoice() async {
    final pdf = pw.Document();
    
    // موجودہ تاریخ اور وقت حاصل کرنے کے لیے
    String currentDate = "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}  ${DateTime.now().hour}:${DateTime.now().minute}";

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4, // آپ چاہیں تو اسے چھوٹا بھی کر سکتے ہیں (مثلاً a5)
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // دکان کا نام اور ہیڈر
              pw.Center(
                child: pw.Text('MH CLOTHES AND STITCHING CENTRE', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              ),
              pw.SizedBox(height: 5),
              pw.Center(
                child: pw.Text('Point of Sale Invoice', style: const pw.TextStyle(fontSize: 16)),
              ),
              pw.SizedBox(height: 20),
              
              // تاریخ
              pw.Text('Date & Time: $currentDate', style: const pw.TextStyle(fontSize: 12)),
              pw.SizedBox(height: 15),
              
              // بل کے آئٹمز کا ٹیبل
              pw.Table.fromTextArray(
                context: context,
                border: pw.TableBorder.all(color: PdfColors.grey400, width: 1),
                headerDecoration: const pw.BoxDecoration(color: PdfColors.grey200),
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12),
                cellStyle: const pw.TextStyle(fontSize: 12),
                data: <List<String>>[
                  ['Item / Product', 'Qty', 'Unit Price', 'Total'], // ٹیبل کی ہیڈنگ
                  ...cartItems.map((item) => [
                    item['name'].toString(),
                    item['qty'].toString(),
                    'Rs. ${item['price']}',
                    'Rs. ${item['price'] * item['qty']}',
                  ]),
                ],
              ),
              
              pw.SizedBox(height: 20),
              
              // گرینڈ ٹوٹل
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text('Grand Total: ', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                  pw.Text('Rs. ${_cartTotal.toStringAsFixed(2)}', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                ]
              ),
              
              pw.SizedBox(height: 40),
              pw.Divider(),
              pw.Center(
                child: pw.Text('Thank you for shopping with us!', style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey700)),
              )
            ],
          );
        },
      ),
    );

    // پی ڈی ایف کو پرنٹ کرنے یا سیو کرنے والی ونڈو اوپن کرنا
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      name: 'Invoice_MH_Stitching.pdf',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Point of Sale', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  
                  TextField(
                    controller: searchCtrl,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Search product by name or code to add to bill...',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: _searchProduct,
                  ),
                  const SizedBox(height: 16),
                  
                  Expanded(
                    child: searchResults.isEmpty && searchCtrl.text.isNotEmpty
                        ? const Center(child: Text('No product found!'))
                        : ListView.builder(
                            itemCount: searchResults.length,
                            itemBuilder: (context, index) {
                              var prod = searchResults[index];
                              return Card(
                                child: ListTile(
                                  leading: const Icon(Icons.shopping_bag, color: Colors.blueGrey),
                                  title: Text(prod['name'] ?? ''),
                                  subtitle: Text('Code: ${prod['code']}'),
                                  trailing: Text('Rs. ${prod['price']}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                                  onTap: () => _addToCart(prod),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
          
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    color: darkGreenText,
                    child: const Text('Current Bill', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                  const SizedBox(height: 10),
                  
                  Expanded(
                    child: cartItems.isEmpty
                        ? const Center(child: Text('Bill is empty'))
                        : ListView.builder(
                            itemCount: cartItems.length,
                            itemBuilder: (context, index) {
                              var item = cartItems[index];
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(child: Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold))),
                                      Text('Rs. ${item['price']} x ${item['qty']}'),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () => setState(() => cartItems.removeAt(index)),
                                        child: const Icon(Icons.delete, color: Colors.red, size: 18),
                                      ),
                                      Text('Total: Rs. ${item['price'] * item['qty']}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  const Divider(),
                                ],
                              );
                            },
                          ),
                  ),
                  
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total Amount:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            Text('Rs. ${_cartTotal.toStringAsFixed(2)}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: darkGreenText)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: parrotGreen),
                            onPressed: cartItems.isEmpty ? null : () async {
                              // جیسے ہی بٹن دبائیں گے تو پی ڈی ایف پرنٹ والا فنکشن کال ہوگا
                              await _generateAndPrintInvoice();
                              
                              // انوائس پرنٹ / سیو ہونے کے بعد بل کی سکرین خالی کر دی جائے گی
                              setState(() {
                                cartItems.clear();
                              });
                            },
                            child: const Text('PAY & GENERATE BILL', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}