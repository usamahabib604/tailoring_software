import 'package:flutter/material.dart';
import 'pos_management_screen.dart'; // ★ اب صرف آپ کی مینجمنٹ سکرین لنکڈ ہے ★

class PosThreeDotsDrawerContent extends StatelessWidget {
  const PosThreeDotsDrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    final Color parrotGreen = const Color(0xFF7CB342);
    final Color darkGreenText = const Color(0xFF2E7D32);

    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: parrotGreen, width: 2), 
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          bottomLeft: Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: parrotGreen.withOpacity(0.1),
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(14)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: parrotGreen.withOpacity(0.2), shape: BoxShape.circle),
                      child: Icon(Icons.point_of_sale, color: darkGreenText, size: 20),
                    ),
                    const SizedBox(width: 10),
                    Text('Point of Sale Menu', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: darkGreenText)),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          const Divider(height: 1, thickness: 1),

          // Options List (Extra Dummy links removed)
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: [
                _buildMenuItem(context, 'Management', 'Products & Stock', Icons.settings_suggest, () {
                  // ★ یہ آپ کی اصلی فولڈر والی مینجمنٹ سکرین کھولے گا ★
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PosManagementScreen()));
                }),
                _buildMenuItem(context, 'View Sales History', 'Past bills & history', Icons.history, () {
                  _showComingSoon(context, 'Sales History');
                }),
                _buildMenuItem(context, 'View Open Sales', 'Hold or parked sales', Icons.shopping_cart_checkout, () {
                  _showComingSoon(context, 'Open Sales');
                }),
                _buildMenuItem(context, 'Cash In / Cash Out', 'Add or remove cash', Icons.account_balance_wallet, () {
                  _showCashInOutDialog(context);
                }),
                _buildMenuItem(context, 'Credit Payment', 'Receive credit', Icons.payment, () {
                  _showComingSoon(context, 'Credit Payment');
                }),
                _buildMenuItem(context, 'End of Day (EOD)', 'Daily closing Z-Report', Icons.today, () {
                  _showComingSoon(context, 'End of Day Report');
                }),
                _buildMenuItem(context, 'Sign Out', 'Lock system or logout', Icons.lock_outline, () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('System Locked Successfully.'), backgroundColor: Colors.blueGrey),
                  );
                }),
              ],
            ),
          ),

          const Divider(height: 1, thickness: 1),

          // Footer
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sync: Up to date', style: TextStyle(fontSize: 11, color: Colors.grey)),
                    Text('Date: Today', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black54)),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      tooltip: 'Toggle Fullscreen',
                      icon: const Icon(Icons.fullscreen, color: Colors.blueGrey, size: 20),
                      onPressed: () {},
                    ),
                    IconButton(
                      tooltip: 'Exit / Logout',
                      icon: const Icon(Icons.logout, color: Colors.red, size: 20),
                      onPressed: () => Navigator.pop(context), 
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, String subtitle, IconData icon, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ListTile(
        dense: true,
        leading: Icon(icon, color: const Color(0xFF7CB342), size: 20),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
        subtitle: Text(subtitle, style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  void _showComingSoon(BuildContext context, String featureName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$featureName is being built in the new management folder!'), backgroundColor: Colors.orange),
    );
  }

  void _showCashInOutDialog(BuildContext context) {
    final amountController = TextEditingController();
    final noteController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cash In / Cash Out'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Amount', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: noteController,
                decoration: const InputDecoration(labelText: 'Reason / Note', border: OutlineInputBorder()),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: const Color(0xFF7CB342)),
              onPressed: () {
                Navigator.pop(context); 
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cash entry saved successfully!'), backgroundColor: Colors.green));
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}