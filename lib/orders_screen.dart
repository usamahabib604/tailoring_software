import 'package:flutter/material.dart';
import 'models.dart';
import 'new_order_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class OrdersScreen extends StatefulWidget {
  final String title;

  const OrdersScreen({
    super.key, 
    this.title = 'آرڈر لسٹ (Orders List)',
  });

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
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

  int _getCustomerVisitCount(String mobile, String name) {
    if (mobile.trim().isEmpty && name.trim().isEmpty) return 1;
    return savedCustomers.where((c) => 
      (mobile.isNotEmpty && c.mobile == mobile) || 
      (name.isNotEmpty && c.name.toLowerCase() == name.toLowerCase())
    ).length;
  }

  String _generateStatusSummary(CustomerRecord customer) {
    if (customer.status == 'Delivered') return 'Delivered';
    
    int newCount = 0, cutCount = 0, stitchCount = 0, readyCount = 0;
    for (var s in customer.individualStatuses) {
      if (s == 'New Order') newCount++;
      else if (s == 'Cutting') cutCount++;
      else if (s == 'Stitching') stitchCount++;
      else if (s == 'Ready') readyCount++;
    }

    List<String> parts = [];
    if (cutCount > 0) parts.add('$cutCount Cutting');
    if (stitchCount > 0) parts.add('$stitchCount Stitching');
    if (readyCount > 0) parts.add('$readyCount Ready');
    if (newCount > 0) parts.add('$newCount New');

    return parts.isEmpty ? customer.status : parts.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    final query = searchController.text.trim().toLowerCase();
    
    // ★ یہاں ہم نے فلٹر لگایا ہے ★
    final List<CustomerRecord> filteredOrders = savedCustomers.reversed.where((customer) {
      // 1. اگر سکرین 'آرڈر لسٹ' ہے، تو صرف 'New Order' والے دکھاؤ
      if (widget.title.contains('آرڈر لسٹ') && customer.status != 'New Order') {
        return false; 
      }
      
      // 2. سرچ کی منطق
      if (query.isEmpty) return true;
      return customer.name.toLowerCase().contains(query) ||
          customer.mobile.contains(query) ||
          customer.tokenNumber.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF7CB342),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search Orders',
                hintText: 'Name / Mobile / Suit No.',
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
                suffixIcon: query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: searchController.clear,
                      )
                    : null,
              ),
            ),
          ),
          Expanded(
            child: filteredOrders.isEmpty
                ? const Center(child: Text('No orders found.'))
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    itemCount: filteredOrders.length,
                    itemBuilder: (context, index) {
                      final customer = filteredOrders[index];
                      int visitCount = _getCustomerVisitCount(customer.mobile, customer.name);

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Color(0xFF7CB342), width: 1.2),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CustomerFolderScreen(
                                  customer: customer,
                                  visitCount: visitCount,
                                ),
                              ),
                            ).then((_) => setState(() {})); // واپس آنے پر لسٹ ریفریش ہوگی
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: const Color(0xFF7CB342),
                                      child: Text(customer.tokenNumber, style: const TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold)),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          customer.name.isEmpty ? 'Unnamed Customer' : customer.name,
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              customer.mobile.isEmpty ? 'N/A' : customer.mobile, 
                                              style: const TextStyle(fontSize: 12, color: Color(0xFF2E7D32), fontWeight: FontWeight.w600)
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              '(${customer.quantity} Suits)', 
                                              style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold)
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: customer.status == 'Delivered' ? Colors.grey : const Color(0xFF7CB342),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    _generateStatusSummary(customer),
                                    style: const TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// کسٹمر کا ذاتی فولڈر (Customer Folder / Detail Screen)
// ============================================================
class CustomerFolderScreen extends StatefulWidget {
  final CustomerRecord customer;
  final int visitCount;
  const CustomerFolderScreen({super.key, required this.customer, required this.visitCount});

  @override
  State<CustomerFolderScreen> createState() => _CustomerFolderScreenState();
}

class _CustomerFolderScreenState extends State<CustomerFolderScreen> {
  late CustomerRecord currentCustomer;
  int _selectedGroupIndex = 0;

