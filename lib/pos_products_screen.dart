import 'package:flutter/material.dart';
import 'models.dart';

// ==========================================
// 1. PRODUCTS MAIN LIST SCREEN
// ==========================================
class PosProductsScreen extends StatefulWidget {
  const PosProductsScreen({super.key});

  @override
  State<PosProductsScreen> createState() => _PosProductsScreenState();
}

class _PosProductsScreenState extends State<PosProductsScreen> {
  final Color parrotGreen = const Color(0xFF7CB342);
  final Color darkGreenText = const Color(0xFF2E7D32);
  final Color bgColor = const Color(0xFFF5F6F8);

  @override
  void initState() {
    super.initState();
    // اگر کوئی گروپ نہیں ہے تو ڈیفالٹ گروپس بنا دیں
    if (posGroups.isEmpty) {
      posGroups.addAll([
        PosGroup(id: '1', name: 'Wash & Wear'),
        PosGroup(id: '2', name: 'Cotton'),
        PosGroup(id: '3', name: 'Latha'),
        PosGroup(id: '4', name: 'Khaddar'),
      ]);
      saveAppData();
    }
  }

  void _showAddGroupDialog() {
    final nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Group', style: TextStyle(color: darkGreenText, fontWeight: FontWeight.bold)),
        content: TextField(
          controller: nameController,
          decoration: InputDecoration(labelText: 'Group Name (e.g., Silk)', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: parrotGreen),
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                setState(() {
                  posGroups.add(PosGroup(id: DateTime.now().millisecondsSinceEpoch.toString(), name: nameController.text.trim()));
                  saveAppData();
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('Products Management', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: parrotGreen,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: posProducts.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inventory_2_outlined, size: 80, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  const Text('کوئی پروڈکٹ موجود نہیں ہے۔', style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.bold)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: posProducts.length,
              itemBuilder: (context, index) {
                final product = posProducts[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade300)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: CircleAvatar(
                      backgroundColor: product.isActive ? parrotGreen.withOpacity(0.2) : Colors.red.withOpacity(0.2),
                      child: Icon(Icons.checkroom, color: product.isActive ? parrotGreen : Colors.red),
                    ),
                    title: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    subtitle: Text('${product.groupName} | Selling: Rs ${product.sellingPrice} / ${product.uom}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditProductScreen(product: product))).then((_) => setState(() {}));
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              posProducts.removeAt(index);
                              saveAppData();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            heroTag: 'btn1',
            onPressed: _showAddGroupDialog,
            backgroundColor: Colors.blue.shade600,
            foregroundColor: Colors.white,
            icon: const Icon(Icons.category),
            label: const Text('Add Group'),
          ),
          const SizedBox(height: 12),
          FloatingActionButton.extended(
            heroTag: 'btn2',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AddEditProductScreen())).then((_) => setState(() {}));
            },
            backgroundColor: parrotGreen,
            foregroundColor: Colors.white,
            icon: const Icon(Icons.add),
            label: const Text('Add Product', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 2. ADD / EDIT PRODUCT SCREEN (4 TABS)
// ==========================================
class AddEditProductScreen extends StatefulWidget {
  final PosProduct? product;
  const AddEditProductScreen({super.key, this.product});

  @override
  State<AddEditProductScreen> createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> with SingleTickerProviderStateMixin {
  final Color parrotGreen = const Color(0xFF7CB342);
  final Color darkGreenText = const Color(0xFF2E7D32);

  late TabController _tabController;

  // Tab 1: Details Controllers
  final _nameController = TextEditingController();
  final _uomController = TextEditingController();
  String? _selectedGroup;
  String? _selectedSubgroup;
  bool _isActive = true;
  final _defaultQtyController = TextEditingController();
  final _descController = TextEditingController();

  // Tab 2: Price Controllers
  final _costController = TextEditingController();
  final _sellingController = TextEditingController();
  final _markupController = TextEditingController();
  bool _priceChangeAllowed = true;

  // Tab 3: Stock Control Controllers
  final _reorderController = TextEditingController();
  final _preferredQtyController = TextEditingController();
  bool _lowStockWarning = true;

  // Tab 4: Image/Color Controllers
  String? _selectedColor;
  final List<String> _colorsList = ['White', 'Yellow', 'Red', 'Tomato', 'Teal', 'Transparent', 'Yellow Green', 'Parrot Green', 'D.C. Settle', 'Black', 'Blue'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    if (widget.product != null) {
      final p = widget.product!;
      _nameController.text = p.name;
      _uomController.text = p.uom;
      _selectedGroup = posGroups.any((g) => g.name == p.groupName) ? p.groupName : null;
      _isActive = p.isActive;
      _defaultQtyController.text = p.defaultQty.toString();
      _descController.text = p.description;

      _costController.text = p.costPrice.toString();
      _sellingController.text = p.sellingPrice.toString();
      _markupController.text = p.markup.toString();
      _priceChangeAllowed = p.priceChangeAllowed;

      _reorderController.text = p.reorderPoint.toString();
      _preferredQtyController.text = p.preferredQty.toString();
      _lowStockWarning = p.lowStockWarning;

      _selectedColor = p.color.isNotEmpty ? p.color : null;
    } else {
      _uomController.text = 'Meter';
      _defaultQtyController.text = '1.0';
    }
  }

  // ★ AUTO CALCULATION LOGIC ★
  void _calculateMarkup() {
    double cost = double.tryParse(_costController.text) ?? 0.0;
    double selling = double.tryParse(_sellingController.text) ?? 0.0;
    if (cost > 0 && selling > cost) {
      double markup = ((selling - cost) / cost) * 100;
      _markupController.text = markup.toStringAsFixed(2);
    }
  }

  void _calculateSelling() {
    double cost = double.tryParse(_costController.text) ?? 0.0;
    double markup = double.tryParse(_markupController.text) ?? 0.0;
    if (cost > 0 && markup > 0) {
      double selling = cost + (cost * (markup / 100));
      _sellingController.text = selling.toStringAsFixed(2);
    }
  }

  void _saveProduct() {
    if (_nameController.text.isEmpty || _selectedGroup == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Name and Group are required!'), backgroundColor: Colors.red));
      return;
    }

    final newProduct = PosProduct(
      id: widget.product?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text.trim(),
      uom: _uomController.text.trim(),
      groupName: _selectedGroup!,
      subgroupName: _selectedSubgroup ?? '',
      isActive: _isActive,
      defaultQty: double.tryParse(_defaultQtyController.text) ?? 1.0,
      description: _descController.text.trim(),
      costPrice: double.tryParse(_costController.text) ?? 0.0,
      sellingPrice: double.tryParse(_sellingController.text) ?? 0.0,
      markup: double.tryParse(_markupController.text) ?? 0.0,
      priceChangeAllowed: _priceChangeAllowed,
      reorderPoint: double.tryParse(_reorderController.text) ?? 0.0,
      preferredQty: double.tryParse(_preferredQtyController.text) ?? 0.0,
      lowStockWarning: _lowStockWarning,
      color: _selectedColor ?? '',
      imagePath: widget.product?.imagePath ?? '',
      stockQuantity: widget.product?.stockQuantity ?? 0.0,
    );

    if (widget.product == null) {
      posProducts.add(newProduct);
    } else {
      int index = posProducts.indexWhere((p) => p.id == widget.product!.id);
      if (index != -1) posProducts[index] = newProduct;
    }
    
    saveAppData();
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Product Saved Successfully!'), backgroundColor: Colors.green));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product == null ? 'New Product' : 'Edit Product', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: parrotGreen,
        iconTheme: const IconThemeData(color: Colors.white),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          tabs: const [
            Tab(text: '1. Details', icon: Icon(Icons.info_outline)),
            Tab(text: '2. Price', icon: Icon(Icons.attach_money)),
            Tab(text: '3. Stock Control', icon: Icon(Icons.inventory_2_outlined)),
            Tab(text: '4. Image / Color', icon: Icon(Icons.color_lens_outlined)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDetailsTab(),
          _buildPriceTab(),
          _buildStockControlTab(),
          _buildImageColorTab(),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 10, offset: const Offset(0, -3))]),
        child: FilledButton.icon(
          style: FilledButton.styleFrom(backgroundColor: parrotGreen, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
          onPressed: _saveProduct,
          icon: const Icon(Icons.save),
          label: const Text('SAVE PRODUCT RECORD', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
      ),
    );
  }

  // ======================
  // TAB 1: DETAILS
  // ======================
  Widget _buildDetailsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SwitchListTile(
          title: Text(_isActive ? 'Active (Available for Sale)' : 'Inactive (Hidden from Sale)', style: TextStyle(fontWeight: FontWeight.bold, color: _isActive ? darkGreenText : Colors.red)),
          value: _isActive,
          activeColor: parrotGreen,
          onChanged: (val) => setState(() => _isActive = val),
        ),
        const SizedBox(height: 12),
        TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Product Name *', border: OutlineInputBorder(), prefixIcon: Icon(Icons.checkroom))),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: TextField(controller: _uomController, decoration: const InputDecoration(labelText: 'Unit of Measurement (e.g. Meter)', border: OutlineInputBorder()))),
            const SizedBox(width: 16),
            Expanded(child: TextField(controller: _defaultQtyController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Default Qty (e.g. 4)', border: OutlineInputBorder()))),
          ],
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(labelText: 'Product Group *', border: OutlineInputBorder(), prefixIcon: Icon(Icons.category)),
          value: _selectedGroup,
          items: posGroups.map((g) => DropdownMenuItem(value: g.name, child: Text(g.name))).toList(),
          onChanged: (val) => setState(() => _selectedGroup = val),
        ),
        const SizedBox(height: 16),
        TextField(controller: _descController, maxLines: 3, decoration: const InputDecoration(labelText: 'Description / Notes', border: OutlineInputBorder(), alignLabelWithHint: true)),
      ],
    );
  }

  // ======================
  // TAB 2: PRICE
  // ======================
  Widget _buildPriceTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Enter Cost & Selling price to auto-calculate Markup, or Cost & Markup to auto-calculate Selling price.', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 16),
        TextField(
          controller: _costController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Cost Price (Purchase)', border: OutlineInputBorder(), prefixIcon: Icon(Icons.money)),
          onChanged: (_) => _calculateSelling(), // Try calculating selling if markup exists
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _markupController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Markup %', border: OutlineInputBorder(), suffixText: '%'),
                onChanged: (_) => _calculateSelling(), // User types Markup -> Auto calc Selling
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: _sellingController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Selling Price', border: const OutlineInputBorder(), filled: true, fillColor: parrotGreen.withOpacity(0.05)),
                onChanged: (_) => _calculateMarkup(), // User types Selling -> Auto calc Markup
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        SwitchListTile(
          title: const Text('Price Change Allowed at Sale Time?', style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: const Text('If OFF, cashier cannot change selling price.'),
          value: _priceChangeAllowed,
          activeColor: parrotGreen,
          onChanged: (val) => setState(() => _priceChangeAllowed = val),
        ),
      ],
    );
  }

  // ======================
  // TAB 3: STOCK CONTROL
  // ======================
  Widget _buildStockControlTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SwitchListTile(
          title: const Text('Low Stock Warning', style: TextStyle(fontWeight: FontWeight.bold)),
          value: _lowStockWarning,
          activeColor: parrotGreen,
          onChanged: (val) => setState(() => _lowStockWarning = val),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _reorderController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Reorder Point (Min Quantity)', border: OutlineInputBorder(), prefixIcon: Icon(Icons.warning_amber_rounded)),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _preferredQtyController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Preferred Quantity (Restock Target)', border: OutlineInputBorder(), prefixIcon: Icon(Icons.inventory_rounded)),
        ),
      ],
    );
  }

  // ======================
  // TAB 4: IMAGE / COLOR
  // ======================
  Widget _buildImageColorTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Color & Image are optional.', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(labelText: 'Select Color', border: OutlineInputBorder(), prefixIcon: Icon(Icons.color_lens)),
          value: _selectedColor,
          items: _colorsList.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
          onChanged: (val) => setState(() => _selectedColor = val),
        ),
        const SizedBox(height: 32),
        Center(
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade400, style: BorderStyle.solid)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_a_photo, size: 40, color: Colors.grey.shade500),
                const SizedBox(height: 8),
                Text('Add Image', style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}