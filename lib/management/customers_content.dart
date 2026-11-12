import 'package:flutter/material.dart';

class CustomersContent extends StatelessWidget {
  const CustomersContent({super.key});

  final Color parrotGreen = const Color(0xFF7CB342);
  final Color darkGreenText = const Color(0xFF2E7D32);
  final Color bgColor = const Color(0xFFF5F6F8);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==========================================
          // 1. Top Toolbar (Refresh, Add, Edit, Delete, Import, Export, Help)
          // ==========================================
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildToolbarButton(Icons.refresh, 'Refresh', Colors.grey.shade700),
                  const SizedBox(width: 16),
                  _buildToolbarButton(Icons.add_box, 'Add', darkGreenText),
                  const SizedBox(width: 16),
                  _buildToolbarButton(Icons.edit, 'Edit', Colors.grey.shade700),
                  const SizedBox(width: 16),
                  _buildToolbarButton(Icons.delete_outline, 'Delete', Colors.grey.shade700),
                  const SizedBox(width: 16),
                  _buildToolbarButton(Icons.download, 'Import', Colors.grey.shade700),
                  const SizedBox(width: 16),
                  _buildToolbarButton(Icons.upload, 'Export', Colors.grey.shade700),
                  const SizedBox(width: 16),
                  _buildToolbarButton(Icons.help_outline, 'Help', Colors.grey.shade700),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 12),

          // ==========================================
          // 2. Main Table Area[cite: 7]
          // ==========================================
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  // Search and Filter Bar[cite: 7]
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                      color: Colors.grey.shade50,
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 28,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(2),
                            color: Colors.white,
                          ),
                          child: const Row(
                            children: [
                              Text('Name', style: TextStyle(fontSize: 12)),
                              SizedBox(width: 4),
                              Icon(Icons.arrow_drop_down, size: 16),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            height: 28,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(2),
                              color: Colors.white,
                            ),
                            child: const Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Search customers & suppliers',
                                      hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(bottom: 14),
                                    ),
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                                Icon(Icons.search, size: 16, color: Colors.grey),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Data Table[cite: 7]
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        headingRowColor: MaterialStateProperty.all(Colors.grey.shade100),
                        headingRowHeight: 35,
                        dataRowHeight: 35,
                        columns: const [
                          DataColumn(label: Text('Code', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Name', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Tax number', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Address', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Country', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Phone number', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Email', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                        ],
                        rows: const [
                          DataRow(
                            cells: [
                              DataCell(Text('', style: TextStyle(fontSize: 12))),
                              DataCell(Text('Walk-in customer', style: TextStyle(fontSize: 12))),
                              DataCell(Text('(none)', style: TextStyle(fontSize: 12))),
                              DataCell(Text('(none)', style: TextStyle(fontSize: 12))),
                              DataCell(Text('', style: TextStyle(fontSize: 12))),
                              DataCell(Text('(none)', style: TextStyle(fontSize: 12))),
                              DataCell(Text('(none)', style: TextStyle(fontSize: 12))),
                            ],
                          ),
                        ],
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

  Widget _buildToolbarButton(IconData icon, String label, Color color) {
    return InkWell(
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}