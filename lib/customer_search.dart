import 'package:flutter/material.dart';
import 'models.dart';

// ============================================================
// CUSTOMERS / SEARCH SCREEN
// ============================================================

class CustomersSearchScreen extends StatefulWidget {
  const CustomersSearchScreen({super.key});

  @override
  State<CustomersSearchScreen> createState() => _CustomersSearchScreenState();
}

class _CustomersSearchScreenState extends State<CustomersSearchScreen> {
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
      return customer.tokenNumber.toLowerCase().contains(query) ||
          customer.name.toLowerCase().contains(query) ||
          customer.mobile.toLowerCase().contains(query) ||
          customer.address.toLowerCase().contains(query);
    }).toList();
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final results = filteredCustomers;
    final hasQuery = searchController.text.trim().isNotEmpty;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
          child: TextField(
            controller: searchController,
            autofocus: false,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              labelText: 'Search Customer',
              hintText: 'Name / Mobile / Suit No. / Address',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: hasQuery
                  ? IconButton(
                      tooltip: 'Clear',
                      icon: const Icon(Icons.clear),
                      onPressed: searchController.clear,
                    )
                  : null,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: results.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          hasQuery ? Icons.search_off : Icons.people_outline,
                          size: 54,
                          color: Colors.grey.shade500,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          hasQuery ? 'No Matching Customer Found' : 'No Customers Saved Yet',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          hasQuery
                              ? 'Try customer name, mobile number or Suit / Token No.'
                              : 'Save a New Customer / Order first, then search it here.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final customer = results[index];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                        leading: CircleAvatar(
                          child: Text(customer.tokenNumber, style: const TextStyle(fontSize: 11)),
                        ),
                        title: Text(
                          customer.name.isEmpty ? 'Unnamed Customer' : customer.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (customer.mobile.isNotEmpty) Text('Mobile: ${customer.mobile}'),
                              if (customer.address.isNotEmpty) Text('Address: ${customer.address}'),
                              Text('Suit / Token: ${customer.tokenNumber}'),
                              Text('Booking: ${_formatDate(customer.bookingDate)}'),
                              if (customer.requiredDate != null) Text('Required: ${_formatDate(customer.requiredDate!)}'),
                            ],
                          ),
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => CustomerProfileScreen(customer: customer),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

// ============================================================
// CUSTOMER PROFILE SCREEN (WITH MEASUREMENTS DISPLAY)
// ============================================================

class CustomerProfileScreen extends StatelessWidget {
  final CustomerRecord customer;

  const CustomerProfileScreen({
    super.key,
    required this.customer,
  });

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer: ${customer.name.isEmpty ? 'Unnamed' : customer.name}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Customer Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _infoRow('Suit / Token No.', customer.tokenNumber),
                    _infoRow('Customer Name', customer.name.isEmpty ? 'N/A' : customer.name),
                    _infoRow('Mobile', customer.mobile.isEmpty ? 'N/A' : customer.mobile),
                    _infoRow('Address', customer.address.isEmpty ? 'N/A' : customer.address),
                    _infoRow('Booking Date', _formatDate(customer.bookingDate)),
                    _infoRow(
                      'Required Date',
                      customer.requiredDate == null ? 'Not Selected' : _formatDate(customer.requiredDate!),
                    ),
                    _infoRow('Garment Type', customer.garmentType),
                    _infoRow('Status', customer.status),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Saved Measurements',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: customer.measurements.isEmpty
                    ? const Text('No measurements recorded for this order.')
                    : Column(
                        children: customer.measurements.entries.map((entry) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(entry.key, style: const TextStyle(fontWeight: FontWeight.w600)),
                                Text('${entry.value}″', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo)),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Payment Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _infoRow('Total Amount', 'Rs ${customer.totalAmount.toStringAsFixed(0)}'),
                    _infoRow('Advance Paid', 'Rs ${customer.advance.toStringAsFixed(0)}'),
                    _infoRow('Remaining', 'Rs ${customer.remaining.toStringAsFixed(0)}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 135,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.grey),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}