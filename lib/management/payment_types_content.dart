import 'package:flutter/material.dart';

class PaymentTypesContent extends StatelessWidget {
  const PaymentTypesContent({super.key});

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
          // 1. Top Toolbar (Refresh, New payment type, Edit, Delete, Help)
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
                  _buildToolbarButton(Icons.add_box, 'New payment type', darkGreenText),
                  const SizedBox(width: 16),
                  _buildToolbarButton(Icons.edit, 'Edit', Colors.grey.shade700),
                  const SizedBox(width: 16),
                  _buildToolbarButton(Icons.delete_outline, 'Delete', Colors.grey.shade700),
                  const SizedBox(width: 16),
                  _buildToolbarButton(Icons.help_outline, 'Help', Colors.grey.shade700),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 12),

          // ==========================================
          // 2. Main Table Area for Payment Types[cite: 8]
          // ==========================================
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: MaterialStateProperty.all(Colors.grey.shade100),
                  headingRowHeight: 35,
                  dataRowHeight: 35,
                  columns: const [
                    DataColumn(label: Text('Name', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Position', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Code', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Enabled', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Quick payment', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Customer required', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Change allowed', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Mark transaction as paid', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                  ],
                  rows: const [
                    DataRow(
                      cells: [
                        DataCell(Text('Cash', style: TextStyle(fontSize: 12))),
                        DataCell(Text('1', style: TextStyle(fontSize: 12))),
                        DataCell(Text('', style: TextStyle(fontSize: 12))),
                        DataCell(Icon(Icons.check, size: 16, color: Colors.green)),
                        DataCell(Icon(Icons.check, size: 16, color: Colors.green)),
                        DataCell(Text('', style: TextStyle(fontSize: 12))),
                        DataCell(Icon(Icons.check, size: 16, color: Colors.green)),
                        DataCell(Icon(Icons.check, size: 16, color: Colors.green)),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(Text('Card', style: TextStyle(fontSize: 12))),
                        DataCell(Text('2', style: TextStyle(fontSize: 12))),
                        DataCell(Text('', style: TextStyle(fontSize: 12))),
                        DataCell(Icon(Icons.check, size: 16, color: Colors.green)),
                        DataCell(Icon(Icons.check, size: 16, color: Colors.green)),
                        DataCell(Text('', style: TextStyle(fontSize: 12))),
                        DataCell(Text('', style: TextStyle(fontSize: 12))),
                        DataCell(Icon(Icons.check, size: 16, color: Colors.green)),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(Text('Check', style: TextStyle(fontSize: 12))),
                        DataCell(Text('3', style: TextStyle(fontSize: 12))),
                        DataCell(Text('', style: TextStyle(fontSize: 12))),
                        DataCell(Icon(Icons.check, size: 16, color: Colors.green)),
                        DataCell(Icon(Icons.check, size: 16, color: Colors.green)),
                        DataCell(Text('', style: TextStyle(fontSize: 12))),
                        DataCell(Text('', style: TextStyle(fontSize: 12))),
                        DataCell(Icon(Icons.check, size: 16, color: Colors.green)),
                      ],
                    ),
                  ],
                ),
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