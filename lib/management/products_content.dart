import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_selector/file_selector.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../models.dart'; // آپ کے ماڈل کا صحیح پاتھ

class ProductsContent extends StatefulWidget {
  const ProductsContent({super.key});

  @override
  State<ProductsContent> createState() => _ProductsContentState();
}

class _ProductsContentState extends State<ProductsContent> {
  final Color parrotGreen = const Color(0xFF7CB342);
  final Color darkGreenText = const Color(0xFF2E7D32);
  final Color bgColor = const Color(0xFFF5F6F8);

  int? selectedProductIndex;
  String? selectedGroup;

  bool isNewProductPanelOpen = false;
  bool isEditingProduct = false;

  bool toggleActive = true;
  bool toggleDefaultQty = true;
  bool toggleService = false;
  bool togglePriceTax = true;
  bool togglePriceChange = false;
  bool toggleLowStock = false;

  // Controllers
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController codeCtrl = TextEditingController();
  final TextEditingController unitCtrl = TextEditingController();
  final TextEditingController costCtrl = TextEditingController();
  final TextEditingController markupCtrl = TextEditingController();
  final TextEditingController salePriceCtrl = TextEditingController();
  final TextEditingController reorderCtrl = TextEditingController();
  final TextEditingController prefQtyCtrl = TextEditingController();
  final TextEditingController lowStockQtyCtrl = TextEditingController();
  final TextEditingController searchCtrl = TextEditingController();

  final FocusNode unitFocusNode = FocusNode();
  final FocusNode salePriceFocusNode = FocusNode();
  
  String selectedNewGroup = '';
  String selectedSupplier = '(none)';
  String selectedColor = 'Transparent';
  String? selectedImagePath;

  final Map<String, Color> productColors = {
    'Transparent': Colors.transparent, 'AliceBlue': const Color(0xFFF0F8FF), 
    'Black': Colors.black, 'Blue': Colors.blue, 'Brown': Colors.brown,
    'Gray': Colors.grey, 'Green': Colors.green, 'Red': Colors.red, 'White': Colors.white,
  };

  // گروپس کی لسٹ لانے کا فنکشن (models.dart کے حساب سے)
  List<String> getGroupsList() {
    if (posGroups.isEmpty) return ['Product'];
    return posGroups.map((g) => g.name).toList();
  }

  @override
  void initState() {
    super.initState();
    List<String> groups = getGroupsList();
    if (groups.isNotEmpty && selectedGroup == null) {
      selectedGroup = groups[0];
    }
  }

  @override
  void dispose() {
    unitFocusNode.dispose();
    salePriceFocusNode.dispose();
    super.dispose();
  }

  void _calculateMarkup() {
    double cost = double.tryParse(costCtrl.text) ?? 0;
    double price = double.tryParse(salePriceCtrl.text) ?? 0;
    if (cost > 0 && price > 0) {
      double markup = ((price - cost) / cost) * 100;
      markupCtrl.text = markup.toStringAsFixed(2);
    } else {
      markupCtrl.text = '';
    }
    setState(() {});
  }

  String _generateAutoCode() {
    int nextId = posProducts.length + 1;
    return nextId.toString();
  }

