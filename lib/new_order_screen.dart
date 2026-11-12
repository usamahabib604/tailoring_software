import 'package:flutter/material.dart';
import 'models.dart';

// ============================================================
// NEW ORDER SCREEN (Final 4-Column Uniform Itemized Preview Master)
// ============================================================

class NewOrderScreen extends StatefulWidget {
  final CustomerRecord? existingCustomer;
  final bool isEditMode;

  const NewOrderScreen({
    super.key,
    this.existingCustomer,
    this.isEditMode = false,
  });

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  final ScrollController pageScrollController = ScrollController();

  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final addressController = TextEditingController();

  final customerNameFocusNode = FocusNode();
  final customerMobileFocusNode = FocusNode();
  final customerAddressFocusNode = FocusNode();

  final priceController = TextEditingController(); 
  final advanceController = TextEditingController();
  final notesController = TextEditingController();

  final quantityFocusNode = FocusNode();
  final priceFocusNode = FocusNode();
  final advanceFocusNode = FocusNode();

  final Map<String, TextEditingController> controllers = {};
  final Map<String, FocusNode> focusNodes = {};

  final Map<int, TextEditingController> groupQtyControllers = {};
  final Map<int, TextEditingController> groupPriceControllers = {};

  DateTime bookingDate = DateTime.now();
  DateTime? requiredDate;

  String requirementMode = 'Same Requirements';

  late String tokenNumber;

  List<RequirementGroup> groups = [
    RequirementGroup(quantity: 1, price: 0.0),
  ];

  int activeGroupIndex = 0;

  final List<String> mainMeasurements = [
    'Qameez Length',
    'Sleeve Length',
    'Teera',
    'Neck',
    'Fitting',
    'Daman',
    'Arm Hole',
    'Sleeve',
  ];

  final List<String> lowerMeasurements = [
    'Shalwar Length',
    'Leg Opening',
    'Shalwar Rise Depth',
    'Shalwar Width',
  ];

  @override
  void initState() {
    super.initState();
    tokenNumber = generateTokenNumberFromOne();

    for (final name in [...mainMeasurements, ...lowerMeasurements]) {
      controllers[name] = TextEditingController();
      focusNodes[name] = FocusNode();
    }

    priceController.addListener(_refresh);
    advanceController.addListener(_refresh);

    if (widget.existingCustomer != null) {
      _loadCustomerData(widget.existingCustomer!);
    } else {
      _syncGroupControllers();
      _loadGroupIntoFields();
    }
  }

  void _syncGroupControllers() {
    groupQtyControllers.clear();
    groupPriceControllers.clear();
    for (int i = 0; i < groups.length; i++) {
      groupQtyControllers[i] = TextEditingController(text: groups[i].quantity > 1 ? groups[i].quantity.toString() : '1');
      groupPriceControllers[i] = TextEditingController(text: groups[i].price > 0 ? groups[i].price.toStringAsFixed(0) : '');
      
      groupQtyControllers[i]!.addListener(_refresh);
      groupPriceControllers[i]!.addListener(_refresh);
    }
  }

  String generateTokenNumberFromOne() {
    if (widget.isEditMode && widget.existingCustomer != null) {
      return widget.existingCustomer!.tokenNumber;
    }
    int maxNum = 0;
    for (var c in savedCustomers) {
      int n = int.tryParse(c.tokenNumber.split('-')[0]) ?? 0;
      if (n > maxNum) maxNum = n;
    }
    return (maxNum + 1).toString().padLeft(3, '0');
  }

