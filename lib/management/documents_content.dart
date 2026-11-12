import 'package:flutter/material.dart';

class DocumentsContent extends StatefulWidget {
  const DocumentsContent({super.key});

  @override
  State<DocumentsContent> createState() => _DocumentsContentState();
}

class _DocumentsContentState extends State<DocumentsContent> {
  final Color parrotGreen = const Color(0xFF7CB342);
  final Color darkGreenText = const Color(0xFF2E7D32);
  final Color bgColor = const Color(0xFFF5F6F8);

  String selectedProduct = 'All products';
  String selectedUser = 'All users';
  String selectedRegister = 'All cash registers';
  String selectedCustomer = 'All customers';
  String selectedDocType = 'All document types';
  String selectedPaidStatus = 'All transactions';
  String dateRangeText = '10/21/2026 - 10/21/2026';

  final TextEditingController docNumberController = TextEditingController();
  final TextEditingController externalDocController = TextEditingController();

  int? selectedDocIndex;

  final List<Map<String, String>> documentsList = [
    {
      'id': '1',
      'number': 'POS-001',
      'external': '',
      'type': '100 - Purchase',
      'paid': 'Yes',
      'customer': 'Walk-in',
      'date': '10/21/2026 14:30',
      'pos': 'POS-1',
      'order': '1',
      'payment': 'Cash'
    },
  ];