  void _showAddGroupDialog() {
    final TextEditingController groupCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Product Group', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        content: TextField(
          controller: groupCtrl,
          autofocus: true,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) {
            if (groupCtrl.text.isNotEmpty) {
              setState(() {
                posGroups.add(PosGroup(id: DateTime.now().toString(), name: groupCtrl.text));
                selectedGroup = groupCtrl.text;
                saveAppData();
              });
              Navigator.pop(context);
              _showMsg('New group added successfully.');
            }
          },
          decoration: const InputDecoration(labelText: 'Group Name', border: OutlineInputBorder(), isDense: true),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: darkGreenText),
            onPressed: () {
              if (groupCtrl.text.isNotEmpty) {
                setState(() {
                  posGroups.add(PosGroup(id: DateTime.now().toString(), name: groupCtrl.text));
                  selectedGroup = groupCtrl.text;
                  saveAppData();
                });
                Navigator.pop(context);
                _showMsg('New group added successfully.');
              }
            },
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showEditGroupDialog() {
    if (selectedGroup == null) return;
    final TextEditingController groupCtrl = TextEditingController(text: selectedGroup);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Product Group', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        content: TextField(
          controller: groupCtrl,
          autofocus: true,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) {
            if (groupCtrl.text.isNotEmpty) {
              _updateGroup(groupCtrl.text);
              Navigator.pop(context);
            }
          },
          decoration: const InputDecoration(labelText: 'Group Name', border: OutlineInputBorder(), isDense: true),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: darkGreenText),
            onPressed: () {
              if (groupCtrl.text.isNotEmpty) {
                _updateGroup(groupCtrl.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _updateGroup(String newName) {
    setState(() {
      int idx = posGroups.indexWhere((g) => g.name == selectedGroup);
      if (idx != -1) {
        posGroups[idx].name = newName;
        selectedGroup = newName;
        for (var p in posProducts) {
          if (p.groupName == posGroups[idx].name) p.groupName = newName;
        }
        saveAppData();
      }
      _showMsg('Group updated successfully.');
    });
  }

  void _openEditProductPanel() {
    if (selectedProductIndex == null) return;
    var prod = posProducts[selectedProductIndex!];
    
    setState(() {
      isEditingProduct = true;
      nameCtrl.text = prod.name;
      codeCtrl.text = prod.id; // آپ کے ماڈل میں code کی جگہ id استعمال ہو رہا ہے
      unitCtrl.text = prod.uom; // آپ کے ماڈل میں unit کی جگہ uom ہے
      salePriceCtrl.text = prod.sellingPrice.toString();
      costCtrl.text = prod.costPrice.toString();
      prefQtyCtrl.text = prod.preferredQty.toString();
      reorderCtrl.text = prod.reorderPoint.toString();
      _calculateMarkup();
      
      List<String> groups = getGroupsList();
      selectedNewGroup = groups.contains(prod.groupName) ? prod.groupName : (groups.isNotEmpty ? groups[0] : 'Product');
      selectedImagePath = prod.imagePath;
      toggleActive = prod.isActive;
      togglePriceChange = prod.priceChangeAllowed;
      toggleLowStock = prod.lowStockWarning;
      selectedColor = prod.color.isNotEmpty && productColors.containsKey(prod.color) ? prod.color : 'Transparent';
      
      isNewProductPanelOpen = true;
    });
  }

  Future<void> _pickImage() async {
    const XTypeGroup typeGroup = XTypeGroup(
      label: 'Images',
      extensions: <String>['jpg', 'jpeg', 'png', 'webp'],
    );
    final XFile? file = await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);

    if (file != null) {
      setState(() {
        selectedImagePath = file.path;
      });
    }
  }

  pw.Document _buildPdfDocument() {
    final pdf = pw.Document();
    List<PosProduct> filtered = posProducts.where((p) => selectedGroup == null || p.groupName == selectedGroup).toList();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Products List - ${selectedGroup ?? "All Products"}', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(
                context: context,
                border: pw.TableBorder.all(color: PdfColors.grey400, width: 1),
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white),
                headerDecoration: const pw.BoxDecoration(color: PdfColors.blueGrey800),
                data: <List<String>>[
                  <String>['Code', 'Product Name', 'Unit', 'Cost', 'Price (PKR)'],
                  ...filtered.map((p) => [p.id, p.name, p.uom, p.costPrice.toString(), p.sellingPrice.toString()]),
                ],
              ),
            ],
          );
        },
      ),
    );
    return pdf;
  }

  Future<void> _printProducts() async {
    if (posProducts.isEmpty) {
      _showMsg('No products available to print.');
      return;
    }
    final pdf = _buildPdfDocument();
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  Future<void> _saveAsPdf() async {
    if (posProducts.isEmpty) {
      _showMsg('No products available to save.');
      return;
    }
    try {
      final pdf = _buildPdfDocument();
      final bytes = await pdf.save();
      const XTypeGroup typeGroup = XTypeGroup(label: 'PDF Documents', extensions: <String>['pdf']);
      
      final FileSaveLocation? result = await getSaveLocation(
        suggestedName: 'Products_List.pdf',
        acceptedTypeGroups: <XTypeGroup>[typeGroup],
      );

      if (result != null) {
        final File file = File(result.path);
        await file.writeAsBytes(bytes);
        _showMsg('PDF Saved Successfully at: ${result.path}');
      }
    } catch (e) {
      _showMsg('Error saving PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildMainContent(),

        if (isNewProductPanelOpen)
          Positioned.fill(
            child: GestureDetector(
              onTap: () => setState(() => isNewProductPanelOpen = false),
              child: Container(color: Colors.black.withOpacity(0.3)),
            ),
          ),

        _buildSlidingPanel(),
      ],
    );
  }

  Widget _buildMainContent() {
    bool hasProductSelection = selectedProductIndex != null;
    List<String> groupsList = getGroupsList();
    bool hasGroupSelection = selectedGroup != null && groupsList.isNotEmpty;

    List<PosProduct> filteredProducts = posProducts.where((p) {
      String prodName = p.name;
      String prodCode = p.id; // id as code
      
      bool matchesSearch = prodName.toLowerCase().contains(searchCtrl.text.toLowerCase()) || 
                           prodCode.toLowerCase().contains(searchCtrl.text.toLowerCase());
      
      if (searchCtrl.text.isNotEmpty) {
        return matchesSearch;
      }
      
      bool matchesGroup = selectedGroup == null || p.groupName == selectedGroup || (selectedGroup!.isEmpty && p.groupName.isEmpty);
      
      return matchesGroup && matchesSearch;
    }).toList();

    return Container(
      color: bgColor,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(color: parrotGreen, borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4))),
                child: const Row(
                  children: [
                    Icon(Icons.local_offer, color: Colors.white, size: 16),
                    SizedBox(width: 8),
                    Text('View products', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
          
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white, border: Border.all(color: Colors.grey.shade300), 
              borderRadius: const BorderRadius.only(topRight: Radius.circular(4), bottomLeft: Radius.circular(4), bottomRight: Radius.circular(4))
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildToolbarBtn(Icons.sync, 'Refresh', () {
                    setState(() { selectedProductIndex = null; searchCtrl.clear(); });
                    _showMsg('Data refreshed.');
                  }),
                  const SizedBox(width: 24),
                  _buildToolbarBtn(Icons.create_new_folder_outlined, 'New group', _showAddGroupDialog),
                  const SizedBox(width: 24),
                  _buildToolbarBtn(Icons.edit_outlined, 'Edit group', _showEditGroupDialog, disabled: !hasGroupSelection),
                  const SizedBox(width: 24),
                  _buildToolbarBtn(Icons.folder_delete_outlined, 'Delete group', () {
                    if (hasGroupSelection) {
                      setState(() {
                        posGroups.removeWhere((g) => g.name == selectedGroup);
                        selectedGroup = posGroups.isNotEmpty ? posGroups[0].name : null;
                        saveAppData();
                      });
                      _showMsg('Group deleted.');
                    }
                  }, disabled: !hasGroupSelection),
                  const SizedBox(width: 24),
                  _buildToolbarBtn(Icons.add, 'New product', () {
                    setState(() {
                      isEditingProduct = false;
                      nameCtrl.clear();
                      codeCtrl.text = _generateAutoCode(); 
                      unitCtrl.clear();
                      costCtrl.clear();
                      markupCtrl.clear();
                      salePriceCtrl.clear();
                      reorderCtrl.clear();
                      prefQtyCtrl.clear();
                      lowStockQtyCtrl.clear();
                      selectedImagePath = null;
                      selectedNewGroup = groupsList.isNotEmpty ? (selectedGroup ?? groupsList[0]) : 'Product';
                      isNewProductPanelOpen = true; 
                    });
                  }),
                  const SizedBox(width: 24),
                  _buildToolbarBtn(Icons.edit, 'Edit product', _openEditProductPanel, disabled: !hasProductSelection),
                  const SizedBox(width: 24),
                  _buildToolbarBtn(Icons.delete_outline, 'Delete product', () {
                    if (hasProductSelection) {
                      setState(() {
                        posProducts.removeAt(selectedProductIndex!);
                        selectedProductIndex = null;
                        saveAppData();
                      });
                      _showMsg('Product deleted.');
                    }
                  }, disabled: !hasProductSelection),
                  const SizedBox(width: 24),
                  _buildToolbarBtn(Icons.print, 'Print', _printProducts),
                  const SizedBox(width: 24),
                  _buildToolbarBtn(Icons.picture_as_pdf, 'Save as PDF', _saveAsPdf),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 10),
          
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 220,
                  decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300)),
                  child: groupsList.isEmpty 
                    ? Center(child: Text('No groups yet.\nClick "New group"', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade500)))
                    : ListView.builder(
                        itemCount: groupsList.length,
                        itemBuilder: (context, index) {
                          bool isSelected = selectedGroup == groupsList[index];
                          return InkWell(
                            onTap: () => setState(() {
                              selectedGroup = groupsList[index];
                              selectedProductIndex = null;
                              searchCtrl.clear(); 
                            }),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              color: isSelected ? parrotGreen.withOpacity(0.15) : Colors.transparent,
                              child: Row(
                                children: [
                                  Icon(isSelected ? Icons.folder_open : Icons.folder, color: isSelected ? darkGreenText : Colors.grey.shade600, size: 18),
                                  const SizedBox(width: 8),
                                  Text(groupsList[index], style: TextStyle(color: isSelected ? darkGreenText : Colors.black87, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, fontSize: 13)),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade300)), color: Colors.grey.shade100),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3, 
                                child: Container(
                                  height: 32,
                                  decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(4)),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(width: 8),
                                      const Icon(Icons.search, size: 16, color: Colors.grey),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: TextField(
                                          controller: searchCtrl,
                                          textAlignVertical: TextAlignVertical.center, 
                                          decoration: const InputDecoration(
                                            hintText: 'Search product by name or code...', 
                                            hintStyle: TextStyle(fontSize: 12, color: Colors.grey), 
                                            border: InputBorder.none,
                                            isDense: true,
                                            contentPadding: EdgeInsets.zero,
                                          ),
                                          style: const TextStyle(fontSize: 13),
                                          onChanged: (v) {
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                flex: 1,
                                child: Text('Products count: ${filteredProducts.length}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87), overflow: TextOverflow.ellipsis),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: filteredProducts.isEmpty 
                              ? Center(child: Text('No products available', style: TextStyle(color: Colors.grey.shade600)))
                              : SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: SingleChildScrollView(
                                    child: DataTable(
                                      headingRowHeight: 35, dataRowMinHeight: 35, dataRowMaxHeight: 35, showCheckboxColumn: false,
                                      headingRowColor: WidgetStateProperty.all(Colors.grey.shade200),
                                      columns: const [
                                        DataColumn(label: Text('Code', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                                        DataColumn(label: Text('Name', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                                        DataColumn(label: Text('Unit', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                                        DataColumn(label: Text('Cost Price', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                                        DataColumn(label: Text('Sale Price', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                                      ],
                                      rows: List.generate(filteredProducts.length, (index) {
                                        final prod = filteredProducts[index];
                                        int actualIndex = posProducts.indexOf(prod);
                                        bool isSelected = selectedProductIndex == actualIndex;
                                        return DataRow(
                                          selected: isSelected,
                                          onSelectChanged: (val) {
                                            setState(() { selectedProductIndex = actualIndex; });
                                          },
                                          cells: [
                                            DataCell(Text(prod.id, style: const TextStyle(fontSize: 12))),
                                            DataCell(Text(prod.name, style: const TextStyle(fontSize: 12))),
                                            DataCell(Text(prod.uom, style: const TextStyle(fontSize: 12))),
                                            DataCell(Text(prod.costPrice.toString(), style: const TextStyle(fontSize: 12, color: Colors.red))),
                                            DataCell(Text(prod.sellingPrice.toString(), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.green))),
                                          ],
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlidingPanel() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      top: 0,
      bottom: 0,
      right: isNewProductPanelOpen ? 0 : -600,
      width: 600,
      child: Material(
        elevation: 24, 
        color: Colors.white,
        child: DefaultTabController(
          length: 4, 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                color: darkGreenText,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(isEditingProduct ? 'Edit product' : 'New product', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400)),
                    InkWell(
                      onTap: () => setState(() => isNewProductPanelOpen = false),
                      child: const Icon(Icons.arrow_forward, color: Colors.white),
                    ),
                  ],
                ),
              ),
              
              Container(
                color: darkGreenText.withOpacity(0.95),
                child: const TabBar(
                  isScrollable: true,
                  labelColor: Colors.white, unselectedLabelColor: Colors.white70,
                  indicatorColor: Colors.white, indicatorWeight: 3,
                  labelStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  tabs: [
                    Tab(text: 'Details'), Tab(text: 'Price & tax'),
                    Tab(text: 'Stock control'), Tab(text: 'Image & color'),
                  ],
                ),
              ),

              Expanded(
                child: Container(
                  color: Colors.grey.shade100,
                  child: TabBarView(
                    children: [
                      _buildDetailsTab(), _buildPriceTaxTab(),
                      _buildStockControlTab(), _buildImageColorTab(),
                    ],
                  ),
                ),
              ),

              Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, -2))],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        if (nameCtrl.text.isNotEmpty) {
                          setState(() {
                            double sPrice = double.tryParse(salePriceCtrl.text) ?? 0;
                            double cPrice = double.tryParse(costCtrl.text) ?? 0;
                            double pQty = double.tryParse(prefQtyCtrl.text) ?? 0;
                            double rQty = double.tryParse(reorderCtrl.text) ?? 0;
                            double mUp = double.tryParse(markupCtrl.text) ?? 0;

                            if (isEditingProduct && selectedProductIndex != null) {
                              posProducts[selectedProductIndex!] = PosProduct(
                                id: codeCtrl.text,
                                name: nameCtrl.text,
                                uom: unitCtrl.text.isEmpty ? 'pcs' : unitCtrl.text,
                                sellingPrice: sPrice,
                                costPrice: cPrice,
                                groupName: selectedNewGroup,
                                imagePath: selectedImagePath ?? '',
                                isActive: toggleActive,
                                defaultQty: toggleDefaultQty ? 1.0 : 0.0,
                                priceChangeAllowed: togglePriceChange,
                                reorderPoint: rQty,
                                preferredQty: pQty,
                                lowStockWarning: toggleLowStock,
                                color: selectedColor,
                                markup: mUp,
                              );
                            } else {
                              posProducts.add(PosProduct(
                                id: codeCtrl.text,
                                name: nameCtrl.text,
                                uom: unitCtrl.text.isEmpty ? 'pcs' : unitCtrl.text,
                                sellingPrice: sPrice,
                                costPrice: cPrice,
                                groupName: selectedNewGroup,
                                imagePath: selectedImagePath ?? '',
                                isActive: toggleActive,
                                defaultQty: toggleDefaultQty ? 1.0 : 0.0,
                                priceChangeAllowed: togglePriceChange,
                                reorderPoint: rQty,
                                preferredQty: pQty,
                                lowStockWarning: toggleLowStock,
                                color: selectedColor,
                                markup: mUp,
                              ));
                            }
                            saveAppData();
                            isNewProductPanelOpen = false;
                          });
                          _showMsg(isEditingProduct ? 'Product updated.' : 'Product saved.');
                        } else {
                          _showMsg('Product Name is required.');
                        }
                      },
                      icon: const Icon(Icons.check, size: 16, color: Colors.white),
                      label: const Text('Save', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(backgroundColor: parrotGreen, minimumSize: const Size(100, 40)),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      onPressed: () => setState(() => isNewProductPanelOpen = false),
                      icon: const Icon(Icons.close, size: 16, color: Colors.black87),
                      label: const Text('Cancel', style: TextStyle(color: Colors.black87)),
                      style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.grey.shade400), minimumSize: const Size(100, 40)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsTab() {
    List<String> groupsList = getGroupsList();
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildLabeledTextField(
          'Name', nameCtrl, 
          isRequired: true, autoFocus: true, 
          onSubmitted: (_) => FocusScope.of(context).requestFocus(unitFocusNode)
        ),
        
        _buildLabeledTextField('Code (Auto Generated)', codeCtrl, enabled: false),
        const SizedBox(height: 8),
        
        _buildLabeledTextField(
          'Unit of measurement', unitCtrl, 
          focusNode: unitFocusNode,
          onSubmitted: (_) => FocusScope.of(context).unfocus()
        ),
        
        const Text('Group', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        _buildStringDropdown(selectedNewGroup, groupsList.isEmpty ? ['Product'] : groupsList, (v) {
          setState(() { 
            if (v != null) selectedNewGroup = v; 
          });
        }),
        const SizedBox(height: 20),
        _buildCustomSwitch('Active', toggleActive, (v) => setState(() => toggleActive = v)),
        const SizedBox(height: 16),
        _buildCustomSwitch('Default quantity', toggleDefaultQty, (v) => setState(() => toggleDefaultQty = v)),
        const SizedBox(height: 16),
        _buildCustomSwitch('Service (not using stock)', toggleService, (v) => setState(() => toggleService = v)),
      ],
    );
  }

  Widget _buildPriceTaxTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 8),
        
        _buildLabeledTextField(
          'Cost', costCtrl, 
          onChanged: (v) => _calculateMarkup(),
          onSubmitted: (_) => FocusScope.of(context).requestFocus(salePriceFocusNode)
        ),
        
        _buildLabeledTextField('Markup (Auto calculated)', markupCtrl, suffixText: '%', enabled: false),
        
        _buildLabeledTextField(
          'Sale price', salePriceCtrl, 
          focusNode: salePriceFocusNode,
          onChanged: (v) => _calculateMarkup()
        ),
        
        const SizedBox(height: 12),
        _buildCustomSwitch('Price includes tax', togglePriceTax, (v) => setState(() => togglePriceTax = v)),
        const SizedBox(height: 16),
        _buildCustomSwitch('Price change allowed', togglePriceChange, (v) => setState(() => togglePriceChange = v)),
      ],
    );
  }

  Widget _buildStockControlTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text('Supplier', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        _buildStringDropdown(selectedSupplier, ['(none)', 'Supplier A'], (v) {
          setState(() { if (v != null) selectedSupplier = v; });
        }),
        const SizedBox(height: 16),
        _buildLabeledTextField('Reorder point', reorderCtrl),
        _buildLabeledTextField('Preferred quantity', prefQtyCtrl),
        const SizedBox(height: 12),
        _buildCustomSwitch('Low stock warning', toggleLowStock, (v) => setState(() => toggleLowStock = v)),
        const SizedBox(height: 16),
        _buildLabeledTextField('Low stock warning quantity', lowStockQtyCtrl, enabled: toggleLowStock),
      ],
    );
  }

  Widget _buildImageColorTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text('Color', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        Theme(
          data: Theme.of(context).copyWith(
            focusColor: parrotGreen.withOpacity(0.2), hoverColor: parrotGreen.withOpacity(0.1),
          ),
          child: Container(
            height: 36,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(2), color: Colors.white),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedColor,
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down, size: 16),
                items: productColors.keys.map((String colorName) {
                  return DropdownMenuItem<String>(
                    value: colorName,
                    child: Row(
                      children: [
                        Container(
                          width: 16, height: 16,
                          decoration: BoxDecoration(color: productColors[colorName], border: Border.all(color: Colors.grey.shade600, width: 0.5)),
                        ),
                        const SizedBox(width: 8),
                        Text(colorName, style: const TextStyle(fontSize: 13, color: Colors.black87)),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (v) {
                  setState(() { if (v != null) selectedColor = v; });
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text('Image', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                OutlinedButton(
                  onPressed: _pickImage,
                  style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.grey.shade400)), 
                  child: const Text('Browse', style: TextStyle(color: Colors.black87))
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () { setState(() { selectedImagePath = null; }); }, 
                  style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.grey.shade400)), 
                  child: const Text('Clear', style: TextStyle(color: Colors.black87))
                ),
              ],
            ),
            const SizedBox(width: 20),
            Container(
              width: 140, height: 140,
              decoration: BoxDecoration(
                color: Colors.grey.shade200, border: Border.all(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(4),
              ),
              child: selectedImagePath != null && selectedImagePath!.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.file(File(selectedImagePath!), fit: BoxFit.cover),
                    )
                  : const Center(child: Text('No Image', style: TextStyle(color: Colors.grey))),
            )
          ],
        )
      ],
    );
  }

  Widget _buildLabeledTextField(String label, TextEditingController controller, {bool isRequired = false, String? suffixText, bool enabled = true, bool autoFocus = false, ValueChanged<String>? onChanged, FocusNode? focusNode, Function(String)? onSubmitted}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          SizedBox(
            height: 32,
            child: TextField(
              controller: controller,
              enabled: enabled,
              autofocus: autoFocus,
              focusNode: focusNode,
              textInputAction: onSubmitted != null ? TextInputAction.next : TextInputAction.done,
              onSubmitted: onSubmitted ?? (_) => FocusScope.of(context).nextFocus(),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 10, bottom: 12),
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: isRequired && controller.text.isEmpty ? Colors.red : Colors.grey.shade400)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: isRequired && controller.text.isEmpty ? Colors.red : parrotGreen)),
                suffixText: suffixText,
                filled: !enabled,
                fillColor: enabled ? Colors.white : Colors.grey.shade200,
              ),
              style: const TextStyle(fontSize: 13),
              onChanged: (v) {
                if (onChanged != null) onChanged(v);
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomSwitch(String label, bool value, ValueChanged<bool> onChanged) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 38, height: 20,
            decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade400), color: value ? parrotGreen : Colors.grey.shade300),
            child: Row(
              children: [
                if (value) Expanded(child: Container()),
                Container(width: 16, color: Colors.white, margin: const EdgeInsets.all(1)),
                if (!value) Expanded(child: Container()),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 13, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildStringDropdown(String value, List<String> items, ValueChanged<String?> onChanged) {
    String val = items.contains(value) ? value : (items.isNotEmpty ? items[0] : '');
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(2), color: Colors.white),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: val.isEmpty ? null : val,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, size: 16),
          style: const TextStyle(fontSize: 13, color: Colors.black87),
          items: items.isEmpty 
              ? [const DropdownMenuItem(value: null, child: Text('No Group', style: TextStyle(color: Colors.grey)))]
              : items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildToolbarBtn(IconData icon, String label, VoidCallback onTap, {bool disabled = false}) {
    Color itemColor = disabled ? Colors.grey.shade400 : Colors.black87;
    return InkWell(
      onTap: disabled ? null : onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: itemColor, size: 22),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: itemColor, fontSize: 11)),
        ],
      ),
    );
  }

  void _showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), duration: const Duration(seconds: 1)));
  }
}