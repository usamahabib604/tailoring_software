import 'package:flutter/material.dart';
import 'models.dart';

class RecycleBinScreen extends StatefulWidget {
  const RecycleBinScreen({super.key});

  @override
  State<RecycleBinScreen> createState() => _RecycleBinScreenState();
}

class _RecycleBinScreenState extends State<RecycleBinScreen> {
  void _restoreCustomer(int index) {
    // 1. ری سائیکل بن سے کسٹمر کا ڈیٹا نکالیں
    final item = recycleBin[index];
    final customer = CustomerRecord.fromJson(item['customer']);

    setState(() {
      // 2. کسٹمر کو واپس مین لسٹ میں ڈالیں اور بن سے نکال دیں
      savedCustomers.add(customer);
      recycleBin.removeAt(index);
    });

    // 3. میموری کو اپ ڈیٹ کر دیں
    saveAppData();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Customer Restored Successfully!')),
    );
  }

  void _emptyRecycleBin() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Empty Recycle Bin?'),
        content: const Text('Are you sure? This will permanently delete all records in the bin. This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                recycleBin.clear();
              });
              saveAppData();
              Navigator.of(dialogContext).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Recycle Bin Emptied!')),
              );
            },
            child: const Text('Delete Permanently'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recycle Bin'),
        actions: [
          if (recycleBin.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep, color: Colors.red),
              tooltip: 'Empty Bin',
              onPressed: _emptyRecycleBin,
            ),
        ],
      ),
      body: recycleBin.isEmpty
          ? const Center(
              child: Text(
                'Recycle Bin is empty.\n(Items are automatically deleted after 30 days)',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: recycleBin.length,
              itemBuilder: (context, index) {
                final item = recycleBin[index];
                final customer = CustomerRecord.fromJson(item['customer']);
                final DateTime deletedAt = DateTime.parse(item['deletedAt']);
                final int daysLeft = 30 - DateTime.now().difference(deletedAt).inDays;

                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: const Icon(Icons.delete_outline, color: Colors.red),
                    title: Text(customer.name.isEmpty ? 'Unnamed' : customer.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Suit: ${customer.tokenNumber} | Auto-delete in $daysLeft days'),
                    trailing: FilledButton.tonal(
                      style: FilledButton.styleFrom(backgroundColor: Colors.green.shade50),
                      onPressed: () => _restoreCustomer(index),
                      child: const Text('Restore', style: TextStyle(color: Colors.green)),
                    ),
                  ),
                );
              },
            ),
    );
  }
}