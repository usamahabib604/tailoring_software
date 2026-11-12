import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models.dart';

class ReportingContent extends StatefulWidget {
  const ReportingContent({super.key});

  @override
  State<ReportingContent> createState() => _ReportingContentState();
}

class _ReportingContentState extends State<ReportingContent> {
  final Color parrotGreen = const Color(0xFF7CB342);
  final Color darkGreenText = const Color(0xFF2E7D32);
  final Color bgColor = const Color(0xFFF5F6F8);

  String selectedReport = 'Item list'; // Default
  
  // Filters State
  String selectedCustomerFilter = 'All Customers';
  String selectedUserFilter = 'All Users';
  String selectedProductFilter = 'All Products';
  String selectedGroupFilter = 'All Groups';
  
  // Date Period Filter State
  DateTime startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime endDate = DateTime.now();
  String selectedPeriodLabel = 'This month';

  bool showReportResults = false;

  // Shop Details for PDF
  String shopName = "Your Shop Name";
  String shopSubtitle = "Address & Contact Info";

  @override
  void initState() {
    super.initState();
    _loadShopDetails();
  }

  Future<void> _loadShopDetails() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      shopName = prefs.getString('shopName') ?? "Your Shop Name";
      shopSubtitle = prefs.getString('shopSubtitle') ?? "Address & Contact Info";
    });
  }

  // ==========================================================================
  // ARONIUM STYLE PERIOD PICKER DIALOG
  // ==========================================================================
  void _showAroniumPeriodPickerDialog() {
    DateTime tempStart = startDate;
    DateTime tempEnd = endDate;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            void applyPredefined(String type) {
              DateTime now = DateTime.now();
              setDialogState(() {
                selectedPeriodLabel = type;
                if (type == 'Today') {
                  tempStart = DateTime(now.year, now.month, now.day);
                  tempEnd = DateTime(now.year, now.month, now.day, 23, 59, 59);
                } else if (type == 'Yesterday') {
                  DateTime y = now.subtract(const Duration(days: 1));
                  tempStart = DateTime(y.year, y.month, y.day);
                  tempEnd = DateTime(y.year, y.month, y.day, 23, 59, 59);
                } else if (type == 'This week') {
                  int weekday = now.weekday;
                  tempStart = now.subtract(Duration(days: weekday - 1));
                  tempEnd = now;
                } else if (type == 'Last week') {
                  DateTime lastWeek = now.subtract(const Duration(days: 7));
                  int weekday = lastWeek.weekday;
                  tempStart = lastWeek.subtract(Duration(days: weekday - 1));
                  tempEnd = tempStart.add(const Duration(days: 6));
                } else if (type == 'This month') {
                  tempStart = DateTime(now.year, now.month, 1);
                  tempEnd = now;
                } else if (type == 'Last month') {
                  DateTime lastMonth = DateTime(now.year, now.month - 1, 1);
                  tempStart = lastMonth;
                  tempEnd = DateTime(now.year, now.month, 0, 23, 59, 59);
                } else if (type == 'This year') {
                  tempStart = DateTime(now.year, 1, 1);
                  tempEnd = now;
                } else if (type == 'Last Year') {
                  tempStart = DateTime(now.year - 1, 1, 1);
                  tempEnd = DateTime(now.year - 1, 12, 31, 23, 59, 59);
                }
              });
            }

            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              title: Column(
                children: [
                  const Text('Period', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(color: parrotGreen, borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      '${DateFormat('MM/dd/yyyy').format(tempStart)} - ${DateFormat('MM/dd/yyyy').format(tempEnd)}',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ),
                ],
              ),
              content: SizedBox(
                width: 680,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Start Calendar Box
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Start', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                          const SizedBox(height: 4),
                          SizedBox(
                            height: 280,
                            child: CalendarDatePicker(
                              initialDate: tempStart,
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2030),
                              onDateChanged: (d) => setDialogState(() => tempStart = d),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // End Calendar Box
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('End', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                          const SizedBox(height: 4),
                          SizedBox(
                            height: 280,
                            child: CalendarDatePicker(
                              initialDate: tempEnd,
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2030),
                              onDateChanged: (d) => setDialogState(() => tempEnd = d),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Predefined Filters & Action Buttons
                    SizedBox(
                      width: 180,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text('Predefined period', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey)),
                          const SizedBox(height: 6),
                          _buildPeriodButton('Today', applyPredefined),
                          _buildPeriodButton('Yesterday', applyPredefined),
                          _buildPeriodButton('This week', applyPredefined),
                          _buildPeriodButton('Last week', applyPredefined),
                          _buildPeriodButton('This month', applyPredefined),
                          _buildPeriodButton('Last month', applyPredefined),
                          _buildPeriodButton('This year', applyPredefined),
                          _buildPeriodButton('Last Year', applyPredefined),
                          const Spacer(),
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 38,
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      side: const BorderSide(color: Colors.red),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancel', style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: SizedBox(
                                  height: 38,
                                  child: FilledButton(
                                    style: FilledButton.styleFrom(
                                      backgroundColor: parrotGreen,
                                      padding: EdgeInsets.zero,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        startDate = tempStart;
                                        endDate = tempEnd;
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
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

  Widget _buildPeriodButton(String title, Function(String) onTap) {
    bool isSelected = selectedPeriodLabel == title;
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: isSelected ? parrotGreen.withOpacity(0.1) : Colors.white,
          side: BorderSide(color: isSelected ? parrotGreen : Colors.grey.shade300),
          padding: const EdgeInsets.symmetric(vertical: 8),
        ),
        onPressed: () => onTap(title),
        child: Text(title, style: TextStyle(fontSize: 12, color: isSelected ? darkGreenText : Colors.black87, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // === Real Data for Dropdowns ===
    List < String > customerList = ['All Customers'];
    customerList.addAll(savedCustomers.map((c) => c.name).toList());

    List < String > productList = ['All Products'];
    productList.addAll(posProducts.map((p) => p.name).toList());

    List < String > groupList = ['All Groups'];
    var uniqueGroups = posProducts.map((p) => p.groupName).where((g) => g.isNotEmpty).toSet().toList();
    groupList.addAll(uniqueGroups);

    List < String > userList = ['All Users', 'Admin']; 

    return Container(
      color: bgColor,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: parrotGreen,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.analytics, color: Colors.white, size: 16),
                SizedBox(width: 8),
                Text('Reports Center', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
              ],
            ),
          ),

          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Left Side: Reports List ---
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          color: Colors.grey.shade100,
                          width: double.infinity,
                          child: const Text('Available Reports', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black54)),
                        ),
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.zero,
                            children: [
                              _buildReportItem('Products', Icons.inventory_2),
                              _buildReportItem('Product groups', Icons.category),
                              _buildReportItem('Customers', Icons.people),
                              _buildReportItem('Users', Icons.admin_panel_settings),
                              _buildReportItem('Item list', Icons.list_alt), 
                              _buildReportItem('Payment types', Icons.payment),
                              _buildReportItem('Refunds', Icons.replay),
                              _buildReportItem('Invoice list', Icons.receipt_long), 
                              _buildReportItem('Daily sales', Icons.calendar_today),
                              _buildReportItem('Hourly sales', Icons.access_time), 
                              _buildReportItem('Unpaid Sales (Udhaar)', Icons.money_off), 
                              _buildReportItem('Profit & margin', Icons.trending_up), 
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(width: 1, color: Colors.grey.shade300),

                  // --- Right Side: Filter & Action Panel OR Report Results ---
                  Expanded(
                    flex: 7,
                    child: showReportResults ? _buildReportResultsView() : _buildFilterPanelView(customerList, userList, productList, groupList),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================================
  // FILTER PANEL (Right Side)
  // ==========================================================================
  Widget _buildFilterPanelView(List < String > customerList, List < String > userList, List < String > productList, List < String > groupList) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.grey.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Filters for: $selectedReport', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
          const Divider(height: 24),
          
          Row(
            children: [
              Expanded(child: _buildInteractiveDropdown('Select Customer', selectedCustomerFilter, customerList, (v) => setState(() => selectedCustomerFilter = v!))),
              const SizedBox(width: 16),
              Expanded(child: _buildInteractiveDropdown('Select Product', selectedProductFilter, productList, (v) => setState(() => selectedProductFilter = v!))),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildInteractiveDropdown('Select User', selectedUserFilter, userList, (v) => setState(() => selectedUserFilter = v!))),
              const SizedBox(width: 16),
              Expanded(child: _buildInteractiveDropdown('Product Group', selectedGroupFilter, groupList, (v) => setState(() => selectedGroupFilter = v!))),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Date Period (Daily/Weekly/Monthly)', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    InkWell(
                      onTap: _showAroniumPeriodPickerDialog,
                      child: Container(
                        height: 38,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(4), color: Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.calendar_month, size: 18, color: Colors.grey),
                            Text('${DateFormat('MM/dd/yyyy').format(startDate)} - ${DateFormat('MM/dd/yyyy').format(endDate)}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                            const Icon(Icons.arrow_drop_down, size: 18, color: Colors.grey),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(child: SizedBox()),
            ],
          ),

          const Spacer(),
          const Divider(),
          const SizedBox(height: 8),

          // ★ Action Buttons ★
          Row(
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 45,
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(backgroundColor: parrotGreen),
                    onPressed: () => setState(() => showReportResults = true),
                    icon: const Icon(Icons.remove_red_eye),
                    label: const Text('Show Report', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 45,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(foregroundColor: Colors.black87, side: BorderSide(color: Colors.grey.shade400)),
                    onPressed: () => _generateAndExportPdf(isPrint: true),
                    icon: const Icon(Icons.print),
                    label: const Text('Print'),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 45,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(foregroundColor: Colors.red.shade700, side: BorderSide(color: Colors.red.shade200)),
                    onPressed: () => _generateAndExportPdf(isPrint: false),
                    icon: const Icon(Icons.picture_as_pdf),
                    label: const Text('PDF'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==========================================================================
  // DATA LOGIC 
  // ==========================================================================
  Map < String , dynamic > _getReportData() {
    List < String > headers = [];
    List < List < String > > rows = [];
    List < String > totalsRow = [];

    var filteredInvoices = invoiceHistory.where((inv) {
      if (selectedCustomerFilter != 'All Customers' && inv.customerName != selectedCustomerFilter) return false;
      if (inv.date != null) {
        if (inv.date!.isBefore(startDate) || inv.date!.isAfter(endDate.add(const Duration(days: 1)))) return false;
      }
      return true;
    }).toList();

    if (selectedReport == 'Products') {
      headers = ['Code', 'Product Name', 'Group', 'Selling Price', 'Current Stock'];
      for (var p in posProducts) {
        if (selectedProductFilter != 'All Products' && p.name != selectedProductFilter) continue;
        if (selectedGroupFilter != 'All Groups' && p.groupName != selectedGroupFilter) continue;
        rows.add([p.id, p.name, p.groupName.isEmpty ? '-' : p.groupName, p.sellingPrice.toString(), p.stockQuantity.toString()]);
      }
    } 
    else if (selectedReport == 'Product groups') {
      headers = ['Group Name', 'Total Items', 'Total Stock Qty'];
      Map < String , int > groupItems = {};
      Map < String , double > groupStock = {};
      for (var p in posProducts) {
        if (selectedGroupFilter != 'All Groups' && p.groupName != selectedGroupFilter) continue;
        String gName = p.groupName.isEmpty ? 'Un-grouped' : p.groupName;
        groupItems[gName] = (groupItems[gName] ?? 0) + 1;
        groupStock[gName] = (groupStock[gName] ?? 0) + p.stockQuantity;
      }
      groupItems.forEach((gName, count) {
        rows.add([gName, count.toString(), groupStock[gName]!.toStringAsFixed(0)]);
      });
    }
    else if (selectedReport == 'Item list') {
      headers = ['Product Name', 'Total Qty Sold', 'Total Revenue (Rs)'];
      Map < String , double > qtySold = {};
      Map < String , double > revenue = {};
      for (var inv in filteredInvoices) {
        for (var item in inv.items) {
          if (selectedProductFilter != 'All Products' && item.product.name != selectedProductFilter) continue;
          if (selectedGroupFilter != 'All Groups' && item.product.groupName != selectedGroupFilter) continue;
          qtySold[item.product.name] = (qtySold[item.product.name] ?? 0) + item.quantity;
          revenue[item.product.name] = (revenue[item.product.name] ?? 0) + (item.quantity * item.sellingPrice);
        }
      }
      qtySold.forEach((key, value) {
        rows.add([key, value.toStringAsFixed(0), revenue[key]!.toStringAsFixed(0)]);
      });
    }
    else if (selectedReport == 'Payment types') {
      headers = ['Payment Method', 'No. of Bills', 'Total Amount (Rs)'];
      Map < String , double > payTotals = {};
      Map < String , int > payCounts = {};
      for (var inv in filteredInvoices) {
        String pType = inv.paymentType;
        payTotals[pType] = (payTotals[pType] ?? 0) + inv.cashTendered;
        payCounts[pType] = (payCounts[pType] ?? 0) + 1;
      }
      payTotals.forEach((key, val) {
        rows.add([key, payCounts[key].toString(), val.toStringAsFixed(0)]);
      });
    }
    else if (selectedReport == 'Users') {
      headers = ['User Name', 'Bills Generated', 'Revenue Generated'];
      double totalRev = filteredInvoices.fold(0, (sum, inv) => sum + inv.totalAmount);
      rows.add(['Admin', filteredInvoices.length.toString(), totalRev.toStringAsFixed(0)]);
    }
    else if (selectedReport == 'Refunds') {
      headers = ['Inv ID', 'Date', 'Customer', 'Refund Amount'];
      rows.add(['-', 'No refunds available yet', '-', '-']);
    }
    else if (selectedReport == 'Invoice list') {
      headers = ['Inv ID', 'Date & Time', 'Customer', 'Total Bill', 'Discount', 'Paid'];
      for (var inv in filteredInvoices) {
        rows.add([
          inv.invoiceId, 
          DateFormat('dd MMM yyyy, hh:mm a').format(inv.date), 
          inv.customerName.isNotEmpty ? inv.customerName : 'Walk-in', 
          inv.totalAmount.toStringAsFixed(0),
          inv.discount.toStringAsFixed(0),
          inv.cashTendered.toStringAsFixed(0)
        ]);
      }
    }
    else if (selectedReport == 'Daily sales') {
      headers = ['Date', 'Total Bills', 'Total Sales (Rs)'];
      Map < String , double > dailyTotals = {};
      Map < String , int > dailyCounts = {};
      for (var inv in filteredInvoices) {
        String day = DateFormat('dd MMM yyyy').format(inv.date);
        dailyTotals[day] = (dailyTotals[day] ?? 0) + inv.totalAmount;
        dailyCounts[day] = (dailyCounts[day] ?? 0) + 1;
      }
      dailyTotals.forEach((key, val) {
        rows.add([key, dailyCounts[key].toString(), val.toStringAsFixed(0)]);
      });
    }
    else if (selectedReport == 'Hourly sales') {
      headers = ['Time Window (Hour)', 'Total Bills', 'Sales Revenue (Rs)'];
      Map < int , double > hourlySales = {};
      Map < int , int > hourlyCounts = {};
      
      for (var inv in filteredInvoices) {
        int h = inv.date.hour;
        hourlySales[h] = (hourlySales[h] ?? 0) + inv.totalAmount;
        hourlyCounts[h] = (hourlyCounts[h] ?? 0) + 1;
      }

      var sortedHours = hourlySales.keys.toList()..sort();

      for (int h in sortedHours) {
        int nextHour = (h + 1) % 24;
        String startAMPM = h >= 12 ? 'PM' : 'AM';
        String endAMPM = nextHour >= 12 ? 'PM' : 'AM';
        int displayStart = h == 0 ? 12 : (h > 12 ? h - 12 : h);
        int displayEnd = nextHour == 0 ? 12 : (nextHour > 12 ? nextHour - 12 : nextHour);
        
        String timeWindow = '$displayStart:00 $startAMPM to $displayEnd:00 $endAMPM';
        
        rows.add([
          timeWindow, 
          hourlyCounts[h].toString(), 
          hourlySales[h]!.toStringAsFixed(0)
        ]);
      }
    }
    else if (selectedReport == 'Unpaid Sales (Udhaar)') {
      headers = ['Inv ID', 'Date', 'Customer', 'Total Bill', 'Paid', 'Remaining (Udhaar)'];
      for (var inv in filteredInvoices) {
        double remaining = inv.totalAmount - inv.cashTendered - inv.discount;
        if (remaining > 0) {
          rows.add([
            inv.invoiceId, 
            DateFormat('dd MMM yyyy').format(inv.date), 
            inv.customerName.isNotEmpty ? inv.customerName : 'Walk-in', 
            inv.totalAmount.toStringAsFixed(0),
            inv.cashTendered.toStringAsFixed(0),
            remaining.toStringAsFixed(0)
          ]);
        }
      }
    }
    else if (selectedReport == 'Profit & margin') {
      headers = ['Inv ID', 'Customer', 'Quantity', 'Cost', 'Revenue', 'Margin %', 'Net Profit (Rs)'];
      double sumQty = 0;
      double sumCost = 0;
      double sumRev = 0;
      double sumProfit = 0;

      for (var inv in filteredInvoices) {
        double rev = inv.totalAmount;
        double cost = inv.totalCost;
        double profit = inv.profit;
        double marginPct = rev > 0 ? (profit / rev) * 100 : 0.0;
        
        double totalQty = inv.items.fold(0, (qSum, item) => qSum + item.quantity);

        sumQty += totalQty;
        sumCost += cost;
        sumRev += rev;
        sumProfit += profit;

        rows.add([
          inv.invoiceId,
          inv.customerName.isNotEmpty ? inv.customerName : 'Walk-in',
          totalQty.toStringAsFixed(0),
          cost.toStringAsFixed(0),
          rev.toStringAsFixed(0),
          '${marginPct.toStringAsFixed(1)}%',
          profit.toStringAsFixed(0)
        ]);
      }

      double totalMarginPct = sumRev > 0 ? (sumProfit / sumRev) * 100 : 0.0;
      totalsRow = [
        'Total',
        '-',
        sumQty.toStringAsFixed(0),
        sumCost.toStringAsFixed(0),
        sumRev.toStringAsFixed(0),
        '${totalMarginPct.toStringAsFixed(1)}%',
        sumProfit.toStringAsFixed(0)
      ];
    }
    else if (selectedReport == 'Customers') {
      headers = ['Customer Name', 'Phone', 'Total Visits', 'Total Purchased (Rs)'];
      for (var cust in savedCustomers) {
        if (selectedCustomerFilter != 'All Customers' && cust.name != selectedCustomerFilter) continue;
        if (cust.name.isEmpty) continue;
        
        var custInvoices = invoiceHistory.where((inv) {
          if (inv.customerName != cust.name) return false;
          if (inv.date != null) {
            if (inv.date!.isBefore(startDate) || inv.date!.isAfter(endDate.add(const Duration(days: 1)))) return false;
          }
          return true;
        }).toList();

        double totalSpent = custInvoices.fold(0, (sum, inv) => sum + inv.totalAmount);
        
        rows.add([cust.name, cust.mobile, custInvoices.length.toString(), totalSpent.toStringAsFixed(0)]);
      }
    }

    return {'headers': headers, 'rows': rows, 'totalsRow': totalsRow};
  }

  // ==========================================================================
  // UI TABLE VIEW (Aronium / Excel Style Grid with Alternating Colors)
  // ==========================================================================
  Widget _buildReportResultsView() {
    var data = _getReportData();
    List < String > headers = data['headers'];
    List < List < String > > rows = data['rows'];
    List < String > totalsRow = data['totalsRow'] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
           padding: const EdgeInsets.all(12),
           color: parrotGreen.withOpacity(0.1),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Row(
                 children: [
                   IconButton(icon: const Icon(Icons.arrow_back, size: 20), onPressed: () => setState(() => showReportResults = false)),
                   Text('Report: $selectedReport', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: darkGreenText)),
                 ],
               ),
               Text('Period: ${DateFormat('MM/dd/yyyy').format(startDate)} - ${DateFormat('MM/dd/yyyy').format(endDate)}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
             ],
           ),
        ),
        
        Expanded(
          child: rows.isEmpty 
            ? const Center(child: Text('No data found for this report and period.', style: TextStyle(color: Colors.grey, fontSize: 16)))
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Table(
                    border: TableBorder.all(color: Colors.grey.shade300, width: 1),
                    defaultColumnWidth: const IntrinsicColumnWidth(),
                    children: [
                      // Header Row
                      TableRow(
                        decoration: BoxDecoration(color: Colors.grey.shade200),
                        children: headers.map((h) {
                          return TableCell(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              child: Text(
                                h,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      // Data Rows with Alternating Colors
                      for (int i = 0; i < rows.length; i++)
                        TableRow(
                          decoration: BoxDecoration(
                            color: i % 2 == 0 ? Colors.white : Colors.grey.shade100,
                          ),
                          children: rows[i].map((cell) {
                            return TableCell(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                                constraints: const BoxConstraints(minWidth: 100, maxWidth: 250),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    cell,
                                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      
                      // Totals Row
                      if (totalsRow.isNotEmpty)
                        TableRow(
                          decoration: BoxDecoration(color: parrotGreen.withOpacity(0.15)),
                          children: totalsRow.map((cell) {
                            return TableCell(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                constraints: const BoxConstraints(minWidth: 100, maxWidth: 250),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    cell,
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                    ],
                  ),
                ),
              ),
        )
      ],
    );
  }

  // ==========================================================================
  // PDF GENERATION & PRINTING LOGIC
  // ==========================================================================
  Future<void> _generateAndExportPdf({required bool isPrint}) async {
    final pdf = pw.Document();
    
    final fontData = await rootBundle.load('assets/fonts/urdu_font.ttf');
    final ttf = pw.Font.ttf(fontData);

    var data = _getReportData();
    List < String > headers = data['headers'];
    List < List < String > > rows = data['rows'];
    List < String > totalsRow = data['totalsRow'] ?? [];

    List < List < String > > pdfRows = List.from(rows);
    if (totalsRow.isNotEmpty) {
      pdfRows.add(totalsRow);
    }

    pdf.addPage(
      pw.MultiPage(
        theme: pw.ThemeData.withFont(base: ttf),
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            pw.Center(
              child: pw.Column(
                children: [
                  pw.Text(shopName, style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold, color: PdfColors.green800)),
                  pw.SizedBox(height: 4),
                  pw.Text(shopSubtitle, style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey700)),
                  pw.SizedBox(height: 20),
                ]
              )
            ),
            
            pw.Container(
              padding: const pw.EdgeInsets.all(10),
              decoration: pw.BoxDecoration(color: PdfColors.grey200, borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4))),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Report: $selectedReport', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                  pw.Text('Period: ${DateFormat('MM/dd/yyyy').format(startDate)} - ${DateFormat('MM/dd/yyyy').format(endDate)}', style: const pw.TextStyle(fontSize: 12)),
                ]
              )
            ),
            pw.SizedBox(height: 20),

            if (pdfRows.isEmpty)
              pw.Center(child: pw.Text("No data available for this report.", style: const pw.TextStyle(fontSize: 14, color: PdfColors.grey)))
            else
              pw.TableHelper.fromTextArray(
                headers: headers,
                data: pdfRows,
                border: pw.TableBorder.all(color: PdfColors.grey400, width: 0.5),
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white),
                headerDecoration: const pw.BoxDecoration(color: PdfColors.green700),
                cellHeight: 25,
                cellAlignments: { for (var i = 0; i < headers.length; i++) i : pw.Alignment.centerLeft },
              ),
              
            pw.SizedBox(height: 30),
            
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Generated by Tailoring & POS System', style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey500)),
                pw.Text('Date: ${DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.now())}', style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey500)),
              ]
            )
          ];
        },
      ),
    );

    if (isPrint) {
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save(),
        name: '${selectedReport}_Report',
      );
    } else {
      await Printing.sharePdf(
        bytes: await pdf.save(),
        filename: '${selectedReport.replaceAll(' ', '_')}_Report.pdf',
      );
    }
  }

  // ==========================================================================
  // HELPER WIDGETS
  // ==========================================================================
  Widget _buildReportItem(String title, IconData icon) {
    bool isSelected = selectedReport == title;
    return InkWell(
      onTap: () {
        setState(() {
          selectedReport = title;
          showReportResults = false; 
        });
      },
      child: Container(
        color: isSelected ? parrotGreen.withOpacity(0.15) : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 18, color: isSelected ? darkGreenText : Colors.grey.shade500),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title, 
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13, 
                  color: isSelected ? darkGreenText : Colors.black87,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractiveDropdown(String label, String currentValue, List < String > items, ValueChanged < String? > onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Container(
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton < String > (
              isExpanded: true,
              value: currentValue,
              icon: const Icon(Icons.arrow_drop_down, size: 20, color: Colors.grey),
              style: const TextStyle(fontSize: 13, color: Colors.black87),
              items: items.map((String val) {
                return DropdownMenuItem < String > (
                  value: val,
                  child: Text(val, overflow: TextOverflow.ellipsis),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}