  Future<void> _selectDateRange(BuildContext context) async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDateRange: DateTimeRange(
        start: DateTime(2026, 10, 21),
        end: DateTime(2026, 10, 21),
      ),
    );

    if (picked != null) {
      setState(() {
        dateRangeText =
            "${picked.start.month.toString().padLeft(2, '0')}/${picked.start.day.toString().padLeft(2, '0')}/${picked.start.year} - ${picked.end.month.toString().padLeft(2, '0')}/${picked.end.day.toString().padLeft(2, '0')}/${picked.end.year}";
      });
    }
  }

  // ★ Aronium jaisa Exact "Select document type" Dialog ★
  void _showSelectDocumentTypeDialog() {
    String selectedCategory = 'Expenses';
    String selectedSubtype = '100 - Purchase';

    final Map<String, List<String>> documentTypes = {
      'Expenses': ['100 - Purchase', '120 - Stock return'],
      'Sales': ['200 - Retail sale', '210 - Wholesale', '220 - Sales return'],
      'Inventory': ['300 - Inventory count', '310 - Stock adjustment'],
      'Loss': ['400 - Damage/Loss', '410 - Write off'],
    };

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            List<String> currentSubtypes = documentTypes[selectedCategory] ?? [];
            return Dialog(
              backgroundColor: const Color(0xFF252526),
              child: Container(
                width: 600,
                height: 420,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select document type',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.lightBlue, width: 1.5),
                        ),
                        child: Row(
                          children: [
                            // Left Category List
                            Container(
                              width: 180,
                              color: const Color(0xFF1E1E1E),
                              child: ListView(
                                children: documentTypes.keys.map((cat) {
                                  bool isCatSelected = selectedCategory == cat;
                                  return InkWell(
                                    onTap: () {
                                      setDialogState(() {
                                        selectedCategory = cat;
                                        currentSubtypes = documentTypes[cat]!;
                                        selectedSubtype = currentSubtypes.isNotEmpty ? currentSubtypes[0] : '';
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                      color: isCatSelected ? Colors.lightBlue.shade700 : Colors.transparent,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(cat, style: const TextStyle(color: Colors.white, fontSize: 14)),
                                          if (isCatSelected) const Icon(Icons.arrow_right, color: Colors.white, size: 18),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            const VerticalDivider(width: 1, color: Colors.grey),
                            // Right Subtype List
                            Expanded(
                              child: Container(
                                color: const Color(0xFF252526),
                                child: ListView(
                                  children: currentSubtypes.map((sub) {
                                    bool isSubSelected = selectedSubtype == sub;
                                    return InkWell(
                                      onTap: () {
                                        setDialogState(() {
                                          selectedSubtype = sub;
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                        color: isSubSelected ? Colors.lightBlue.shade700 : Colors.transparent,
                                        child: Text(sub, style: const TextStyle(color: Colors.white, fontSize: 14)),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.grey),
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Row(
                            children: [
                              Icon(Icons.close, size: 16),
                              SizedBox(width: 4),
                              Text('Cancel'),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            side: const BorderSide(color: Colors.lightBlue),
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            // Yahan selectedSubtype ke mutabiq naya document add ho jayega
                            setState(() {
                              documentsList.add({
                                'id': (documentsList.length + 1).toString(),
                                'number': 'POS-00${documentsList.length + 1}',
                                'external': '',
                                'type': selectedSubtype,
                                'paid': 'Yes',
                                'customer': 'Walk-in',
                                'date': '10/21/2026 17:00',
                                'pos': 'POS-1',
                                'order': (documentsList.length + 1).toString(),
                                'payment': 'Cash'
                              });
                            });
                            _showMsg('Selected type: $selectedSubtype create ho gaya hai!');
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.check, size: 16),
                              SizedBox(width: 4),
                              Text('OK'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                decoration: BoxDecoration(
                  color: Colors.lightBlue.shade700,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, color: Colors.white, size: 16),
                    SizedBox(width: 8),
                    Text('View documents', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(4),
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildToolbarButton(Icons.add_box, 'Add', darkGreenText, () {
                    _showSelectDocumentTypeDialog(); // Ab yeh Aronium jaisa dialog kholega
                  }),
                  const SizedBox(width: 24),
                  _buildToolbarButton(Icons.print, 'Print', Colors.grey.shade700, () {
                    _showMsg('Print ho raha hai...');
                  }),
                  const SizedBox(width: 24),
                  _buildToolbarButton(Icons.print_outlined, 'Print preview', Colors.grey.shade700, () {
                    _showMsg('Print preview...');
                  }),
                  const SizedBox(width: 24),
                  _buildToolbarButton(Icons.picture_as_pdf, 'Save as PDF', Colors.grey.shade700, () {
                    _showMsg('PDF save ho rahi hai...');
                  }),
                  const SizedBox(width: 24),
                  _buildToolbarButton(Icons.edit, 'Edit', Colors.grey.shade700, () {
                    if (selectedDocIndex != null) {
                      _showMsg('Editing document #${documentsList[selectedDocIndex!]['number']}');
                    } else {
                      _showMsg('Pehle koi row select karein.');
                    }
                  }),
                  const SizedBox(width: 24),
                  _buildToolbarButton(Icons.delete_outline, 'Delete', Colors.grey.shade700, () {
                    if (selectedDocIndex != null) {
                      setState(() {
                        documentsList.removeAt(selectedDocIndex!);
                        selectedDocIndex = null;
                      });
                      _showMsg('Document delete ho gaya.');
                    } else {
                      _showMsg('Pehle koi row select karein.');
                    }
                  }),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: _buildFilterDropdown('Product', selectedProduct, ['All products', 'Product A'], (val) => setState(() => selectedProduct = val!))),
                          const SizedBox(width: 12),
                          Expanded(child: _buildFilterDropdown('User', selectedUser, ['All users', 'Admin'], (val) => setState(() => selectedUser = val!))),
                          const SizedBox(width: 12),
                          Expanded(child: _buildFilterDropdown('Cash register', selectedRegister, ['All cash registers', 'Register 1'], (val) => setState(() => selectedRegister = val!))),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(child: _buildFilterDropdown('Customer', selectedCustomer, ['All customers', 'Walk-in'], (val) => setState(() => selectedCustomer = val!))),
                          const SizedBox(width: 12),
                          Expanded(child: _buildFilterDropdown('Document type', selectedDocType, ['All document types', '100 - Purchase'], (val) => setState(() => selectedDocType = val!))),
                          const SizedBox(width: 12),
                          Expanded(child: _buildFilterDropdown('Paid status', selectedPaidStatus, ['All transactions', 'Paid'], (val) => setState(() => selectedPaidStatus = val!))),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                const SizedBox(width: 110, child: Text('Document number', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500))),
                                Expanded(
                                  child: Container(
                                    height: 26,
                                    padding: const EdgeInsets.symmetric(horizontal: 6),
                                    decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(2)),
                                    child: TextField(controller: docNumberController, decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.only(bottom: 12)), style: const TextStyle(fontSize: 11)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Row(
                              children: [
                                const SizedBox(width: 110, child: Text('External document', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500))),
                                Expanded(
                                  child: Container(
                                    height: 26,
                                    padding: const EdgeInsets.symmetric(horizontal: 6),
                                    decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(2)),
                                    child: TextField(controller: externalDocController, decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.only(bottom: 12)), style: const TextStyle(fontSize: 11)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Row(
                              children: [
                                const SizedBox(width: 50, child: Text('Period', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500))),
                                Expanded(
                                  child: InkWell(
                                    onTap: () => _selectDateRange(context),
                                    child: Container(
                                      height: 26,
                                      padding: const EdgeInsets.symmetric(horizontal: 6),
                                      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(2)),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(dateRangeText, style: const TextStyle(fontSize: 11)),
                                          const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => _showMsg('Searching...'),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4), color: Colors.grey.shade50),
                            child: const Icon(Icons.search, size: 18, color: Colors.black87),
                          ),
                          const SizedBox(height: 2),
                          const Text('Search', style: TextStyle(fontSize: 10)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedProduct = 'All products';
                          selectedUser = 'All users';
                          selectedRegister = 'All cash registers';
                          selectedCustomer = 'All customers';
                          selectedDocType = 'All document types';
                          selectedPaidStatus = 'All transactions';
                          docNumberController.clear();
                          externalDocController.clear();
                        });
                        _showMsg('Filters cleared');
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4), color: Colors.grey.shade50),
                            child: const Icon(Icons.filter_alt_off, size: 18, color: Colors.black87),
                          ),
                          const SizedBox(height: 2),
                          const Text('Clear', style: TextStyle(fontSize: 10)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    color: Colors.grey.shade100,
                    child: Text('Documents (${documentsList.length})', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                  const Divider(height: 1),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        child: DataTable(
                          headingRowHeight: 30,
                          dataRowMinHeight: 30,
                          dataRowMaxHeight: 30,
                          showCheckboxColumn: false,
                          columns: const [
                            DataColumn(label: Text('', style: TextStyle(fontSize: 11))),
                            DataColumn(label: Text('ID', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Number', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('External...', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Document type', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Paid', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Customer', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Date', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('POS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Ord...', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Payment', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                          ],
                          rows: List.generate(documentsList.length, (index) {
                            final doc = documentsList[index];
                            bool isSelected = selectedDocIndex == index;
                            return DataRow(
                              selected: isSelected,
                              onSelectChanged: (val) {
                                setState(() {
                                  selectedDocIndex = index;
                                });
                              },
                              cells: [
                                DataCell(Checkbox(value: isSelected, onChanged: (v) {
                                  setState(() {
                                    selectedDocIndex = index;
                                  });
                                })),
                                DataCell(Text(doc['id']!, style: const TextStyle(fontSize: 11))),
                                DataCell(Text(doc['number']!, style: const TextStyle(fontSize: 11))),
                                DataCell(Text(doc['external']!, style: const TextStyle(fontSize: 11))),
                                DataCell(Text(doc['type']!, style: const TextStyle(fontSize: 11))),
                                DataCell(Text(doc['paid']!, style: const TextStyle(fontSize: 11))),
                                DataCell(Text(doc['customer']!, style: const TextStyle(fontSize: 11))),
                                DataCell(Text(doc['date']!, style: const TextStyle(fontSize: 11))),
                                DataCell(Text(doc['pos']!, style: const TextStyle(fontSize: 11))),
                                DataCell(Text(doc['order']!, style: const TextStyle(fontSize: 11))),
                                DataCell(Text(doc['payment']!, style: const TextStyle(fontSize: 11))),
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
          const SizedBox(height: 10),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    color: Colors.grey.shade100,
                    child: const Text('Document items (0)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                  const Divider(height: 1),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        child: DataTable(
                          headingRowHeight: 30,
                          dataRowMinHeight: 30,
                          dataRowMaxHeight: 30,
                          columns: const [
                            DataColumn(label: Text('ID', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Code', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Name', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Unit of measure', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Quantity', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Price before tax', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Tax', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Price', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Total before discount', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Discount', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Total', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                          ],
                          rows: const [],
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
    );
  }

  Widget _buildToolbarButton(IconData icon, String label, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 2),
          Text(label, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown(String label, String value, List<String> items, ValueChanged<String?> onChanged) {
    return Row(
      children: [
        SizedBox(width: 110, child: Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500))),
        Expanded(
          child: Container(
            height: 26,
            padding: const EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(2)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down, size: 16),
                style: const TextStyle(fontSize: 11, color: Colors.black87),
                items: items.map((item) => DropdownMenuItem(value: item, child: Text(item, style: const TextStyle(fontSize: 11)))).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), duration: const Duration(seconds: 1)));
  }
}