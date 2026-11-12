import 'package:flutter/material.dart';

class MyCompanyContent extends StatelessWidget {
  const MyCompanyContent({super.key});

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
          // 1. Top Tabs (Company data, Void reasons, My logo, Reset database)[cite: 8]
          // ==========================================
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildTopTab('Company data', isSelected: true),
                const SizedBox(width: 4),
                _buildTopTab('Void reasons'),
                const SizedBox(width: 4),
                _buildTopTab('My logo'),
                const SizedBox(width: 4),
                _buildTopTab('Reset database'),
              ],
            ),
          ),
          
          const SizedBox(height: 12),

          // ==========================================
          // 2. Main Content Area with Form Fields[cite: 8]
          // ==========================================
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  // Toolbar inside content (Save, Help)[cite: 8]
                  Row(
                    children: [
                      _buildToolbarButton(Icons.save, 'Save', darkGreenText),
                      const SizedBox(width: 24),
                      _buildToolbarButton(Icons.help_outline, 'Help', Colors.grey.shade700),
                    ],
                  ),
                  const Divider(height: 24),

                  // Form Fields (Scrollable)[cite: 8]
                  Expanded(
                    child: ListView(
                      children: [
                        const Text('My company data', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
                        const SizedBox(height: 12),
                        _buildFormRow('Name', isRequired: true),
                        _buildFormRow('Tax number'),
                        _buildFormRow('Street name'),
                        _buildFormRow('Building number'),
                        _buildFormRow('Additional street name'),
                        _buildFormRow('Plot identification'),
                        _buildFormRow('District'),
                        _buildFormRow('Postal code'),
                        _buildFormRow('City'),
                        _buildFormRow('State / Province'),
                        _buildDropdownRow('Country', isRequired: true),
                        _buildFormRow('Phone number'),
                        _buildFormRow('Email'),
                        const SizedBox(height: 16),
                        const Text('Bank account', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
                        const Divider(height: 16),
                        _buildFormRow('Bank name'),
                        _buildFormRow('Account number'),
                      ],
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

  Widget _buildTopTab(String title, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? parrotGreen : Colors.grey.shade200,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
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

  Widget _buildFormRow(String label, {bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: 160,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 28,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isRequired ? Colors.red.shade400 : Colors.grey.shade400,
                ),
                borderRadius: BorderRadius.circular(2),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(bottom: 14, left: 8),
                ),
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownRow(String label, {bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: 160,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 28,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isRequired ? Colors.red.shade400 : Colors.grey.shade400,
                ),
                borderRadius: BorderRadius.circular(2),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('', style: TextStyle(fontSize: 12)),
                  Icon(Icons.arrow_drop_down, size: 16, color: Colors.grey),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}