  @override
  void initState() {
    super.initState();
    currentCustomer = widget.customer;
    _syncDataSafely();
  }

  void _syncDataSafely() {
    bool changed = false;
    while (currentCustomer.individualStatuses.length < currentCustomer.quantity) {
      currentCustomer.individualStatuses.add('New Order');
      changed = true;
    }
    if (currentCustomer.individualStatuses.length > currentCustomer.quantity) {
      currentCustomer.individualStatuses = currentCustomer.individualStatuses.sublist(0, currentCustomer.quantity);
      changed = true;
    }
    if (changed) {
      saveAppData();
    }
  }

  void _refreshCurrentCustomer() {
    setState(() {
      try {
        currentCustomer = savedCustomers.firstWhere((c) => c.tokenNumber == currentCustomer.tokenNumber);
        _syncDataSafely();
        if (_selectedGroupIndex >= currentCustomer.requirementGroups.length) {
          _selectedGroupIndex = 0;
        }
      } catch (e) {
        // In case not found, do nothing
      }
    });
  }

  int _getGroupQuantity(RequirementGroup req) {
    try {
      return (req as dynamic).quantity ?? 1;
    } catch (e) {
      return 1;
    }
  }

  String _getShortDistinguishingFeature(RequirementGroup req) {
    String garment = req.garmentType ?? '';
    String neck = '';
    if (req.bandStyle != null && req.bandStyle!.isNotEmpty) {
      neck = '${req.bandStyle!.replaceAll(RegExp(r'Band|Collar', caseSensitive: false), '').trim()} Band';
    } else if (req.collarStyle != null && req.collarStyle!.isNotEmpty) {
      neck = '${req.collarStyle!.replaceAll(RegExp(r'Collar|Band', caseSensitive: false), '').trim()} Collar';
    } else if (req.neckOption != null && req.neckOption!.isNotEmpty) {
      neck = req.neckOption!;
    }

    if (garment.isNotEmpty && neck.isNotEmpty) return '$garment - $neck';
    if (garment.isNotEmpty) return garment;
    if (neck.isNotEmpty) return neck;
    return 'Suit';
  }