  void _loadCustomerData(CustomerRecord customer) {
    nameController.text = customer.name;
    mobileController.text = customer.mobile;
    addressController.text = customer.address;

    if (customer.requirementGroups.isNotEmpty) {
      groups = customer.requirementGroups.map((g) => g.copy()).toList();
    } else {
      groups = [RequirementGroup(quantity: customer.quantity, garmentType: customer.garmentType, price: customer.quantity > 0 ? customer.totalAmount / customer.quantity : 0.0)];
    }

    if (groups.length > 1) {
      requirementMode = 'Multiple Requirements';
    } else {
      requirementMode = 'Same Requirements';
      if (groups.first.price > 0) {
        priceController.text = groups.first.price.toStringAsFixed(0);
      }
    }

    _syncGroupControllers();

    if (widget.isEditMode) {
      tokenNumber = customer.tokenNumber;
      bookingDate = customer.bookingDate;
      requiredDate = customer.requiredDate;
      advanceController.text = customer.advance > 0 ? customer.advance.toStringAsFixed(0) : '';
    } else {
      tokenNumber = customer.tokenNumber;
    }

    activeGroupIndex = 0;
    _loadGroupIntoFields();
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  RequirementGroup get activeGroup => groups[activeGroupIndex];

  int get totalSuitQuantity {
    if (requirementMode == 'Same Requirements') {
      return int.tryParse(groupQtyControllers[0]?.text ?? '1') ?? 1;
    }
    int total = 0;
    for (int i = 0; i < groups.length; i++) {
      int q = int.tryParse(groupQtyControllers[i]?.text ?? '1') ?? 1;
      groups[i].quantity = q;
      total += q;
    }
    return total;
  }

  double get total {
    if (requirementMode == 'Same Requirements') {
      final price = double.tryParse(priceController.text) ?? 0;
      int q = int.tryParse(groupQtyControllers[0]?.text ?? '1') ?? 1;
      return q * price;
    } else {
      double sum = 0;
      for (int i = 0; i < groups.length; i++) {
        int q = int.tryParse(groupQtyControllers[i]?.text ?? '1') ?? 1;
        double p = double.tryParse(groupPriceControllers[i]?.text ?? '0') ?? 0;
        groups[i].quantity = q;
        groups[i].price = p;
        sum += (q * p);
      }
      return sum;
    }
  }

  double get advance {
    return double.tryParse(advanceController.text) ?? 0;
  }

  double get remaining {
    final value = total - advance;
    return value < 0 ? 0 : value;
  }

  @override
  void dispose() {
    pageScrollController.dispose();
    nameController.dispose();
    mobileController.dispose();
    addressController.dispose();
    customerNameFocusNode.dispose();
    customerMobileFocusNode.dispose();
    customerAddressFocusNode.dispose();
    priceController.dispose();
    advanceController.dispose();
    notesController.dispose();
    quantityFocusNode.dispose();
    priceFocusNode.dispose();
    advanceFocusNode.dispose();

    for (var c in groupQtyControllers.values) c.dispose();
    for (var c in groupPriceControllers.values) c.dispose();
    for (final controller in controllers.values) controller.dispose();
    for (final node in focusNodes.values) node.dispose();
    super.dispose();
  }

  void _loadGroupIntoFields() {
    final group = activeGroup;
    final Map<String, String> safeMeasurements = group.measurements;
    for (final label in [...mainMeasurements, ...lowerMeasurements]) {
      controllers[label]!.text = safeMeasurements[label] ?? '';
    }
  }

  void _saveCurrentGroup() {
    final group = activeGroup;
    final Map<String, String> safeMeasurements = group.measurements;
    for (final label in [...mainMeasurements, ...lowerMeasurements]) {
      final value = controllers[label]!.text.trim();
      if (value.isEmpty) {
        safeMeasurements.remove(label);
      } else {
        safeMeasurements[label] = value;
      }
    }
    if (requirementMode == 'Same Requirements') {
      double p = double.tryParse(priceController.text) ?? 0;
      int q = int.tryParse(groupQtyControllers[0]?.text ?? '1') ?? 1;
      for (var g in groups) {
        g.price = p;
        g.quantity = q;
      }
    }
  }

  void addRequirementGroup() {
    _saveCurrentGroup();
    final newGroup = RequirementGroup(
      quantity: 1,
      price: 0.0,
      garmentType: activeGroup.garmentType ?? '',
      measurements: Map < String , String > .from(activeGroup.measurements),
      neckOption: activeGroup.neckOption,
      bandStyle: activeGroup.bandStyle,
      collarStyle: activeGroup.collarStyle,
      sleeveOption: activeGroup.sleeveOption,
      cuffCornerStyle: activeGroup.cuffCornerStyle,
      shalwarType: activeGroup.shalwarType,
      shalwarStyle: activeGroup.shalwarStyle,
      waistOption: activeGroup.waistOption,
      buttonPlacketSide: activeGroup.buttonPlacketSide,
      buttonStyle: activeGroup.buttonStyle,
      touchButtonStyle: activeGroup.touchButtonStyle,
      frontPocket: activeGroup.frontPocket,
      sidePocket: activeGroup.sidePocket,
      shalwarPocket: activeGroup.shalwarPocket,
      stitchingOption: activeGroup.stitchingOption,
      interfacingWidth: activeGroup.interfacingWidth,
    );

    setState(() {
      groups.add(newGroup);
      activeGroupIndex = groups.length - 1;
      _syncGroupControllers();
    });
    _loadGroupIntoFields();
  }

  void deleteRequirementGroup(int index) {
    if (groups.length <= 1) return;
    setState(() {
      groups.removeAt(index);
      if (activeGroupIndex >= groups.length) {
        activeGroupIndex = groups.length - 1;
      }
      _syncGroupControllers();
    });
    _loadGroupIntoFields();
  }

  void selectGroup(int index) {
    _saveCurrentGroup();
    setState(() => activeGroupIndex = index);
    _loadGroupIntoFields();
  }

  Future<void> selectRequiredDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: requiredDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );
    if (picked != null) {
      setState(() => requiredDate = picked);
      FocusScope.of(context).requestFocus(customerNameFocusNode);
    }
  }

  void moveToNextNode(String currentLabel) {
    final List<String> flow = [
      'Qameez Length', 'Sleeve Length', 'Teera', 'Neck',
      'Fitting', 'Daman', 'Arm Hole', 'Sleeve',
      'Shalwar Length', 'Leg Opening', 'Shalwar Rise Depth', 'Shalwar Width'
    ];
    int index = flow.indexOf(currentLabel);
    if (index >= 0 && index < flow.length - 1) {
      FocusScope.of(context).requestFocus(focusNodes[flow[index + 1]]);
    } else {
      FocusScope.of(context).unfocus();
    }
  }

  String _getNeckDisplayString(RequirementGroup g) {
    List<String> p = [];
    if (g.neckOption.isNotEmpty) p.add(g.neckOption);
    if (g.bandStyle.isNotEmpty) p.add(g.bandStyle);
    if (g.collarStyle.isNotEmpty) p.add(g.collarStyle);
    return p.join(', ');
  }
  String _getSleeveDisplayString(RequirementGroup g) {
    List<String> p = [];
    if (g.sleeveOption.isNotEmpty) p.add(g.sleeveOption);
    if (g.cuffCornerStyle.isNotEmpty) p.add(g.cuffCornerStyle);
    return p.join(', ');
  }
  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  Future<void> _editMeasurementDialog(String title, RequirementGroup g, Function refreshDialog) async {
    TextEditingController tempController = TextEditingController(text: g.measurements[title] ?? '');
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Edit $title', style: const TextStyle(fontWeight: FontWeight.bold)),
        content: TextField(
          controller: tempController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          autofocus: true,
          decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true),
        ),
        actions: [
          FilledButton(onPressed: () => Navigator.pop(ctx), child: const Text('Save'))
        ]
      )
    );
    g.measurements[title] = tempController.text;
    if (g == activeGroup) controllers[title]?.text = tempController.text;
    refreshDialog();
  }

  Future<void> _editTextDialog(String title, TextEditingController controller, Function refreshDialog) async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Edit $title', style: const TextStyle(fontWeight: FontWeight.bold)),
        content: TextField(
          controller: controller,
          keyboardType: title.contains('Name') || title.contains('Address') || title.contains('Mobile') || title.contains('Notes') ? TextInputType.text : const TextInputType.numberWithOptions(decimal: true),
          autofocus: true,
          decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true),
        ),
        actions: [
          FilledButton(onPressed: () => Navigator.pop(ctx), child: const Text('Save'))
        ]
      )
    );
    refreshDialog();
  }

  Future<void> _editSingleOption(String title, List<String> options, String? currentVal, Function(String?) onSave, Function refreshDialog) async {
    String? temp = currentVal;
    await showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setPopState) {
          return AlertDialog(
            title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: options.map((o) => RadioListTile<String>(
                  title: Text(o, style: const TextStyle(fontSize: 14)), 
                  value: o, 
                  groupValue: temp, 
                  onChanged: (v) { setPopState(() => temp = v); }
                )).toList()
              )
            ),
            actions: [
              FilledButton(onPressed: () { onSave(temp ?? ''); Navigator.pop(ctx); }, child: const Text('Save'))
            ]
          );
        }
      )
    );
    refreshDialog();
  }

  Future<void> _editPonchaSingle(RequirementGroup g, Function refreshDialog) async {
    String? temp = g.measurements['Poncha Stitching'];
    await showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setPopState) => AlertDialog(
          title: const Text('Poncha Stitching', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: ['2 Up, 2 Down', '1 Up, 3 Down', '1 Up, 2 Mid, 3 Down'].map((opt) => RadioListTile<String>(
              title: _buildPonchaVisualListTile(opt),
              value: opt,
              groupValue: temp,
              onChanged: (v) { setPopState(() => temp = v); }
            )).toList()
          ),
          actions: [
            FilledButton(onPressed: () { Navigator.pop(ctx); }, child: const Text('Save'))
          ]
        )
      )
    );
    final selectedTemp = temp;
    if (selectedTemp != null) {
      g.measurements['Poncha Stitching'] = selectedTemp;
    }
    refreshDialog();
  }

  Future<void> _showGarmentTypePopup({RequirementGroup? targetGroup, Function? onSaved}) async {
    final group = targetGroup ?? activeGroup;
    String? tempSelected = group.garmentType.isEmpty ? 'Qameez Shalwar' : group.garmentType;
    final List<String> options = ['Qameez Shalwar', 'Kurta', 'Kali Wala Jubba', 'Saada Jubba'];

    await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setPopupState) {
            return AlertDialog(
              title: const Text('Select Garment Type', style: TextStyle(fontWeight: FontWeight.bold)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: options.map((opt) => RadioListTile<String>(
                  title: Text(opt, style: const TextStyle(fontSize: 14)),
                  value: opt,
                  groupValue: tempSelected,
                  onChanged: (v) => setPopupState(() => tempSelected = v),
                )).toList(),
              ),
              actions: [
                FilledButton(
                  onPressed: () {
                    setState(() {
                      group.garmentType = tempSelected ?? 'Qameez Shalwar';
                      if (tempSelected != 'Qameez Shalwar' && group.neckOption == 'Collar') {
                        group.neckOption = '';
                        group.collarStyle = '';
                      }
                    });
                    Navigator.pop(context, true);
                  },
                  child: const Text('Save & Next'),
                )
              ],
            );
          }
        );
      }
    ).then((_) {
      if (onSaved != null) onSaved();
      else if (mounted) FocusScope.of(context).requestFocus(focusNodes['Qameez Length']);
    });
  }

  Future<void> showNeckPopup({RequirementGroup? targetGroup, Function? onSaved}) async {
    final group = targetGroup ?? activeGroup;
    String? tempNeckOption = group.neckOption.isEmpty ? null : group.neckOption;
    String? tempBandStyle = group.bandStyle.isEmpty ? null : group.bandStyle;
    String? tempCollarStyle = group.collarStyle.isEmpty ? null : group.collarStyle;
    TextEditingController tempController = TextEditingController(text: group.measurements['Neck'] ?? '');

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setPopupState) {
            return AlertDialog(
              title: const Text('Neck Details', style: TextStyle(fontWeight: FontWeight.bold)),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: tempController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(labelText: 'Measurement', border: OutlineInputBorder(), isDense: true),
                    ),
                    const SizedBox(height: 10),
                    RadioListTile<String>(title: const Text('مغزی (Magzi)'), value: 'Magzi', groupValue: tempNeckOption, dense: true, onChanged: (v) => setPopupState(() { tempNeckOption = v; tempBandStyle = null; tempCollarStyle = null; })),
                    RadioListTile<String>(title: const Text('بینڈ (Band)'), value: 'Band', groupValue: tempNeckOption, dense: true, onChanged: (v) => setPopupState(() { tempNeckOption = v; tempCollarStyle = null; })),
                    if (tempNeckOption == 'Band') ...[
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Expanded(child: RadioListTile<String>(title: const Text('Square', style: TextStyle(fontSize: 12)), value: 'Square Band', groupValue: tempBandStyle, dense: true, onChanged: (v) => setPopupState(() => tempBandStyle = v))),
                            Expanded(child: RadioListTile<String>(title: const Text('Round', style: TextStyle(fontSize: 12)), value: 'Round Band', groupValue: tempBandStyle, dense: true, onChanged: (v) => setPopupState(() => tempBandStyle = v))),
                          ],
                        ),
                      ),
                    ],
                    RadioListTile<String>(title: const Text('کالر (Collar)'), value: 'Collar', groupValue: tempNeckOption, dense: true, onChanged: (v) => setPopupState(() { tempNeckOption = v; tempBandStyle = null; })),
                    if (tempNeckOption == 'Collar') ...[
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Expanded(child: RadioListTile<String>(title: const Text('French', style: TextStyle(fontSize: 12)), value: 'French Collar', groupValue: tempCollarStyle, dense: true, onChanged: (v) => setPopupState(() => tempCollarStyle = v))),
                            Expanded(child: RadioListTile<String>(title: const Text('Simple', style: TextStyle(fontSize: 12)), value: 'Simple Collar', groupValue: tempCollarStyle, dense: true, onChanged: (v) => setPopupState(() => tempCollarStyle = v))),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              actions: [
                FilledButton(
                  onPressed: () {
                    setState(() {
                      group.measurements['Neck'] = tempController.text;
                      if (group == activeGroup) controllers['Neck']!.text = tempController.text;
                      group.neckOption = tempNeckOption ?? '';
                      group.bandStyle = tempBandStyle ?? '';
                      group.collarStyle = tempCollarStyle ?? '';
                    });
                    Navigator.pop(context);
                    if (onSaved != null) onSaved();
                    else moveToNextNode('Neck');
                  },
                  child: const Text('Save & Next'),
                )
              ],
            );
          },
        );
      }
    );
  }

  Future<void> showDamanPopup({RequirementGroup? targetGroup, Function? onSaved}) async {
    final group = targetGroup ?? activeGroup;
    String? tempDamanStyle = group.measurements['DamanStyle'];
    TextEditingController tempController = TextEditingController(text: group.measurements['Daman'] ?? '');

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setPopupState) {
            return AlertDialog(
              title: const Text('Daman Details', style: TextStyle(fontWeight: FontWeight.bold)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: tempController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(labelText: 'Measurement', border: OutlineInputBorder(), isDense: true),
                  ),
                  const SizedBox(height: 10),
                  RadioListTile<String>(title: const Text('سکوئر دامن (Square)'), value: 'Square Daman', groupValue: tempDamanStyle, onChanged: (v) => setPopupState(() => tempDamanStyle = v)),
                  RadioListTile<String>(title: const Text('راؤنڈ دامن (Round)'), value: 'Round Daman', groupValue: tempDamanStyle, onChanged: (v) => setPopupState(() => tempDamanStyle = v)),
                ],
              ),
              actions: [
                FilledButton(
                  onPressed: () {
                    setState(() {
                      group.measurements['Daman'] = tempController.text;
                      if (group == activeGroup) controllers['Daman']!.text = tempController.text;
                      if(tempDamanStyle != null) group.measurements['DamanStyle'] = tempDamanStyle!;
                    });
                    Navigator.pop(context);
                    if (onSaved != null) onSaved();
                    else moveToNextNode('Daman');
                  },
                  child: const Text('Save & Next'),
                )
              ],
            );
          },
        );
      }
    );
  }

  Future<void> showSleevePopup({RequirementGroup? targetGroup, Function? onSaved}) async {
    final group = targetGroup ?? activeGroup;
    String? tempSleeveOption = group.sleeveOption.isEmpty ? null : group.sleeveOption;
    String? tempCuffStyle = group.cuffCornerStyle.isEmpty ? null : group.cuffCornerStyle;
    TextEditingController tempController = TextEditingController(text: group.measurements['Sleeve'] ?? '');

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setPopupState) {
            return AlertDialog(
              title: const Text('Sleeve Details', style: TextStyle(fontWeight: FontWeight.bold)),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: tempController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(labelText: 'Measurement', border: OutlineInputBorder(), isDense: true),
                    ),
                    const SizedBox(height: 10),
                    RadioListTile<String>(title: const Text('کف (Cuff)'), value: 'Cuff', groupValue: tempSleeveOption, dense: true, onChanged: (v) => setPopupState(() { tempSleeveOption = v; })),
                    if (tempSleeveOption == 'Cuff') ...[
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          children: [
                            RadioListTile<String>(title: const Text('سکوئر کف (Square)', style: TextStyle(fontSize: 12)), value: 'Square Cuff', groupValue: tempCuffStyle, dense: true, onChanged: (v) => setPopupState(() => tempCuffStyle = v)),
                            RadioListTile<String>(title: const Text('راؤنڈ کف (Round)', style: TextStyle(fontSize: 12)), value: 'Round Cuff', groupValue: tempCuffStyle, dense: true, onChanged: (v) => setPopupState(() => tempCuffStyle = v)),
                            RadioListTile<String>(title: const Text('تکون والا کف (Triangular)', style: TextStyle(fontSize: 12)), value: 'Triangular Cuff', groupValue: tempCuffStyle, dense: true, onChanged: (v) => setPopupState(() => tempCuffStyle = v)),
                          ],
                        ),
                      ),
                    ],
                    RadioListTile<String>(title: const Text('پٹی (Patti)'), value: 'Patti', groupValue: tempSleeveOption, dense: true, onChanged: (v) => setPopupState(() { tempSleeveOption = v; tempCuffStyle = null; })),
                    RadioListTile<String>(title: const Text('کنی (Kani)'), value: 'Kani', groupValue: tempSleeveOption, dense: true, onChanged: (v) => setPopupState(() { tempSleeveOption = v; tempCuffStyle = null; })),
                    RadioListTile<String>(title: const Text('فولڈ وداؤٹ بکرم (Fold)'), value: 'Fold without Buckram', groupValue: tempSleeveOption, dense: true, onChanged: (v) => setPopupState(() { tempSleeveOption = v; tempCuffStyle = null; })),
                  ],
                ),
              ),
              actions: [
                FilledButton(
                  onPressed: () {
                    setState(() {
                      group.measurements['Sleeve'] = tempController.text;
                      if (group == activeGroup) controllers['Sleeve']!.text = tempController.text;
                      group.sleeveOption = tempSleeveOption ?? '';
                      group.cuffCornerStyle = tempCuffStyle ?? '';
                    });
                    Navigator.pop(context);
                    if (onSaved != null) onSaved();
                    else moveToNextNode('Sleeve');
                  },
                  child: const Text('Save & Next'),
                )
              ],
            );
          },
        );
      }
    );
  }

  Future<void> _showMasterSequentialPopup(int step) async {
    final g = activeGroup;
    if (step >= 12) {
      FocusScope.of(context).unfocus();
      return;
    }

    String title = '';
    List<String> options = [];
    String? currentValue;
    Function(String?) onSave = (v) {};

    if (step == 0) {
      title = 'Shalwar Type'; options = ['Shalwar', 'Pant Pajama', 'Arabi Pajama']; currentValue = g.shalwarType;
      onSave = (v) => setState(() => g.shalwarType = v ?? '');
    } else if (step == 1) {
      title = 'Shalwar Style'; options = ['Guddi Cut', 'Kunday Baale']; currentValue = g.shalwarStyle;
      onSave = (v) => setState(() => g.shalwarStyle = v ?? '');
    } else if (step == 2) {
      title = 'Waist Style'; options = ['Inside Waistband', 'Outside Waistband', 'Elastic']; currentValue = g.waistOption;
      onSave = (v) => setState(() => g.waistOption = v ?? '');
    } else if (step == 3) {
      title = 'Poncha Stitching'; options = ['2 Up, 2 Down', '1 Up, 3 Down', '1 Up, 2 Mid, 3 Down']; currentValue = g.measurements['Poncha Stitching'];
      onSave = (v) { if (v != null) setState(() => g.measurements['Poncha Stitching'] = v); };
    } else if (step == 4) {
      title = 'Placket Side'; options = ['Left', 'Right']; currentValue = g.buttonPlacketSide;
      onSave = (v) => setState(() => g.buttonPlacketSide = v ?? '');
    } else if (step == 5) {
      title = 'Button Style'; options = ['Simple Button', 'Fancy Button', 'Steel Touch', 'Nag Touch', 'Decorative Touch']; currentValue = g.buttonStyle;
      onSave = (v) => setState(() => g.buttonStyle = v ?? '');
    } else if (step == 6) {
      title = 'Front Pocket'; options = ['None', '1 Pocket', '2 Pockets']; currentValue = g.frontPocket;
      onSave = (v) => setState(() => g.frontPocket = v ?? '');
    } else if (step == 7) {
      title = 'Side Pocket'; options = ['None', '1 Pocket', '2 Pockets']; currentValue = g.sidePocket;
      onSave = (v) => setState(() => g.sidePocket = v ?? '');
    } else if (step == 8) {
      title = 'Shalwar Pocket'; options = ['None', '1 Pocket', '2 Pockets']; currentValue = g.shalwarPocket;
      onSave = (v) => setState(() => g.shalwarPocket = v ?? '');
    } else if (step == 9) {
      title = 'Stitching Type'; options = ['Single Plain Thread', 'Double Plain Thread', 'Single Silk Thread', 'Double Silk Thread']; currentValue = g.stitchingOption;
      onSave = (v) => setState(() => g.stitchingOption = v ?? '');
    } else if (step == 10) {
      title = 'Tape Width'; options = ['1 inch', '¾ inch', '½ inch']; currentValue = g.interfacingWidth;
      onSave = (v) => setState(() => g.interfacingWidth = v ?? '');
    } else if (step == 11) {
      title = 'Interfacing Quality'; options = ['Premium Quality', 'Standard Quality']; currentValue = g.measurements['Interfacing Quality'];
      onSave = (v) { if (v != null) setState(() => g.measurements['Interfacing Quality'] = v); };
    }

    String? tempSelected = currentValue;
    if (tempSelected != null && tempSelected.isEmpty) tempSelected = null;

    await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setPopupState) {
            return AlertDialog(
              title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: options.map((opt) => RadioListTile<String>(
                    title: step == 3 ? _buildPonchaVisualListTile(opt) : Text(opt, style: const TextStyle(fontSize: 14)),
                    value: opt,
                    groupValue: tempSelected,
                    onChanged: (v) => setPopupState(() => tempSelected = v),
                  )).toList(),
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel / Stop')),
                FilledButton(
                  onPressed: () {
                    onSave(tempSelected);
                    Navigator.pop(context, true);
                  },
                  child: Text(step == 11 ? 'Save & Finish' : 'Save & Next'),
                )
              ],
            );
          }
        );
      }
    ).then((shouldContinue) {
      if (shouldContinue == true && mounted) {
        Future.delayed(const Duration(milliseconds: 150), () {
          _showMasterSequentialPopup(step + 1);
        });
      }
    });
  }

  Widget _buildPonchaVisualListTile(String type) {
    return Row(
      children: [
        Text(type, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
        const SizedBox(width: 15),
        Expanded(child: _buildStitchGraphicOnly(type)),
      ],
    );
  }

  Widget _getPonchaIconSmall(String? type) {
    if (type == null || type.isEmpty) return const SizedBox();
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.center,
      child: _buildStitchGraphicOnly(type)
    );
  }

  Widget _buildStitchGraphicOnly(String type) {
    Widget line() => Container(height: 1.0, width: 30, color: Colors.blueGrey.shade800, margin: const EdgeInsets.symmetric(vertical: 1.0));
    if (type == '2 Up, 2 Down') return Column(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [line(), line(), const SizedBox(height: 2), line(), line()]);
    if (type == '1 Up, 3 Down') return Column(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [line(), const SizedBox(height: 2), line(), line(), line()]);
    if (type == '1 Up, 2 Mid, 3 Down') return Column(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [line(), const SizedBox(height: 1), line(), line(), const SizedBox(height: 1), line(), line(), line()]);
    return const SizedBox();
  }

  // ==========================================
  // CHECK ORDER (PREVIEW) - 4-COLUMN UNIFORM REPORT
  // ==========================================

  void checkOrder() {
    _saveCurrentGroup();
    
    showDialog<bool>(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (BuildContext dialogContext) {
        int dialogActiveGroupIndex = 0;

        return StatefulBuilder(
          builder: (BuildContext ctx, StateSetter setDialogState) {
            
            void refreshDialog() {
              setDialogState(() {});
              _refresh();
            }

            final g = groups[dialogActiveGroupIndex];

            String neckStr = '${g.measurements['Neck'] ?? ''} ${_getNeckDisplayString(g)}'.trim();
            String damanStyleValue = g.measurements['DamanStyle'] ?? '';
            String damanStr = '${g.measurements['Daman'] ?? ''} $damanStyleValue'.trim();
            String sleeveStr = '${g.measurements['Sleeve'] ?? ''} ${_getSleeveDisplayString(g)}'.trim();

            return Dialog.fullscreen(
              backgroundColor: const Color(0xFFF5F6F8),
              child: Scaffold(
                backgroundColor: const Color(0xFFF5F6F8),
                appBar: AppBar(
                  title: const Text('Check Order (Preview)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  backgroundColor: const Color(0xFF7CB342),
                  iconTheme: const IconThemeData(color: Colors.white),
                  leading: IconButton(
                    icon: const Icon(Icons.close), 
                    onPressed: () {
                      Navigator.pop(dialogContext, false);
                    }
                  ),
                ),
                body: SingleChildScrollView(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (groups.length > 1)
                        Container(
                          height: 40,
                          margin: const EdgeInsets.only(bottom: 15),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: groups.length,
                            itemBuilder: (ctx, i) {
                              bool isSelected = i == dialogActiveGroupIndex;
                              String garmentTypeDisplay = groups[i].garmentType.isNotEmpty ? groups[i].garmentType : 'Garment';
                              return GestureDetector(
                                onTap: () => setDialogState(() => dialogActiveGroupIndex = i),
                                child: Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: isSelected ? const Color(0xFF7CB342) : Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Center(
                                    child: Text('Group ${i + 1} ($garmentTypeDisplay)', 
                                      style: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontWeight: FontWeight.bold, fontSize: 13)
                                    ),
                                  )
                                )
                              );
                            }
                          )
                        ),

                      _buildUniformBox('Customer Information', Icons.person, [
                        Row(children: [
                          Expanded(child: _checkOrderCell('Suit No', tokenNumber, () {})),
                          Expanded(child: _checkOrderCell('Booking Date', _formatDate(bookingDate), () {})),
                          Expanded(child: _checkOrderCell('Required Date', requiredDate == null ? '' : _formatDate(requiredDate!), () async { await selectRequiredDate(); refreshDialog(); })),
                        ]),
                        Row(children: [
                          Expanded(child: _checkOrderCell('Name', nameController.text, () { _editTextDialog('Name', nameController, refreshDialog); })),
                          Expanded(child: _checkOrderCell('Mobile', mobileController.text, () { _editTextDialog('Mobile', mobileController, refreshDialog); })),
                          Expanded(child: _checkOrderCell('Address', addressController.text, () { _editTextDialog('Address', addressController, refreshDialog); })),
                        ]),
                      ]),

                      _buildUniformBox('${g.garmentType.isNotEmpty ? g.garmentType : 'Garment'} Details', Icons.straighten, [
                        Row(children: [
                          Expanded(child: _checkOrderCell('Qameez', g.measurements['Qameez Length'] ?? '', () { _editMeasurementDialog('Qameez Length', g, refreshDialog); })),
                          Expanded(child: _checkOrderCell('Sleeve', g.measurements['Sleeve Length'] ?? '', () { _editMeasurementDialog('Sleeve Length', g, refreshDialog); })),
                          Expanded(child: _checkOrderCell('Teera', g.measurements['Teera'] ?? '', () { _editMeasurementDialog('Teera', g, refreshDialog); })),
                          Expanded(child: _checkOrderCell('Neck', neckStr, () async { await showNeckPopup(targetGroup: g, onSaved: () {}); refreshDialog(); })),
                        ]),
                        Row(children: [
                          Expanded(child: _checkOrderCell('Fitting', g.measurements['Fitting'] ?? '', () { _editMeasurementDialog('Fitting', g, refreshDialog); })),
                          Expanded(child: _checkOrderCell('Daman', damanStr, () async { await showDamanPopup(targetGroup: g, onSaved: () {}); refreshDialog(); })),
                          Expanded(child: _checkOrderCell('Arm Hole', g.measurements['Arm Hole'] ?? '', () { _editMeasurementDialog('Arm Hole', g, refreshDialog); })),
                          Expanded(child: _checkOrderCell('Sleeve Op', sleeveStr, () async { await showSleevePopup(targetGroup: g, onSaved: () {}); refreshDialog(); })),
                        ]),
                        const Divider(height: 16),
                        const Text('Shalwar Details', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                        const SizedBox(height: 6),
                        Row(children: [
                          Expanded(child: _checkOrderCell('Length', g.measurements['Shalwar Length'] ?? '', () { _editMeasurementDialog('Shalwar Length', g, refreshDialog); })),
                          Expanded(child: _checkOrderCell('Opening', g.measurements['Leg Opening'] ?? '', () { _editMeasurementDialog('Leg Opening', g, refreshDialog); })),
                          Expanded(child: _checkOrderCell('Rise', g.measurements['Shalwar Rise Depth'] ?? '', () { _editMeasurementDialog('Shalwar Rise Depth', g, refreshDialog); })),
                          Expanded(child: _checkOrderCell('Width', g.measurements['Shalwar Width'] ?? '', () { _editMeasurementDialog('Shalwar Width', g, refreshDialog); })),
                        ]),
                        Row(children: [
                          Expanded(child: _checkOrderCell('Type', g.shalwarType, () { _editSingleOption('Shalwar Type', ['Shalwar', 'Pant Pajama', 'Arabi Pajama'], g.shalwarType.isEmpty ? null : g.shalwarType, (v) { g.shalwarType = v ?? ''; }, refreshDialog); })),
                          Expanded(child: _checkOrderCell('Style', g.shalwarStyle, () { _editSingleOption('Shalwar Style', ['Guddi Cut', 'Kunday Baale'], g.shalwarStyle.isEmpty ? null : g.shalwarStyle, (v) { g.shalwarStyle = v ?? ''; }, refreshDialog); })),
                          Expanded(child: _checkOrderCell('Waist', g.waistOption, () { _editSingleOption('Waist', ['Inside Waistband', 'Outside Waistband', 'Elastic'], g.waistOption.isEmpty ? null : g.waistOption, (v) { g.waistOption = v ?? ''; }, refreshDialog); })),
                          Expanded(child: _checkOrderCell('Poncha', '', () { _editPonchaSingle(g, refreshDialog); }, customVisual: _getPonchaIconSmall(g.measurements['Poncha Stitching']))),
                        ]),
                      ], onTitleLongPress: () async { await _showGarmentTypePopup(targetGroup: g, onSaved: () {}); refreshDialog(); }),

                      _buildUniformBox('Other Requirements', Icons.tune, [
                        Row(children: [
                          Expanded(child: _checkOrderCell('Placket', g.buttonPlacketSide, () { _editSingleOption('Placket Side', ['Left', 'Right'], g.buttonPlacketSide.isEmpty ? null : g.buttonPlacketSide, (v) { g.buttonPlacketSide = v ?? ''; }, refreshDialog); })),
                          Expanded(child: _checkOrderCell('Button', g.buttonStyle, () { _editSingleOption('Button Style', ['Simple Button', 'Fancy Button', 'Steel Touch', 'Nag Touch', 'Decorative Touch'], g.buttonStyle.isEmpty ? null : g.buttonStyle, (v) { g.buttonStyle = v ?? ''; }, refreshDialog); })),
                          Expanded(child: _checkOrderCell('F.Pocket', g.frontPocket, () { _editSingleOption('Front Pocket', ['None', '1 Pocket', '2 Pockets'], g.frontPocket.isEmpty ? null : g.frontPocket, (v) { g.frontPocket = v ?? ''; }, refreshDialog); })),
                          Expanded(child: _checkOrderCell('S.Pocket', g.sidePocket, () { _editSingleOption('Side Pocket', ['None', '1 Pocket', '2 Pockets'], g.sidePocket.isEmpty ? null : g.sidePocket, (v) { g.sidePocket = v ?? ''; }, refreshDialog); })),
                        ]),
                        Row(children: [
                          Expanded(child: _checkOrderCell('Sh.Pocket', g.shalwarPocket, () { _editSingleOption('Shalwar Pocket', ['None', '1 Pocket', '2 Pockets'], g.shalwarPocket.isEmpty ? null : g.shalwarPocket, (v) { g.shalwarPocket = v ?? ''; }, refreshDialog); })),
                          Expanded(child: _checkOrderCell('Stitch', g.stitchingOption, () { _editSingleOption('Stitching Type', ['Single Plain Thread', 'Double Plain Thread', 'Single Silk Thread', 'Double Silk Thread'], g.stitchingOption.isEmpty ? null : g.stitchingOption, (v) { g.stitchingOption = v ?? ''; }, refreshDialog); })),
                          Expanded(child: _checkOrderCell('Tape', g.interfacingWidth, () { _editSingleOption('Tape Width', ['1 inch', '¾ inch', '½ inch'], g.interfacingWidth.isEmpty ? null : g.interfacingWidth, (v) { g.interfacingWidth = v ?? ''; }, refreshDialog); })),
                          Expanded(child: _checkOrderCell('Quality', g.measurements['Interfacing Quality'] ?? '', () { _editSingleOption('Interfacing Quality', ['Premium Quality', 'Standard Quality'], g.measurements['Interfacing Quality'], (v) { if (v != null) { g.measurements['Interfacing Quality'] = v; } }, refreshDialog); })),
                        ]),
                      ]),

                      // ==========================================
                      // 4-COLUMN ITEMIZED ORDER & PAYMENT REPORT IN PREVIEW
                      // ==========================================
                      _buildUniformBox('Order & Payment Report', Icons.payments, [
                        if (requirementMode == 'Same Requirements') ...[
                          Row(children: [
                            Expanded(child: _checkOrderCell('Group 1', '1', () {})),
                            Expanded(child: _checkOrderCell('Quantity', totalSuitQuantity.toString(), () {})),
                            Expanded(child: _checkOrderCell('Rate/Suit', 'Rs ${groups[0].price.toStringAsFixed(0)}', () {})),
                            Expanded(child: _checkOrderCell('Total', 'Rs ${total.toStringAsFixed(0)}', () {})),
                          ]),
                        ] else ...[
                          ...List.generate(groups.length, (idx) {
                            final groupItem = groups[idx];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Row(
                                children: [
                                  Expanded(child: _checkOrderCell('Group ${idx + 1}', groupItem.garmentType.isNotEmpty ? groupItem.garmentType : 'Suit', () {})),
                                  Expanded(child: _checkOrderCell('Qty', groupItem.quantity.toString(), () {})),
                                  Expanded(child: _checkOrderCell('Rate', 'Rs ${groupItem.price.toStringAsFixed(0)}', () {})),
                                  Expanded(child: _checkOrderCell('Total', 'Rs ${(groupItem.quantity * groupItem.price).toStringAsFixed(0)}', () {})),
                                ],
                              ),
                            );
                          }),
                          const Divider(height: 12),
                          Row(children: [
                            Expanded(child: _checkOrderCell('Total Suits', totalSuitQuantity.toString(), () {})),
                            Expanded(child: _checkOrderCell('Grand Total', 'Rs ${total.toStringAsFixed(0)}', () {})),
                          ]),
                        ],
                        const SizedBox(height: 4),
                        Row(children: [
                          Expanded(child: _checkOrderCell('Advance', advanceController.text, () { _editTextDialog('Advance', advanceController, refreshDialog); })),
                          Expanded(child: _checkOrderCell('Remaining', 'Rs ${remaining.toStringAsFixed(0)}', () {})),
                        ]),
                      ]),

                      _buildUniformBox('Special Notes', Icons.note_alt, [
                        _checkOrderCell('Notes', notesController.text, () { _editTextDialog('Notes', notesController, refreshDialog); })
                      ]),

                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity, 
                        child: FilledButton.icon(
                          onPressed: () {
                            Navigator.pop(dialogContext, true);
                          }, 
                          icon: const Icon(Icons.save), 
                          label: const Text('Confirm & Save Order', style: TextStyle(fontSize: 16))
                        )
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          }
        );
      }
    ).then((bool? shouldSave) {
      if (!mounted) return;
      if (shouldSave == true) {
        _saveOrder();
      }
    });
  }

  Widget _buildUniformBox(String title, IconData icon, List<Widget> children, {VoidCallback? onTitleLongPress}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF7CB342), width: 1.5), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 4, offset: const Offset(0, 2))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onLongPress: onTitleLongPress,
            child: Row(children: [
              Icon(icon, color: const Color(0xFF7CB342), size: 20), 
              const SizedBox(width: 6), 
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF7CB342))),
              if (onTitleLongPress != null) ...[
                const SizedBox(width: 4),
                const Icon(Icons.edit, size: 14, color: Color(0xFF7CB342)),
              ]
            ]),
          ),
          const Divider(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _checkOrderCell(String label, String value, VoidCallback onEdit, {Widget? customVisual}) {
    return InkWell(
      onLongPress: onEdit,
      child: Container(
        height: 48,
        margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(color: Colors.grey.shade50, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: TextStyle(fontSize: 9.5, color: Colors.grey.shade700, fontWeight: FontWeight.w500)),
            const SizedBox(height: 2),
            Expanded(
              child: customVisual != null 
                  ? Center(child: customVisual) 
                  : FittedBox(
                      fit: BoxFit.scaleDown, 
                      alignment: Alignment.centerLeft, 
                      child: Text(value.isEmpty ? 'Hold to edit' : value, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: value.isEmpty ? Colors.red : Colors.black87))
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // SAVE ORDER LOGIC & FRESH RESET
  // ==========================================

  void _saveOrder() {
    _saveCurrentGroup();

    if (widget.isEditMode && widget.existingCustomer != null) {
      int index = savedCustomers.indexWhere((c) => c.orderId == widget.existingCustomer!.orderId);
      if (index != -1) {
        savedCustomers[index] = CustomerRecord(
          orderId: widget.existingCustomer!.orderId,
          tokenNumber: widget.existingCustomer!.tokenNumber,
          name: nameController.text.trim(),
          mobile: mobileController.text.trim(),
          address: addressController.text.trim(),
          bookingDate: widget.existingCustomer!.bookingDate,
          requiredDate: requiredDate,
          garmentType: groups.first.garmentType.isNotEmpty ? groups.first.garmentType : 'Garment',
          quantity: totalSuitQuantity,
          totalAmount: total,
          advance: advance,
          remaining: remaining,
          status: widget.existingCustomer!.status,
          individualStatuses: widget.existingCustomer!.individualStatuses,
          requirementGroups: groups.map((g) => g.copy()).toList(),
        );
      }
      saveAppData();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Order updated successfully!'), backgroundColor: Colors.green));
      Navigator.pop(context);
    } else {
      savedCustomers.add(
        CustomerRecord(
          tokenNumber: tokenNumber, 
          name: nameController.text.trim(),
          mobile: mobileController.text.trim(),
          address: addressController.text.trim(),
          bookingDate: bookingDate,
          requiredDate: requiredDate,
          garmentType: groups.first.garmentType.isNotEmpty ? groups.first.garmentType : 'Garment',
          quantity: totalSuitQuantity,
          totalAmount: total,
          advance: advance,
          remaining: remaining,
          status: 'New Order',
          individualStatuses: List.generate(totalSuitQuantity, (index) => 'New Order'),
          requirementGroups: groups.map((g) => g.copy()).toList(),
        ),
      );
      nextTokenNumber++;
      saveAppData();

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Order saved successfully!'), backgroundColor: Colors.green));

      // FRESH FORM RESET: Clears form, increments token, scrolls to top (Customer Name line)
      setState(() {
        tokenNumber = generateTokenNumberFromOne();
        nameController.clear();
        mobileController.clear();
        addressController.clear();
        priceController.clear();
        advanceController.clear();
        notesController.clear();
        bookingDate = DateTime.now();
        requiredDate = null;
        requirementMode = 'Same Requirements';
        groups = [RequirementGroup(quantity: 1, price: 0.0)];
        activeGroupIndex = 0;
        _syncGroupControllers();
        for (var c in controllers.values) {
          c.clear();
        }
      });

      if (pageScrollController.hasClients) {
        pageScrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
      FocusScope.of(context).requestFocus(customerNameFocusNode);
    }
  }

  @override
  Widget build(BuildContext context) {
    final group = activeGroup;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditMode ? 'ترمیم کریں (Edit Order)' : 'نیا آرڈر (New Order)', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF7CB342),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFFF5F6F8),
      body: SingleChildScrollView(
        controller: pageScrollController,
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUniformBox('Customer Information', Icons.person, [
              Row(
                children: [
                  Expanded(child: _buildReadonlyCell('Suit No', tokenNumber)),
                  const SizedBox(width: 6),
                  Expanded(child: _buildReadonlyCell('Booking Date', _formatDate(bookingDate))),
                  const SizedBox(width: 6),
                  Expanded(child: InkWell(onTap: selectRequiredDate, child: _buildReadonlyCell('Required Date', requiredDate == null ? 'Select Date' : _formatDate(requiredDate!), suffixIcon: Icons.calendar_month))),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: _buildDirectInputCell(label: 'Name', controller: nameController, focusNode: customerNameFocusNode, keyboardType: TextInputType.name, textInputAction: TextInputAction.next, onNext: () => FocusScope.of(context).requestFocus(customerMobileFocusNode))),
                  const SizedBox(width: 6),
                  Expanded(child: _buildDirectInputCell(label: 'Mobile', controller: mobileController, focusNode: customerMobileFocusNode, keyboardType: TextInputType.phone, textInputAction: TextInputAction.next, onNext: () => FocusScope.of(context).requestFocus(customerAddressFocusNode))),
                  const SizedBox(width: 6),
                  Expanded(child: _buildDirectInputCell(label: 'Address', controller: addressController, focusNode: customerAddressFocusNode, keyboardType: TextInputType.streetAddress, textInputAction: TextInputAction.next, onNext: () { _showGarmentTypePopup(); })),
                ],
              ),
            ]),
            
            _buildUniformBox('Requirement Mode', Icons.list_alt, [
              Row(
                children: [
                  Expanded(child: _buildRadioCell(label: 'Same Requirements', isSelected: requirementMode == 'Same Requirements', onTap: () { _saveCurrentGroup(); setState(() { requirementMode = 'Same Requirements'; if (groups.length > 1) groups = [groups.first]; activeGroupIndex = 0; }); _loadGroupIntoFields(); })),
                  const SizedBox(width: 6),
                  Expanded(child: _buildRadioCell(label: 'Multiple Requirements', isSelected: requirementMode == 'Multiple Requirements', onTap: () { _saveCurrentGroup(); setState(() { requirementMode = 'Multiple Requirements'; }); _loadGroupIntoFields(); })),
                ],
              ),
            ]),

            if (requirementMode == 'Multiple Requirements') ...[
              ...List.generate(groups.length, (index) => Card(
                elevation: activeGroupIndex == index ? 2 : 0,
                color: activeGroupIndex == index ? Colors.white : Colors.grey.shade100,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: activeGroupIndex == index ? const Color(0xFF7CB342) : Colors.grey.shade300, width: 1.5),
                  borderRadius: BorderRadius.circular(8)
                ),
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  onTap: () => selectGroup(index),
                  leading: CircleAvatar(
                    backgroundColor: activeGroupIndex == index ? const Color(0xFF7CB342) : Colors.grey,
                    child: Text('${index + 1}', style: const TextStyle(color: Colors.white)),
                  ),
                  title: Text('Group ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  subtitle: const Text('Tap to select & view measurements', style: TextStyle(fontSize: 10)),
                  trailing: groups.length > 1
                      ? IconButton(icon: const Icon(Icons.delete_outline, color: Colors.red), onPressed: () => deleteRequirementGroup(index))
                      : null,
                ),
              )),
              SizedBox(width: double.infinity, child: OutlinedButton.icon(
                onPressed: addRequirementGroup, 
                icon: const Icon(Icons.copy), 
                label: const Text('Copy & Add New Group')
              )),
              const SizedBox(height: 20),
            ],
            
            _buildUniformBox(
              activeGroup.garmentType.isEmpty ? 'Select Garment Type' : '${activeGroup.garmentType} Details', 
              Icons.straighten, 
              [
                Row(
                  children: [
                    Expanded(child: _buildMeasurementInputCell('Qameez', 'Qameez Length', onNext: () => moveToNextNode('Qameez Length'))),
                    const SizedBox(width: 4),
                    Expanded(child: _buildMeasurementInputCell('Sleeve', 'Sleeve Length', onNext: () => moveToNextNode('Sleeve Length'))),
                    const SizedBox(width: 4),
                    Expanded(child: _buildMeasurementInputCell('Teera', 'Teera', onNext: () => moveToNextNode('Teera'))),
                    const SizedBox(width: 4),
                    Expanded(child: _buildMeasurementPopupCell('Neck', 'Neck', _getNeckDisplayString(group), onLongPress: showNeckPopup, onNext: showNeckPopup)),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(child: _buildMeasurementInputCell('Fitting', 'Fitting', onNext: () => moveToNextNode('Fitting'))),
                    const SizedBox(width: 4),
                    Expanded(child: _buildMeasurementPopupCell('Daman', 'Daman', group.measurements['DamanStyle'], onLongPress: showDamanPopup, onNext: showDamanPopup)),
                    const SizedBox(width: 4),
                    Expanded(child: _buildMeasurementInputCell('Arm Hole', 'Arm Hole', onNext: () => moveToNextNode('Arm Hole'))),
                    const SizedBox(width: 4),
                    Expanded(child: _buildMeasurementPopupCell('Sleeve', 'Sleeve', _getSleeveDisplayString(group), onLongPress: showSleevePopup, onNext: showSleevePopup)),
                  ],
                ),
                const Divider(height: 16),
                const Text('Shalwar Details', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(child: _buildMeasurementInputCell('Length', 'Shalwar Length', onNext: () => moveToNextNode('Shalwar Length'))),
                    const SizedBox(width: 4),
                    Expanded(child: _buildMeasurementInputCell('Leg Opening', 'Leg Opening', onNext: () => moveToNextNode('Leg Opening'))),
                    const SizedBox(width: 4),
                    Expanded(child: _buildMeasurementInputCell('Rise Depth', 'Shalwar Rise Depth', onNext: () => moveToNextNode('Shalwar Rise Depth'))),
                    const SizedBox(width: 4),
                    Expanded(child: _buildMeasurementInputCell('Width', 'Shalwar Width', onNext: () { _showMasterSequentialPopup(0); })),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(child: _buildOptionCell('Type', group.shalwarType, () => _showMasterSequentialPopup(0))),
                    const SizedBox(width: 4),
                    Expanded(child: _buildOptionCell('Style', group.shalwarStyle, () => _showMasterSequentialPopup(1))),
                    const SizedBox(width: 4),
                    Expanded(child: _buildOptionCell('Waist', group.waistOption, () => _showMasterSequentialPopup(2))),
                    const SizedBox(width: 4),
                    Expanded(child: _buildVisualOptionCell('Poncha', group.measurements['Poncha Stitching'], () => _showMasterSequentialPopup(3))),
                  ],
                ),
              ],
              onTitleLongPress: _showGarmentTypePopup
            ),

            _buildUniformBox('Other Requirements', Icons.tune, [
              Row(
                children: [
                  Expanded(child: _buildOptionCell('Placket Side', group.buttonPlacketSide, () => _showMasterSequentialPopup(4))),
                  const SizedBox(width: 4),
                  Expanded(child: _buildOptionCell('Button Style', group.buttonStyle, () => _showMasterSequentialPopup(5))),
                  const SizedBox(width: 4),
                  Expanded(child: _buildOptionCell('Front Pocket', group.frontPocket, () => _showMasterSequentialPopup(6))),
                  const SizedBox(width: 4),
                  Expanded(child: _buildOptionCell('Side Pocket', group.sidePocket, () => _showMasterSequentialPopup(7))),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(child: _buildOptionCell('Shalwar Pocket', group.shalwarPocket, () => _showMasterSequentialPopup(8))),
                  const SizedBox(width: 4),
                  Expanded(child: _buildOptionCell('Stitching', group.stitchingOption, () => _showMasterSequentialPopup(9))),
                  const SizedBox(width: 4),
                  Expanded(child: _buildOptionCell('Tape Width', group.interfacingWidth, () => _showMasterSequentialPopup(10))),
                  const SizedBox(width: 4),
                  Expanded(child: _buildOptionCell('Quality', group.measurements['Interfacing Quality'], () => _showMasterSequentialPopup(11))), 
                ],
              ),
            ]),

            // ==========================================
            // UNIFORM ORDER & PAYMENT SECTION
            // ==========================================
            _buildUniformBox('Order & Payment', Icons.payments, [
              if (requirementMode == 'Same Requirements') ...[
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 52,
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(color: Colors.grey.shade50, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Quantity (تعداد)', style: TextStyle(fontSize: 9.5, color: Colors.grey, fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: 24,
                              child: TextField(
                                controller: groupQtyControllers[0] ?? TextEditingController(text: '1'),
                                focusNode: quantityFocusNode,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onSubmitted: (_) => FocusScope.of(context).requestFocus(priceFocusNode),
                                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87),
                                decoration: const InputDecoration(border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Container(
                        height: 52,
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(color: Colors.grey.shade50, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Price per Suit (سلائی)', style: TextStyle(fontSize: 9.5, color: Colors.grey, fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: 24,
                              child: TextField(
                                controller: priceController,
                                focusNode: priceFocusNode,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onSubmitted: (_) => FocusScope.of(context).requestFocus(advanceFocusNode),
                                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
                                decoration: const InputDecoration(border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(child: _buildReadonlyCell('Total Amount', 'Rs ${total.toStringAsFixed(0)}')),
                  ],
                ),
              ] else ...[
                ...List.generate(groups.length, (idx) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.grey.shade300)
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text('Group ${idx + 1}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF7CB342))),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 42,
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Qty (تعداد)', style: TextStyle(fontSize: 8.5, color: Colors.grey)),
                                SizedBox(
                                  height: 20,
                                  child: TextField(
                                    controller: groupQtyControllers[idx],
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                    decoration: const InputDecoration(border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 42,
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Price (سلائی)', style: TextStyle(fontSize: 8.5, color: Colors.grey)),
                                SizedBox(
                                  height: 20,
                                  child: TextField(
                                    controller: groupPriceControllers[idx],
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF2E7D32)),
                                    decoration: const InputDecoration(border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const Divider(height: 12),
                Row(
                  children: [
                    Expanded(child: _buildReadonlyCell('Total Suits', totalSuitQuantity.toString())),
                    const SizedBox(width: 6),
                    Expanded(child: _buildReadonlyCell('Grand Total', 'Rs ${total.toStringAsFixed(0)}')),
                  ],
                ),
              ],
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: _buildDirectInputCell(label: 'Advance Payment', controller: advanceController, focusNode: advanceFocusNode, keyboardType: TextInputType.number, textInputAction: TextInputAction.done, onNext: () => FocusScope.of(context).unfocus())),
                  const SizedBox(width: 6),
                  Expanded(child: _buildReadonlyCell('Remaining', 'Rs ${remaining.toStringAsFixed(0)}')),
                ],
              ),
            ]),

            _buildUniformBox('Special Notes', Icons.note_alt, [
              TextField(controller: notesController, maxLines: 3, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold), decoration: const InputDecoration(border: InputBorder.none, isDense: true)),
            ]),
            
            SizedBox(width: double.infinity, child: OutlinedButton.icon(onPressed: checkOrder, icon: const Icon(Icons.fact_check), label: const Text('Check Order (Preview)', style: TextStyle(fontSize: 16)))),
            const SizedBox(height: 12),
            SizedBox(width: double.infinity, child: FilledButton.icon(onPressed: _saveOrder, icon: const Icon(Icons.save), label: Text(widget.isEditMode ? 'Update Order' : 'Save Order', style: const TextStyle(fontSize: 16)))),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildReadonlyCell(String label, String value, {IconData? suffixIcon}) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(color: Colors.grey.shade50, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: TextStyle(fontSize: 9.5, color: Colors.grey.shade700, fontWeight: FontWeight.w500)),
          const SizedBox(height: 2),
          Row(
            children: [
              Expanded(child: FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.centerLeft, child: Text(value, maxLines: 1, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87)))),
              if (suffixIcon != null) ...[const SizedBox(width: 4), Icon(suffixIcon, size: 14, color: const Color(0xFF7CB342))],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDirectInputCell({required String label, required TextEditingController controller, required FocusNode focusNode, required TextInputType keyboardType, required TextInputAction textInputAction, required VoidCallback onNext, bool readOnly = false}) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: readOnly ? Colors.grey.shade200 : Colors.grey.shade50, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: TextStyle(fontSize: 9.5, color: Colors.grey.shade700, fontWeight: FontWeight.w500)),
          SizedBox(
            height: 24,
            child: TextField(
              controller: controller, focusNode: focusNode, readOnly: readOnly, keyboardType: keyboardType, textInputAction: textInputAction, onSubmitted: (_) => onNext(),
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: readOnly ? Colors.grey.shade600 : Colors.black87),
              decoration: const InputDecoration(border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeasurementInputCell(String displayLabel, String internalKey, {required VoidCallback onNext}) {
    final controller = controllers[internalKey]!;
    final node = focusNodes[internalKey]!;
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: Colors.grey.shade50, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(fit: BoxFit.scaleDown, child: Text(displayLabel, style: TextStyle(fontSize: 9.5, color: Colors.grey.shade700, fontWeight: FontWeight.w500))),
          SizedBox(
            height: 24,
            child: TextField(
              controller: controller, focusNode: node, keyboardType: const TextInputType.numberWithOptions(decimal: true), textInputAction: TextInputAction.next,
              onChanged: (val) => activeGroup.measurements[internalKey] = val, onSubmitted: (_) => onNext(),
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87),
              decoration: const InputDecoration(border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeasurementPopupCell(String displayLabel, String internalKey, String? subText, {required VoidCallback onLongPress, required VoidCallback onNext, TextInputAction textInputAction = TextInputAction.next}) {
    final controller = controllers[internalKey]!;
    final node = focusNodes[internalKey]!;
    return GestureDetector(
      onLongPress: onLongPress,
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(color: Colors.grey.shade50, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(fit: BoxFit.scaleDown, child: Text(displayLabel, style: TextStyle(fontSize: 9.5, color: Colors.grey.shade700, fontWeight: FontWeight.w500))),
            Row(
              children: [
                Expanded(child: SizedBox(height: 18, child: TextField(controller: controller, focusNode: node, keyboardType: const TextInputType.numberWithOptions(decimal: true), textInputAction: textInputAction, onChanged: (val) => activeGroup.measurements[internalKey] = val, onSubmitted: (_) => onNext(), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87), decoration: const InputDecoration(border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero)))),
              ],
            ),
            if (subText != null && subText.isNotEmpty) FittedBox(fit: BoxFit.scaleDown, child: Text(subText, style: TextStyle(fontSize: 8.5, color: Colors.blueGrey.shade600, fontWeight: FontWeight.bold))),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCell(String title, String? value, VoidCallback onEdit) {
    return InkWell(
      onLongPress: onEdit,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        decoration: BoxDecoration(color: Colors.grey.shade50, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(fit: BoxFit.scaleDown, child: Text(title, style: TextStyle(fontSize: 9.5, color: Colors.grey.shade700, fontWeight: FontWeight.w500))),
            const SizedBox(height: 2),
            FittedBox(fit: BoxFit.scaleDown, child: Text(value ?? '', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black87))),
          ],
        ),
      ),
    );
  }
  
  Widget _buildVisualOptionCell(String title, String? value, VoidCallback onEdit) {
    return InkWell(
      onLongPress: onEdit,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        decoration: BoxDecoration(color: Colors.grey.shade50, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(fit: BoxFit.scaleDown, child: Text(title, style: TextStyle(fontSize: 9.5, color: Colors.grey.shade700, fontWeight: FontWeight.w500))),
            const SizedBox(height: 2),
            Expanded(child: Center(child: _getPonchaIconSmall(value))),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioCell({required String label, required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        decoration: BoxDecoration(color: isSelected ? const Color(0xFF7CB342).withOpacity(0.08) : Colors.grey.shade50, border: Border.all(color: isSelected ? const Color(0xFF7CB342) : Colors.grey.shade300, width: isSelected ? 1.5 : 1), borderRadius: BorderRadius.circular(6)),
        child: Center(child: FittedBox(fit: BoxFit.scaleDown, child: Text(label, style: TextStyle(fontSize: 11, fontWeight: isSelected ? FontWeight.bold : FontWeight.w500, color: isSelected ? const Color(0xFF7CB342) : Colors.grey.shade700)))),
      ),
    );
  }
}