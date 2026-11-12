import 'package:flutter/material.dart';
import 'models.dart';

// ============================================================
// MEASUREMENTS DIRECTORY SCREEN
// ============================================================

class MeasurementsScreen extends StatefulWidget {
  const MeasurementsScreen({super.key});

  @override
  State<MeasurementsScreen> createState() => _MeasurementsScreenState();
}

class _MeasurementsScreenState extends State<MeasurementsScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(_refresh);
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    searchController.removeListener(_refresh);
    searchController.dispose();
    super.dispose();
  }

  List<CustomerRecord> get filteredCustomers {
    final query = searchController.text.trim().toLowerCase();

    if (query.isEmpty) {
      return List<CustomerRecord>.from(savedCustomers.reversed);
    }

    return savedCustomers.reversed.where((customer) {
      return customer.name.toLowerCase().contains(query) ||
          customer.mobile.toLowerCase().contains(query) ||
          customer.tokenNumber.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final customers = filteredCustomers;
    final hasQuery = searchController.text.trim().isNotEmpty;

    return Column(
      children: [
        // Search Filter
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              labelText: 'Search Customer for Size',
              hintText: 'Name / Mobile / Suit No.',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: hasQuery
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: searchController.clear,
                    )
                  : null,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        
        // Customers List
        Expanded(
          child: customers.isEmpty
              ? Center(
                  child: Text(
                    hasQuery ? 'No customer found' : 'No measurements saved yet',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: customers.length,
                  itemBuilder: (context, index) {
                    final customer = customers[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.indigo.shade50,
                          child: Icon(Icons.straighten, color: Colors.indigo.shade400),
                        ),
                        title: Text(
                          customer.name.isEmpty ? 'Unnamed Customer' : customer.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          customer.mobile.isEmpty ? 'Suit: ${customer.tokenNumber}' : 'Mob: ${customer.mobile} | Suit: ${customer.tokenNumber}',
                          style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                        ),
                        trailing: FilledButton.tonal(
                          onPressed: () {
                            _showMeasurementsDialog(context, customer);
                          },
                          child: const Text('View Size'),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  void _showMeasurementsDialog(BuildContext context, CustomerRecord customer) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        final Map<String, String> sizeData = customer.measurements;
        
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${customer.name}\'s Size', style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(customer.garmentType, style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
            ],
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: sizeData.isEmpty
                ? const Text('No measurements were saved for this customer.')
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: sizeData.length,
                    itemBuilder: (context, index) {
                      String key = sizeData.keys.elementAt(index);
                      String value = sizeData[key]!;
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(key, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                              Text(value, style: const TextStyle(fontSize: 15, color: Colors.indigo, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}