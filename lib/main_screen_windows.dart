import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'package:shared_preferences/shared_preferences.dart';
import 'models.dart';

// Main screens
import 'new_order_screen.dart'; 
import 'orders_screen.dart'; 
import 'production_screen.dart';
import 'dashboard.dart';
import 'reports_screen.dart';
import 'management/products_content.dart'; 

// Hamburger menu screens
import 'payments_screen.dart';
import 'users_screen.dart';
import 'settings_screen.dart';
import 'shop_profile_screen.dart';
import 'cloud_sync_screen.dart';
import 'help_guide_screen.dart';
import 'contact_us_screen.dart';
import 'staff_ledger_screen.dart'; 
import 'pos_three_dots_dialog.dart';

class MainScreenWindows extends StatefulWidget {
  const MainScreenWindows({super.key});

  @override
  State<MainScreenWindows> createState() => _MainScreenWindowsState();
}

class _MainScreenWindowsState extends State<MainScreenWindows> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;

  String shopName = "Your Shop Name"; 
  String shopSubtitle = "Premium Stitching Center";
  String? logoImagePath; 

  // Controllers
  final TextEditingController searchCtrl = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  String searchQuery = '';
  
  final List < Map < String , dynamic > > posCart = [];

  final Color parrotGreen = const Color(0xFF7CB342);
  final Color creamColor = const Color(0xFFFFFDD0);
  final Color darkGreenText = const Color(0xFF2E7D32);
  final Color bgColor = const Color(0xFFF5F6F8); 
  
  // Keyboard Navigation Variables
  int _focusedSearchResultIndex = -1;
  List<PosProduct> searchResults = [];

  // ★ Invoice Save karne ke liye temporary variables ★
  double _tempTotalAmount = 0.0;
  double _tempDiscount = 0.0;
  double _tempCashTendered = 0.0;

  @override
  void initState() {
    super.initState();
    _loadShopData();
    _setupKeyboardShortcuts(); 
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  Future<void> _loadShopData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      shopName = prefs.getString('shopName') ?? "Your Shop Name";
      shopSubtitle = prefs.getString('shopSubtitle') ?? "Premium Stitching Center";
      logoImagePath = prefs.getString('shopLogo');
    });
  }

  // ============================================================================
  // Keyboard Interceptor
  // ============================================================================
  void _setupKeyboardShortcuts() {
    searchFocusNode.onKeyEvent = (node, event) {
      if (event is KeyDownEvent) {
        if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
          if (searchResults.isNotEmpty) {
            setState(() {
              _focusedSearchResultIndex = (_focusedSearchResultIndex + 1) % searchResults.length;
            });
          }
          return KeyEventResult.handled;
        } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
          if (searchResults.isNotEmpty) {
            setState(() {
              _focusedSearchResultIndex = (_focusedSearchResultIndex - 1 + searchResults.length) % searchResults.length;
            });
          }
          return KeyEventResult.handled;
        } else if (event.logicalKey == LogicalKeyboardKey.f9) {
          if (posCart.isNotEmpty) {
            _showPaymentPopup(_calculateTotal());
          }
          return KeyEventResult.handled;
        }
      }
      return KeyEventResult.ignored;
    };
  }

  double _calculateTotal() {
    return posCart.fold(0, (sum, item) => sum + (item['customPrice'] * item['qty']));
  }

  // ============================================================================
  // Aronium Style: Ask for Price and Qty on product select
  // ============================================================================
  void _onProductSelected(PosProduct product) {
    _showAroniumPricePopup(product);
  }

  void _showAroniumPricePopup(PosProduct product) {
    TextEditingController priceCtrl = TextEditingController(text: product.sellingPrice.toStringAsFixed(0));
    priceCtrl.selection = TextSelection(baseOffset: 0, extentOffset: priceCtrl.text.length);
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey.shade900,
          title: const Text('Change Price', style: TextStyle(color: Colors.white, fontSize: 16)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Product: "${product.name}"', style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
              Text('Default Price: ${product.sellingPrice}', style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
              const SizedBox(height: 10),
              TextField(
                controller: priceCtrl,
                autofocus: true,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  filled: true, fillColor: Colors.blueGrey.shade800,
                  border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                ),
                onSubmitted: (val) {
                  Navigator.pop(context);
                  _showAroniumQtyPopup(product, val);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAroniumQtyPopup(PosProduct product, String customPriceStr) {
    TextEditingController qtyCtrl = TextEditingController(text: "1");
    qtyCtrl.selection = TextSelection(baseOffset: 0, extentOffset: qtyCtrl.text.length);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey.shade900,
          title: const Text('Change Quantity', style: TextStyle(color: Colors.white, fontSize: 16)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Product: "${product.name}"', style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
              const SizedBox(height: 10),
              TextField(
                controller: qtyCtrl,
                autofocus: true,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  filled: true, fillColor: Colors.blueGrey.shade800,
                  border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                ),
                onSubmitted: (val) {
                  Navigator.pop(context);
                  _finalizeAddToCart(product, customPriceStr, val);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _finalizeAddToCart(PosProduct product, String priceStr, String qtyStr) {
    double finalPrice = double.tryParse(priceStr) ?? product.sellingPrice;
    double finalQty = double.tryParse(qtyStr) ?? 1.0;

    setState(() {
      var existingItem = posCart.firstWhere(
        (item) => item['product'].id == product.id && item['customPrice'] == finalPrice, 
        orElse: () => <String, dynamic>{}
      );
      
      if (existingItem.isNotEmpty) {
        existingItem['qty'] += finalQty; 
      } else {
        posCart.add({'product': product, 'qty': finalQty, 'customPrice': finalPrice}); 
      }
      searchCtrl.clear();
      searchQuery = '';
      _focusedSearchResultIndex = -1;
      searchResults.clear();
    });
    searchFocusNode.requestFocus(); 
  }

  void _removeFromCart(int index) {
    setState(() {
      posCart.removeAt(index);
    });
    searchFocusNode.requestFocus();
  }

  // ============================================================================
  // Payment and Customer Selection Flow
  // ============================================================================
  void _showPaymentPopup(double totalBill) {
    final cashController = TextEditingController(text: totalBill.toStringAsFixed(0));
    final discountController = TextEditingController(text: '0');
    cashController.selection = TextSelection(baseOffset: 0, extentOffset: cashController.text.length);
    
    double changeAmount = 0.0;
    double finalPayable = totalBill;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            void calculateTotals() {
              double discount = double.tryParse(discountController.text) ?? 0.0;
              finalPayable = totalBill - discount;
              if (finalPayable < 0) finalPayable = 0;

              double cashGiven = double.tryParse(cashController.text) ?? 0.0;
              changeAmount = cashGiven - finalPayable;
              if (changeAmount < 0) changeAmount = 0.0;
            }

            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Payment (F9)', style: TextStyle(color: darkGreenText, fontWeight: FontWeight.bold)),
                  IconButton(icon: const Icon(Icons.close), onPressed: () {
                    Navigator.pop(context);
                    searchFocusNode.requestFocus();
                  }),
                ],
              ),
              content: SizedBox(
                width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: parrotGreen.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Payable:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text('Rs ${finalPayable.toStringAsFixed(0)}', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: darkGreenText)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: discountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Discount (Rs)', border: OutlineInputBorder()),
                      onChanged: (val) => setDialogState(() => calculateTotals()),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: cashController,
                      keyboardType: TextInputType.number,
                      autofocus: true,
                      decoration: const InputDecoration(labelText: 'Cash Tendered', border: OutlineInputBorder(), prefixIcon: const Icon(Icons.money)),
                      onChanged: (val) => setDialogState(() => calculateTotals()),
                      onSubmitted: (_) {
                        // Enter دبانے پر پیمنٹ کمپلیٹ
                        _completePaymentAction(totalBill, discountController.text, cashController.text);
                      },
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Change:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
                          Text('Rs ${changeAmount.toStringAsFixed(0)}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () {
                  Navigator.pop(context);
                  searchFocusNode.requestFocus();
                }, child: const Text('Cancel')),
                FilledButton.icon(
                  style: FilledButton.styleFrom(backgroundColor: parrotGreen, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
                  onPressed: () => _completePaymentAction(totalBill, discountController.text, cashController.text),
                  icon: const Icon(Icons.check),
                  label: const Text('Complete Payment', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // ★ پیمنٹ کا ایکشن (یہاں بل کی ویلیوز عارضی طور پر یاد رکھی جائیں گی) ★
  void _completePaymentAction(double total, String discountStr, String cashStr) {
    _tempTotalAmount = total;
    _tempDiscount = double.tryParse(discountStr) ?? 0.0;
    _tempCashTendered = double.tryParse(cashStr) ?? 0.0;

    for (var item in posCart) {
      PosProduct p = item['product'];
      double qty = item['qty'];
      int idx = posProducts.indexWhere((element) => element.id == p.id);
      if (idx != -1) posProducts[idx].stockQuantity -= qty;
    }
    
    Navigator.pop(context); 
    _showCustomerSelectionPopup();
  }

  void _showCustomerSelectionPopup() {
    String custSearch = '';
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            var filteredCustomers = savedCustomers.where((c) => 
              c.name.toLowerCase().contains(custSearch.toLowerCase()) || 
              c.mobile.contains(custSearch)
            ).toList();

            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              title: const Text('Select Customer for Bill', style: TextStyle(fontWeight: FontWeight.bold)),
              content: SizedBox(
                width: 400, height: 400,
                child: Column(
                  children: [
                    TextField(
                      autofocus: true,
                      decoration: const InputDecoration(
                        labelText: 'Search Customer (Name or Phone)',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (val) => setDialogState(() => custSearch = val),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: filteredCustomers.isEmpty 
                        ? const Center(child: Text('No matching customer found.'))
                        : ListView.builder(
                            itemCount: filteredCustomers.length,
                            itemBuilder: (context, index) {
                              final c = filteredCustomers[index];
                              return Card(
                                child: ListTile(
                                  leading: CircleAvatar(backgroundColor: parrotGreen, child: const Icon(Icons.person, color: Colors.white)),
                                  title: Text(c.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  subtitle: Text(c.mobile),
                                  onTap: () {
                                    Navigator.pop(context);
                                    _showMeasurementPrompt(c.name, phone: c.mobile); 
                                  },
                                ),
                              );
                            },
                          ),
                    ),
                  ],
                ),
              ),
              actions: [
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    _showMeasurementPrompt("Walk-in Customer");
                  },
                  icon: const Icon(Icons.skip_next),
                  label: const Text('Skip / Walk-in'),
                ),
                FilledButton.icon(
                  style: FilledButton.styleFrom(backgroundColor: darkGreenText),
                  onPressed: () {
                    Navigator.pop(context);
                    _showAddNewCustomerDialog();
                  },
                  icon: const Icon(Icons.person_add),
                  label: const Text('Add New Customer'),
                ),
              ],
            );
          }
        );
      },
    );
  }
  
  void _showAddNewCustomerDialog() {
    TextEditingController nameCtrl = TextEditingController();
    TextEditingController phoneCtrl = TextEditingController();
    TextEditingController addressCtrl = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Customer'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: phoneCtrl,
                decoration: const InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: addressCtrl,
                decoration: const InputDecoration(labelText: 'Address'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                searchFocusNode.requestFocus();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: parrotGreen, foregroundColor: Colors.white),
              onPressed: () {
                if(nameCtrl.text.isNotEmpty) {
                  CustomerRecord newCust = CustomerRecord(
                    tokenNumber: generateTokenNumber(),
                    name: nameCtrl.text,
                    mobile: phoneCtrl.text,
                    address: addressCtrl.text,
                    bookingDate: DateTime.now(),
                    garmentType: 'POS Item',
                    quantity: 0,
                    totalAmount: 0,
                    advance: 0,
                    remaining: 0,
                    status: 'Completed',
                    requirementGroups: [],
                  );
                  savedCustomers.add(newCust);
                  saveAppData();
                  
                  Navigator.pop(context);
                  _showMeasurementPrompt(newCust.name, phone: newCust.mobile);
                }
              },
              child: const Text('Save Customer'),
            )
          ],
        );
      }
    );
  }

  void _showMeasurementPrompt(String customerName, {String phone = ""}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tailoring Measurements', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text('Customer: $customerName\n\nکیا آپ اس کسٹمر کی سلائی کے لیے پیمائش (Measurements) لینا چاہتے ہیں؟'),
          actions: [
            TextButton(
              onPressed: () {
                _finalizeAndSaveInvoice(customerName, phone); // ★ بل سیو ہو گیا ★
                Navigator.pop(context);
                searchFocusNode.requestFocus();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bill saved successfully!'), backgroundColor: Colors.green));
              }, 
              child: const Text('No, Save Bill Only', style: TextStyle(color: Colors.grey))
            ),
            FilledButton.icon(
              style: FilledButton.styleFrom(backgroundColor: parrotGreen),
              onPressed: () {
                _finalizeAndSaveInvoice(customerName, phone); // ★ بل سیو ہو گیا ★
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const NewOrderScreen()));
              }, 
              icon: const Icon(Icons.straighten),
              label: const Text('Yes, Take Measurements'),
            ),
          ],
        );
      }
    );
  }

  // ============================================================================
  // ★ یہ فنکشن بل کو models.dart والی ہسٹری میں سیو کرے گا ★
  // ============================================================================
  void _finalizeAndSaveInvoice(String custName, String custPhone) {
    List < InvoiceItem > items = posCart.map((item) {
      PosProduct p = item['product'];
      return InvoiceItem(
        productId: p.id,
        productName: p.name,
        quantity: item['qty'],
        sellingPrice: item['customPrice'],
        costPrice: p.costPrice,
      );
    }).toList();

    InvoiceRecord newInvoice = InvoiceRecord(
      invoiceId: 'INV-${DateTime.now().millisecondsSinceEpoch}',
      date: DateTime.now(),
      items: items,
      totalAmount: _tempTotalAmount,
      discount: _tempDiscount,
      cashTendered: _tempCashTendered,
      paymentType: 'Cash',
      customerName: custName,
      customerPhone: custPhone.isNotEmpty ? custPhone : '', // Fixed: Can't be null
    );

    invoiceHistory.add(newInvoice);
    saveAppData(); // Data ko persist karne ke liye

    // بل سیو ہونے کے بعد کارٹ بالکل خالی کر دیا جائے گا
    setState(() {
      posCart.clear();
    });
  }

  void _updateQty(int index, double newQty) {
    setState(() {
      if (newQty <= 0) posCart.removeAt(index);
      else posCart[index]['qty'] = newQty;
    });
    searchFocusNode.requestFocus();
  }

  Widget _buildCurrentScreen() {
    switch (_selectedIndex) {
      case 0:
        return _buildPosScreen(); 
      case 1:
        return const Dashboard(); 
      case 2:
        return const ProductsContent(); 
      case 3:
        return const Center(
          child: Text(
            'Document Screen - Coming Soon...', 
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey)
          )
        ); 
      default:
        return _buildPosScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => searchFocusNode.requestFocus(),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: parrotGreen,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white), 
          title: Row(
            children: [
              CircleAvatar(
                radius: 22, 
                backgroundColor: creamColor,
                backgroundImage: logoImagePath != null ? FileImage(File(logoImagePath!)) : null,
                child: logoImagePath == null ? Text('MH', style: TextStyle(color: parrotGreen, fontWeight: FontWeight.bold, fontSize: 20)) : null, 
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(shopName, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(shopSubtitle, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.white, size: 26),
              tooltip: 'POS Admin Menu',
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
            ),
            const SizedBox(width: 8),
          ],
        ),
        
        drawer: Drawer(
          backgroundColor: bgColor, 
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(color: parrotGreen),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: creamColor,
                  backgroundImage: logoImagePath != null ? FileImage(File(logoImagePath!)) : null,
                  child: logoImagePath == null ? const Icon(Icons.storefront, size: 40, color: Color(0xFF7CB342)) : null,
                ),
                accountName: Text(shopName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                accountEmail: Text(shopSubtitle, style: const TextStyle(color: Colors.white70)),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(top: 8, bottom: 20),
                  children: [
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: Text('MAIN MENU', style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2))),
                    
                    _buildDrawerNavButton('Point of Sale', Icons.point_of_sale_rounded, 0),
                    _buildDrawerNavButton('Dashboard', Icons.dashboard_customize_rounded, 1),
                    _buildDrawerNavButton('Products', Icons.inventory_2_rounded, 2),
                    _buildDrawerNavButton('Documents', Icons.description_rounded, 3),

                    const Divider(thickness: 1, height: 24),
                    
                    _buildModernDrawerItem('Switch Workspace', Icons.swap_horizontal_circle_rounded, const CloudSyncScreen(), color: Colors.purple, isSpecial: true),
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: Text('SHOP MANAGEMENT', style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2))),
                    _buildModernDrawerItem('Shop Profile', Icons.store_mall_directory_rounded, const ShopProfileScreen()),
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: Text('ACCOUNTS & STAFF', style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2))),
                    _buildModernDrawerItem('Payments', Icons.payment_rounded, const PaymentsScreen()),
                    _buildModernDrawerItem('Staff & Users', Icons.people_alt_rounded, const UsersScreen()),
                    _buildModernDrawerItem('Staff Ledger', Icons.menu_book_rounded, const StaffLedgerScreen(), color: Colors.teal),
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: Text('SYSTEM', style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2))),
                    _buildModernDrawerItem('Cloud Sync', Icons.cloud_sync_rounded, const CloudSyncScreen(), color: Colors.blue),
                    _buildModernDrawerItem('Settings', Icons.settings_rounded, const SettingsScreen(), color: Colors.grey.shade700),
                    _buildModernDrawerItem('Help & Guide', Icons.help_outline_rounded, const HelpGuideScreen()),
                    _buildModernDrawerItem('Contact Us', Icons.headset_mic_rounded, const ContactUsScreen()),
                  ],
                ),
              ),
            ],
          ),
        ),

        endDrawer: const Drawer(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Align(
            alignment: Alignment.centerRight,
            child: PosThreeDotsDrawerContent(),
          ),
        ),
        
        body: _buildCurrentScreen(),
      ),
    );
  }

  // =========================================================================
  // POS Screen Layout
  // =========================================================================
  Widget _buildPosScreen() {
    double totalCartValue = _calculateTotal();

    return Row(
      children: [
        // Left Side: Cart & Search
        Expanded(
          flex: 45,
          child: Container(
            decoration: BoxDecoration(color: Colors.white, border: Border(right: BorderSide(color: Colors.grey.shade300, width: 2))),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  color: parrotGreen.withOpacity(0.1),
                  child: TextField(
                    controller: searchCtrl,
                    focusNode: searchFocusNode, 
                    autofocus: true, 
                    decoration: InputDecoration(
                      hintText: 'Scan Barcode or Search by name...',
                      prefixIcon: Icon(Icons.qr_code_scanner, color: parrotGreen),
                      suffixIcon: searchQuery.isNotEmpty 
                          ? IconButton(
                              icon: const Icon(Icons.clear), 
                              onPressed: () {
                                searchCtrl.clear();
                                setState(() {
                                  searchQuery = '';
                                  _focusedSearchResultIndex = -1;
                                  searchResults.clear();
                                });
                                searchFocusNode.requestFocus();
                              }
                            ) 
                          : null,
                      filled: true, fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    ),
                    onChanged: (val) {
                      setState(() {
                        searchQuery = val;
                        if (val.trim().isEmpty) {
                          searchResults.clear();
                          _focusedSearchResultIndex = -1;
                        } else {
                          searchResults = posProducts.where((p) =>
                              p.name.toLowerCase().contains(val.toLowerCase()) || 
                              p.groupName.toLowerCase().contains(val.toLowerCase()) ||
                              p.id.toLowerCase().contains(val.toLowerCase())).toList();
                          _focusedSearchResultIndex = searchResults.isNotEmpty ? 0 : -1;
                        }
                      });
                    },
                    onSubmitted: (val) {
                      if (val.trim().isNotEmpty) {
                        if (_focusedSearchResultIndex >= 0 && _focusedSearchResultIndex < searchResults.length) {
                          _onProductSelected(searchResults[_focusedSearchResultIndex]);
                        } else {
                          try {
                            PosProduct exactMatch = posProducts.firstWhere(
                              (p) => p.id.toLowerCase() == val.trim().toLowerCase()
                            );
                            _onProductSelected(exactMatch); 
                          } catch (e) {
                            // nothing found
                          }
                        }
                      }
                      searchFocusNode.requestFocus();
                    },
                  ),
                ),
                Expanded(
                  child: searchQuery.isNotEmpty
                      ? ListView.builder(
                          itemCount: searchResults.length,
                          itemBuilder: (context, index) {
                            final p = searchResults[index];
                            bool isFocused = index == _focusedSearchResultIndex;
                            return Container(
                              color: isFocused ? parrotGreen.withOpacity(0.3) : Colors.transparent, 
                              child: ListTile(
                                title: Text(p.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                                subtitle: Text('Code: ${p.id} | Rs ${p.sellingPrice} | Stock: ${p.stockQuantity}'),
                                onTap: () {
                                  _onProductSelected(p); 
                                },
                              ),
                            );
                          },
                        )
                      : Column(
                          children: [
                            Expanded(
                              child: posCart.isEmpty
                                  ? Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.shopping_cart_outlined, size: 60, color: Colors.grey.shade300),
                                          const SizedBox(height: 10),
                                          const Text('Scan product or click from right panel', style: TextStyle(color: Colors.grey)),
                                        ],
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: posCart.length,
                                      itemBuilder: (context, index) {
                                        final item = posCart[index];
                                        final PosProduct p = item['product'];
                                        return Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(p.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                                                    Text('Rs ${item['customPrice']}', style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                                                  ],
                                                ),
                                              ),
                                              Text('${item['qty']} x  ', style: const TextStyle(fontWeight: FontWeight.bold)),
                                              Text('Rs ${(item['customPrice'] * item['qty']).toStringAsFixed(0)}', style: TextStyle(fontWeight: FontWeight.bold, color: darkGreenText)),
                                              const SizedBox(width: 10),
                                              InkWell(
                                                onTap: () => _removeFromCart(index),
                                                child: Container(
                                                  padding: const EdgeInsets.all(4),
                                                  decoration: BoxDecoration(color: Colors.red.shade100, borderRadius: BorderRadius.circular(4)),
                                                  child: const Icon(Icons.close, color: Colors.red, size: 16),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                            ),
                          ],
                        ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.grey.shade50, border: Border(top: BorderSide(color: Colors.grey.shade300))),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Bill:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54)),
                          Text('Rs ${totalCartValue.toStringAsFixed(0)}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: darkGreenText)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: FilledButton(
                          style: FilledButton.styleFrom(backgroundColor: parrotGreen, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                          onPressed: posCart.isEmpty ? null : () {
                            _showPaymentPopup(totalCartValue);
                          },
                          child: const Text('PAY (F9)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Right Side: Quick Controls & Grid
        Expanded(
          flex: 55,
          child: Container(
            decoration: BoxDecoration(
              color: bgColor,
              border: Border(bottom: BorderSide(color: Colors.grey.shade300, width: 2.0)),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6.0, top: 4.0),
                        child: Text('POS Quick Controls', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey.shade600)),
                      ),
                      Row(
                        children: [
                          Expanded(child: _buildPosControlButton('New Sale', Icons.note_add, Colors.blue, () { 
                            setState(() => posCart.clear());
                            searchFocusNode.requestFocus();
                          })),
                          const SizedBox(width: 4),
                          Expanded(child: _buildPosControlButton('Cash / Card', Icons.payment, Colors.green, () {
                            if (posCart.isNotEmpty) _showPaymentPopup(totalCartValue);
                          })),
                          const SizedBox(width: 4),
                          Expanded(child: _buildPosControlButton('Discount', Icons.local_offer, Colors.orange, () {})),
                          const SizedBox(width: 4),
                          Expanded(child: _buildPosControlButton('Customer', Icons.person, Colors.purple, () {})),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Expanded(child: _buildPosControlButton('PAY (F9)', Icons.check_circle, parrotGreen, () {
                            if (posCart.isNotEmpty) _showPaymentPopup(totalCartValue);
                          })),
                          const SizedBox(width: 4),
                          Expanded(child: _buildPosControlButton('Refund', Icons.replay, Colors.red, () {})),
                          const SizedBox(width: 4),
                          Expanded(child: _buildPosControlButton('Saved Ord', Icons.bookmark, Colors.brown, () {})),
                          const SizedBox(width: 4),
                          Expanded(child: _buildPosControlButton('Lock', Icons.lock, Colors.blueGrey, () {})),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1, thickness: 1),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          child: Text('Tailoring Management System', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: darkGreenText)),
                        ),
                        const SizedBox(height: 4),
                        Expanded(
                          child: GridView.count(
                            physics: const NeverScrollableScrollPhysics(), 
                            crossAxisCount: 3, 
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 1.35, 
                            children: [
                              _buildGridCard('New Order', 'Create new', Icons.add_box_rounded, context, destinationScreen: const NewOrderScreen()),
                              _buildGridCard('Customer Search', 'Find client', Icons.person_search_rounded, context, destinationScreen: const OrdersScreen(title: 'Customer Search')),
                              _buildGridCard('Order List', 'All orders', Icons.receipt_long_rounded, context, destinationScreen: const OrdersScreen(title: 'Orders List')),
                              _buildGridCard('Production', 'Tailor board', Icons.cut_rounded, context, destinationScreen: const ProductionScreen()),
                              _buildGridCard('Dashboard', 'Overview', Icons.dashboard_customize_rounded, context, onTap: () {
                                setState(() { _selectedIndex = 1; });
                              }),
                              _buildGridCard('Reports', 'Analytics', Icons.bar_chart_rounded, context, destinationScreen: const ReportsScreen()),
                            ],
                          ),
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
    );
  }

  Widget _buildDrawerNavButton(String title, IconData icon, int index) {
    bool isSelected = _selectedIndex == index;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? parrotGreen.withOpacity(0.15) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isSelected ? parrotGreen : Colors.transparent, width: 1),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: Icon(icon, color: isSelected ? darkGreenText : Colors.grey.shade600, size: 22),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isSelected ? darkGreenText : Colors.black87)),
        onTap: () {
          setState(() {
            _selectedIndex = index; 
          });
          Navigator.pop(context); 
        },
      ),
    );
  }

  Widget _buildPosControlButton(String title, IconData icon, Color color, VoidCallback onTap) {
    return SizedBox(
      height: 36,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color.withOpacity(0.1),
          foregroundColor: color,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6), side: BorderSide(color: color.withOpacity(0.3))),
        ),
        onPressed: onTap,
        icon: Icon(icon, size: 15),
        label: Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildModernDrawerItem(String title, IconData icon, Widget destination, {Color color = const Color(0xFF7CB342), bool isSpecial = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(color: isSpecial ? color.withOpacity(0.1) : Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: isSpecial ? color : Colors.transparent, width: 1), boxShadow: isSpecial ? [] : [BoxShadow(color: Colors.grey.shade200, blurRadius: 4, offset: const Offset(0, 2))]),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: color.withOpacity(0.15), shape: BoxShape.circle), child: Icon(icon, color: color, size: 22)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)),
        trailing: Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey.shade400),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => destination)).then((_) {
            _loadShopData(); 
            setState(() {}); 
          });
        },
      ),
    );
  }

  Widget _buildGridCard(String title, String subtitle, IconData icon, BuildContext context, {Widget? destinationScreen, VoidCallback? onTap}) {
    return Card(
      elevation: 2,
      shadowColor: parrotGreen.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: BorderSide(color: parrotGreen, width: 1.0)),
      color: Colors.white,
      child: InkWell(
        onTap: () { 
          if (onTap != null) {
            onTap(); 
          } else if (destinationScreen != null) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => destinationScreen)); 
          }
        },
        borderRadius: BorderRadius.circular(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: parrotGreen, shape: BoxShape.circle), child: Icon(icon, size: 20, color: creamColor)),
            const SizedBox(height: 4),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: darkGreenText)),
            const SizedBox(height: 1),
            Text(subtitle, style: TextStyle(fontSize: 9, color: darkGreenText.withOpacity(0.8), fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}