  void _openHistoryScreen() {
    List<CustomerRecord> history = savedCustomers.where((c) => 
      (c.mobile.isNotEmpty && c.mobile == currentCustomer.mobile) || 
      (c.name.isNotEmpty && c.name.toLowerCase() == currentCustomer.name.toLowerCase())
    ).toList();
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomerHistoryScreen(customerHistory: history, customerName: currentCustomer.name),
      ),
    ).then((_) {
      _refreshCurrentCustomer();
    });
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _openWhatsApp(String phoneNumber) async {
    String cleanNum = phoneNumber.replaceAll(RegExp(r'[^0-9+]'), '');
    
    if (cleanNum.startsWith('03')) {
      cleanNum = '92' + cleanNum.substring(1);
    } else if (cleanNum.startsWith('+')) {
      cleanNum = cleanNum.substring(1); 
    }

    final Uri launchUri = Uri.parse('https://wa.me/$cleanNum');
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch WhatsApp');
    }
  }

  void _revertIndividualStatus(int index) {
    setState(() {
      String current = currentCustomer.individualStatuses[index];
      if (current == 'Cutting') currentCustomer.individualStatuses[index] = 'New Order';
      else if (current == 'Stitching') currentCustomer.individualStatuses[index] = 'Cutting';
      else if (current == 'Ready') currentCustomer.individualStatuses[index] = 'Stitching';
      
      _updateMainStatus();
    });
  }

  void _advanceIndividualStatus(int index) {
    setState(() {
      String current = currentCustomer.individualStatuses[index];
      if (current == 'New Order') currentCustomer.individualStatuses[index] = 'Cutting';
      else if (current == 'Cutting') currentCustomer.individualStatuses[index] = 'Stitching';
      else if (current == 'Stitching') currentCustomer.individualStatuses[index] = 'Ready';
      
      _updateMainStatus();
    });
  }

  void _updateMainStatus() {
    bool allReady = true;
    bool allNew = true;
    for (var s in currentCustomer.individualStatuses) {
      if (s != 'Ready' && s != 'Delivered') allReady = false;
      if (s != 'New Order') allNew = false;
    }
    
    if (allReady && currentCustomer.status != 'Delivered') {
      currentCustomer.status = 'Ready';
    } else if (allNew) {
      currentCustomer.status = 'New Order';
    } else if (currentCustomer.status != 'Delivered') {
      currentCustomer.status = currentCustomer.individualStatuses.first;
    }
    saveAppData();
  }

  void _showDeliveryDialog() {
    final receivedController = TextEditingController(
      text: currentCustomer.remaining > 0 ? currentCustomer.remaining.toStringAsFixed(0) : '0'
    );

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Deliver Suit & Payment (ڈیلوری اور وصولی)'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total Bill: Rs ${currentCustomer.totalAmount.toStringAsFixed(0)}'),
              Text('Advance Paid: Rs ${currentCustomer.advance.toStringAsFixed(0)}'),
              const Divider(),
              Text('Remaining: Rs ${currentCustomer.remaining.toStringAsFixed(0)}', 
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
              const SizedBox(height: 16),
              TextField(
                controller: receivedController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Amount Received Now (Rs)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.payments),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Cancel')),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: const Color(0xFF7CB342)),
              onPressed: () {
                double receivedNow = double.tryParse(receivedController.text) ?? 0.0;
                setState(() {
                  double totalPaidSoFar = currentCustomer.advance + receivedNow;
                  double newRemaining = currentCustomer.totalAmount - totalPaidSoFar;
                  if (newRemaining < 0) newRemaining = 0;

                  currentCustomer.advance = totalPaidSoFar;
                  currentCustomer.remaining = newRemaining;
                  currentCustomer.status = 'Delivered';
                  for (int i = 0; i < currentCustomer.individualStatuses.length; i++) {
                    currentCustomer.individualStatuses[i] = 'Delivered';
                  }
                });
                saveAppData();
                Navigator.pop(dialogContext);
                
                if (currentCustomer.remaining > 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Suit Delivered! Rs ${currentCustomer.remaining} added to Udhaar.'), backgroundColor: Colors.orange)
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Suit Delivered & Account Cleared!'), backgroundColor: Colors.green)
                  );
                }
              },
              child: const Text('Confirm Delivery'),
            ),
          ],
        );
      },
    );
  }

  void _reorderForCustomer() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewOrderScreen(existingCustomer: currentCustomer, isEditMode: false), 
      ),
    ).then((_) {
      _refreshCurrentCustomer();
    });
  }

  void _editCustomerOrder() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewOrderScreen(existingCustomer: currentCustomer, isEditMode: true), 
      ),
    ).then((_) {
      _refreshCurrentCustomer();
    });
  }

  Widget _buildUniformCell(String label, String value) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: TextStyle(fontSize: 9.5, color: Colors.grey.shade700, fontWeight: FontWeight.w500)),
          const SizedBox(height: 2),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(value.isEmpty ? 'N/A' : value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87)),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalValueCell(String value) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(6),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Text(
          value.isEmpty ? '-' : value, 
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)
        ),
      ),
    );
  }

  Widget _buildRequirementGroupDetails(RequirementGroup reqGroup, int index) {
    String neckVal = reqGroup.measurements['Neck'] ?? '';
    String bandStyle = reqGroup.bandStyle ?? '';
    String collarStyle = reqGroup.collarStyle ?? '';
    
    String neckDetail = '';
    if (bandStyle.isNotEmpty) {
      neckDetail = '${bandStyle.replaceAll(RegExp(r'Band|Collar', caseSensitive: false), '').trim()} Band';
    } else if (collarStyle.isNotEmpty) {
      neckDetail = '${collarStyle.replaceAll(RegExp(r'Collar|Band', caseSensitive: false), '').trim()} Collar';
    }

    if (neckDetail.isNotEmpty && neckVal.isNotEmpty) {
      neckVal = '$neckVal ($neckDetail)';
    } else if (neckDetail.isNotEmpty) {
      neckVal = neckDetail;
    }

    String damanVal = reqGroup.measurements['Daman'] ?? '';
    String damanStyle = reqGroup.measurements['DamanStyle'] ?? '';
    if (damanStyle.isNotEmpty && damanVal.isNotEmpty) {
      damanVal = '$damanVal (${damanStyle.replaceAll(RegExp(r'Daman', caseSensitive: false), '').trim()} Daman)';
    } else if (damanStyle.isNotEmpty) {
      damanVal = damanStyle;
    }

    String sleeveVal = reqGroup.measurements['Sleeve'] ?? '';
    String cuffStyle = reqGroup.cuffCornerStyle ?? '';
    String sleeveOpt = reqGroup.sleeveOption ?? '';
    
    String sleeveDetail = '';
    if (cuffStyle.isNotEmpty) {
      sleeveDetail = '${cuffStyle.replaceAll(RegExp(r'Cuff', caseSensitive: false), '').trim()} Cuff';
    } else if (sleeveOpt.isNotEmpty) {
      sleeveDetail = sleeveOpt;
    }

    if (sleeveDetail.isNotEmpty && sleeveVal.isNotEmpty) {
      sleeveVal = '$sleeveVal ($sleeveDetail)';
    } else if (sleeveDetail.isNotEmpty) {
      sleeveVal = sleeveDetail;
    }

    final List<String> pureMeasurementsValues = [
      reqGroup.measurements['Qameez Length'] ?? '',
      reqGroup.measurements['Sleeve Length'] ?? '',
      reqGroup.measurements['Teera'] ?? '',
      neckVal,
      reqGroup.measurements['Fitting'] ?? '',
      damanVal,
      reqGroup.measurements['Arm Hole'] ?? '',
      sleeveVal,
      reqGroup.measurements['Shalwar Length'] ?? '',
      reqGroup.measurements['Leg Opening'] ?? '',
      reqGroup.measurements['Shalwar Rise Depth'] ?? '',
      reqGroup.measurements['Shalwar Width'] ?? '',
    ];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF7CB342), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.straighten, color: Color(0xFF7CB342), size: 20),
              const SizedBox(width: 6),
              Text('Group ${index + 1} (${reqGroup.garmentType})', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF7CB342))),
            ],
          ),
          const Divider(height: 12),
          
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: pureMeasurementsValues.map((val) => _buildVerticalValueCell(val)).toList(),
                  ),
                ),
              ),
              const SizedBox(width: 8),

              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildBalancedRightRequirements(reqGroup),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSuitTrackingCard(int globalIndex, String sStatus) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Suit #${globalIndex + 1}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (sStatus != 'New Order' && sStatus != 'Delivered')
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade300,
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(6), bottomLeft: Radius.circular(6)),
                    ),
                  ),
                  onPressed: () => _revertIndividualStatus(globalIndex),
                  icon: const Icon(Icons.arrow_back, size: 12),
                  label: Text(_getBackArrowText(sStatus), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                ),

              if (sStatus != 'Ready' && sStatus != 'Delivered')
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7CB342),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(6), bottomRight: Radius.circular(6)),
                    ),
                  ),
                  onPressed: () => _advanceIndividualStatus(globalIndex),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_getForwardArrowText(sStatus), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_forward, size: 12),
                    ],
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: const BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  child: const Text(
                    'Ready',
                    style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = currentCustomer;
    String visitLabel = widget.visitCount == 1 ? 'First Visit' : 'Visit: ${widget.visitCount}';

    List<Widget> trackingWidgets = [];
    int currentGlobalSuitIndex = 0;
    
    for (int gIndex = 0; gIndex < c.requirementGroups.length; gIndex++) {
      RequirementGroup req = c.requirementGroups[gIndex];
      int groupQty = _getGroupQuantity(req);
      String shortFeature = _getShortDistinguishingFeature(req);

      trackingWidgets.add(
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 6),
          child: Text(
            'Group ${gIndex + 1}: $shortFeature ($groupQty Suits)',
            style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2E7D32), fontSize: 13),
          ),
        )
      );

      for (int i = 0; i < groupQty; i++) {
        if (currentGlobalSuitIndex >= c.quantity) break;
        String sStatus = currentGlobalSuitIndex < c.individualStatuses.length ? c.individualStatuses[currentGlobalSuitIndex] : 'New Order';
        trackingWidgets.add(_buildSuitTrackingCard(currentGlobalSuitIndex, sStatus));
        currentGlobalSuitIndex++;
      }
    }
    
    while (currentGlobalSuitIndex < c.quantity) {
      String sStatus = currentGlobalSuitIndex < c.individualStatuses.length ? c.individualStatuses[currentGlobalSuitIndex] : 'New Order';
      trackingWidgets.add(_buildSuitTrackingCard(currentGlobalSuitIndex, sStatus));
      currentGlobalSuitIndex++;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: AppBar(
        title: Text(
          c.name.isEmpty ? 'Unnamed Customer' : c.name,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF7CB342),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            tooltip: 'New Order for this Customer',
            icon: const Icon(Icons.add_circle, size: 28),
            onPressed: _reorderForCustomer, 
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ==========================
          // 1. CUSTOMER INFORMATION BOX
          // ==========================
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFF7CB342), width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.person, color: Color(0xFF7CB342), size: 20),
                        const SizedBox(width: 6),
                        const Text('Customer Information', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF7CB342))),
                      ],
                    ),
                    InkWell(
                      onTap: _openHistoryScreen,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF7CB342).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: const Color(0xFF7CB342).withOpacity(0.5)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.history, size: 13, color: Color(0xFF2E7D32)),
                            const SizedBox(width: 4),
                            Text(visitLabel + ' (ہسٹری)', style: const TextStyle(fontSize: 11, color: Color(0xFF2E7D32), fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(height: 12),
                Row(
                  children: [
                    Expanded(child: _buildUniformCell('Suit No', c.tokenNumber)),
                    const SizedBox(width: 6),
                    Expanded(child: _buildUniformCell('Total Suits', '${c.quantity}')),
                    const SizedBox(width: 6),
                    Expanded(child: _buildUniformCell('Status', c.status)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: _buildUniformCell('Name', c.name)),
                    const SizedBox(width: 6),
                    Expanded(child: _buildUniformCell('Mobile', c.mobile)),
                    const SizedBox(width: 6),
                    Expanded(child: _buildUniformCell('Address', c.address)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: _buildUniformCell('Total Bill', 'Rs ${c.totalAmount.toStringAsFixed(0)}')),
                    const SizedBox(width: 6),
                    Expanded(child: _buildUniformCell('Advance', 'Rs ${c.advance.toStringAsFixed(0)}')),
                    const SizedBox(width: 6),
                    Expanded(child: _buildUniformCell('Remaining', 'Rs ${c.remaining.toStringAsFixed(0)}')),
                  ],
                ),
              ],
            ),
          ),

          // Edit Button for Measurements
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Color(0xFF7CB342)),
                tooltip: 'Edit Measurements',
                onPressed: () {
                  _editCustomerOrder();
                },
              ),
            ],
          ),

          // ==========================================================
          // 2. NAVIGATION BAR (Tabs) AND SELECTED GROUP DETAILS
          // ==========================================================
          if (c.requirementGroups.length > 1)
            Container(
              height: 40,
              margin: const EdgeInsets.only(bottom: 12),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: c.requirementGroups.length,
                itemBuilder: (context, index) {
                  bool isSelected = _selectedGroupIndex == index;
                  int gQty = _getGroupQuantity(c.requirementGroups[index]);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedGroupIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF7CB342) : Colors.white,
                        border: Border.all(color: const Color(0xFF7CB342)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          'Group ${index + 1} ($gQty)',
                          style: TextStyle(
                            color: isSelected ? Colors.white : const Color(0xFF7CB342),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            
          if (c.requirementGroups.isNotEmpty)
            _buildRequirementGroupDetails(c.requirementGroups[_selectedGroupIndex], _selectedGroupIndex),

          // ==========================
          // 3. SUIT TRACKING BOX
          // ==========================
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFF7CB342), width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.local_shipping, color: Color(0xFF7CB342), size: 20),
                    const SizedBox(width: 6),
                    const Text('سوٹ ٹریکنگ (Suit Tracking)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF7CB342))),
                  ],
                ),
                const Divider(height: 12),
                
                if (c.status == 'Delivered')
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('All suits have been delivered.', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                  )
                else
                  ...trackingWidgets,

                if (c.status == 'Ready')
                   Padding(
                     padding: const EdgeInsets.only(top: 6),
                     child: SizedBox(
                       width: double.infinity,
                       child: FilledButton.icon(
                         style: FilledButton.styleFrom(backgroundColor: Colors.purple, padding: const EdgeInsets.symmetric(vertical: 10)),
                         onPressed: _showDeliveryDialog,
                         icon: const Icon(Icons.local_shipping),
                         label: const Text('Deliver All Suits', style: TextStyle(fontSize: 15)),
                       ),
                     ),
                   ),
              ],
            ),
          ),

          // ==========================
          // 4. PERSISTENT CLICKABLE WHATSAPP & CALL CONTACT BUTTONS
          // ==========================
          if (c.mobile.isNotEmpty)
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () => _makePhoneCall(c.mobile),
                    icon: const Icon(Icons.phone),
                    label: const Text('Call Customer', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () => _openWhatsApp(c.mobile),
                    icon: const Icon(Icons.chat),
                    label: const Text('WhatsApp', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  String _cleanPocketLabel(String? val, String type) {
    if (val == null || val == 'None' || val.trim().isEmpty) {
      return 'None $type Pocket';
    }
    String cleaned = val.replaceAll(RegExp(r'Pockets?', caseSensitive: false), '').trim();
    return '$cleaned $type Pocket';
  }

  List<Widget> _buildBalancedRightRequirements(RequirementGroup req) {
    List<String> values = [];

    if (req.shalwarType != null) values.add(req.shalwarType!);
    if (req.shalwarStyle != null) values.add(req.shalwarStyle!);
    if (req.waistOption != null) values.add(req.waistOption!);
    if (req.measurements['Poncha Stitching'] != null) values.add(req.measurements['Poncha Stitching']!);

    if (req.buttonPlacketSide != null) {
      String side = req.buttonPlacketSide!.trim();
      if (!side.toLowerCase().contains('placket')) {
        values.add('$side Placket');
      } else {
        values.add(side);
      }
    }

    if (req.buttonStyle != null) values.add(req.buttonStyle!);
    
    values.add(_cleanPocketLabel(req.frontPocket, 'Front'));
    values.add(_cleanPocketLabel(req.sidePocket, 'Side'));
    values.add(_cleanPocketLabel(req.shalwarPocket, 'Shalwar'));

    if (req.stitchingOption != null) values.add(req.stitchingOption!);
    if (req.interfacingWidth != null) values.add(req.interfacingWidth!);
    if (req.measurements['Interfacing Quality'] != null) values.add(req.measurements['Interfacing Quality']!);

    if (values.isEmpty) {
      return [const Text('None', style: TextStyle(fontSize: 12, color: Colors.grey))];
    }

    return values.map((val) => _buildVerticalValueCell(val)).toList();
  }

  String _getBackArrowText(String status) {
    if (status == 'Cutting') return 'New Order';
    if (status == 'Stitching') return 'Cutting';
    if (status == 'Ready') return 'Stitching';
    return '';
  }

  String _getForwardArrowText(String status) {
    if (status == 'New Order') return 'Cutting';
    if (status == 'Cutting') return 'Stitching';
    if (status == 'Stitching') return 'Ready';
    return '';
  }
}

class CustomerHistoryScreen extends StatelessWidget {
  final List<CustomerRecord> customerHistory;
  final String customerName;

  const CustomerHistoryScreen({super.key, required this.customerHistory, required this.customerName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History: $customerName', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF7CB342),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: customerHistory.isEmpty
          ? const Center(child: Text('No history found.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: customerHistory.length,
              itemBuilder: (context, index) {
                final record = customerHistory[index];
                String dateStr = '${record.bookingDate.day}/${record.bookingDate.month}/${record.bookingDate.year}';
                
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFF7CB342),
                      child: Text('${index + 1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    title: Text('Visit ${index + 1} ($dateStr)', style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${record.garmentType} (${record.quantity} Suits) - Token: ${record.tokenNumber}'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF7CB342)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CustomerFolderScreen(
                            customer: record,
                            visitCount: index + 1,
                          ),
                        ),
                      ).then((_) {});
                    },
                  ),
                );
              },
            ),
    );
  }
}