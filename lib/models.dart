import 'dart:core';
import 'dart:convert';
import 'package:flutter/services.dart'; 
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

import 'package:isar/isar.dart';

part 'models.g.dart';

@embedded
class RequirementGroup {
  int quantity; 
  String garmentType; 
  double price;
  
  @ignore
  Map < String , String > ? _measurements; // Internal nullable map for Isar

  // SMART TRICK: A non-nullable getter/setter so the rest of your app doesn't crash
  @ignore
  Map < String , String > get measurements => _measurements ??= {};
  @ignore
  set measurements(Map < String , String > val) => _measurements = val;

  String neckOption; 
  String bandStyle; 
  String collarStyle;
  String sleeveOption; 
  String cuffCornerStyle; 
  String damanStyle;
  String shalwarType; 
  String shalwarStyle; 
  String waistOption;
  String buttonPlacketSide; 
  String buttonStyle; 
  String touchButtonStyle;
  String frontPocket; 
  String sidePocket; 
  String shalwarPocket;
  String stitchingOption; 
  String interfacingWidth;

  RequirementGroup({
    this.quantity = 1, 
    this.garmentType = 'Qameez Shalwar', 
    this.price = 0.0,
    Map < String , String > ? measurements,
    this.neckOption = '', this.bandStyle = '', this.collarStyle = '', this.sleeveOption = '', this.cuffCornerStyle = '', this.damanStyle = '',
    this.shalwarType = '', this.shalwarStyle = '', this.waistOption = '', this.buttonPlacketSide = '', this.buttonStyle = '', this.touchButtonStyle = '',
    this.frontPocket = '', this.sidePocket = '', this.shalwarPocket = '', this.stitchingOption = '', this.interfacingWidth = '',
  }) {
    if (measurements != null) {
      _measurements = measurements;
    }
  }

  RequirementGroup copy() {
    return RequirementGroup(
      quantity: quantity, garmentType: garmentType, price: price, measurements: Map < String , String > .from(measurements),
      neckOption: neckOption, bandStyle: bandStyle, collarStyle: collarStyle, sleeveOption: sleeveOption, cuffCornerStyle: cuffCornerStyle, damanStyle: damanStyle,
      shalwarType: shalwarType, shalwarStyle: shalwarStyle, waistOption: waistOption, buttonPlacketSide: buttonPlacketSide, buttonStyle: buttonStyle, touchButtonStyle: touchButtonStyle,
      frontPocket: frontPocket, sidePocket: sidePocket, shalwarPocket: shalwarPocket, stitchingOption: stitchingOption, interfacingWidth: interfacingWidth,
    );
  }

  Map < String , dynamic > toJson() {
    return {
      'quantity': quantity, 'garmentType': garmentType, 'price': price, 'measurements': measurements,
      'neckOption': neckOption, 'bandStyle': bandStyle, 'collarStyle': collarStyle, 'sleeveOption': sleeveOption, 'cuffCornerStyle': cuffCornerStyle, 'damanStyle': damanStyle,
      'shalwarType': shalwarType, 'shalwarStyle': shalwarStyle, 'waistOption': waistOption, 'buttonPlacketSide': buttonPlacketSide, 'buttonStyle': buttonStyle, 'touchButtonStyle': touchButtonStyle,
      'frontPocket': frontPocket, 'sidePocket': sidePocket, 'shalwarPocket': shalwarPocket, 'stitchingOption': stitchingOption, 'interfacingWidth': interfacingWidth,
    };
  }

  factory RequirementGroup.fromJson(Map < String , dynamic > json) {
    return RequirementGroup(
      quantity: json['quantity'] ?? 1, 
      garmentType: json['garmentType'] ?? 'Qameez Shalwar',
      price: (json['price'] ?? 0.0).toDouble(),
      measurements: Map < String , String > .from(json['measurements'] ?? {}),
      neckOption: json['neckOption'] ?? '', bandStyle: json['bandStyle'] ?? '', collarStyle: json['collarStyle'] ?? '', sleeveOption: json['sleeveOption'] ?? '', cuffCornerStyle: json['cuffCornerStyle'] ?? '', damanStyle: json['damanStyle'] ?? '',
      shalwarType: json['shalwarType'] ?? '', shalwarStyle: json['shalwarStyle'] ?? '', waistOption: json['waistOption'] ?? '', buttonPlacketSide: json['buttonPlacketSide'] ?? '', buttonStyle: json['buttonStyle'] ?? '', touchButtonStyle: json['touchButtonStyle'] ?? '',
      frontPocket: json['frontPocket'] ?? '', sidePocket: json['sidePocket'] ?? '', shalwarPocket: json['shalwarPocket'] ?? '', stitchingOption: json['stitchingOption'] ?? '', interfacingWidth: json['interfacingWidth'] ?? '',
    );
  }
}

int nextTokenNumber = 1;
String generateTokenNumber() => nextTokenNumber.toString();

@embedded
class LedgerEntry {
  String id;
  
  @Name("date")
  DateTime? _date; // Internal Isar date

  // SMART TRICK: Non-nullable getter for the rest of the app
  @ignore
  DateTime get date => _date ?? DateTime.now();
  @ignore
  set date(DateTime val) => _date = val;

  String description;
  double gaveAmount; 
  double gotAmount;  
  bool isAutoEntry;

  LedgerEntry({
    this.id = '', 
    DateTime? date, 
    this.description = '', 
    this.gaveAmount = 0.0, 
    this.gotAmount = 0.0,
    this.isAutoEntry = false, 
  }) {
    _date = date;
  }

  Map < String , dynamic > toJson() => {
    'id': id, 'date': date.toIso8601String(), 'description': description, 'gaveAmount': gaveAmount, 'gotAmount': gotAmount, 'isAutoEntry': isAutoEntry
  };

  factory LedgerEntry.fromJson(Map < String , dynamic > json) => LedgerEntry(
    id: json['id'] ?? '',
    date: json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
    description: json['description'] ?? '',
    gaveAmount: (json['gaveAmount'] ?? 0.0).toDouble(),
    gotAmount: (json['gotAmount'] ?? 0.0).toDouble(),
    isAutoEntry: json['isAutoEntry'] ?? false,
  );
}

@collection
class StaffRecord {
  Id isarId = Isar.autoIncrement;

  String id; 
  String name; 
  String role; 
  String phone;
  double balance; 
  double cuttingRate; 
  double singleStitchRate; 
  double doubleStitchRate;
  List < LedgerEntry > ledger; 

  StaffRecord({
    this.id = '', this.name = '', this.role = 'Tailor', this.phone = '', 
    this.balance = 0.0, this.cuttingRate = 0.0, this.singleStitchRate = 0.0, this.doubleStitchRate = 0.0,
    this.ledger = const [], 
  }); 

  Map < String , dynamic > toJson() {
    return {
      'id': id, 'name': name, 'role': role, 'phone': phone, 
      'balance': balance, 'cuttingRate': cuttingRate, 
      'singleStitchRate': singleStitchRate, 'doubleStitchRate': doubleStitchRate,
      'ledger': ledger.map((e) => e.toJson()).toList(), 
    };
  }

  factory StaffRecord.fromJson(Map < String , dynamic > json) {
    return StaffRecord(
      id: json['id'] ?? '', name: json['name'] ?? '', role: json['role'] ?? 'Tailor', phone: json['phone'] ?? '',
      balance: (json['balance'] ?? 0.0).toDouble(), 
      cuttingRate: (json['cuttingRate'] ?? 0.0).toDouble(),
      singleStitchRate: (json['singleStitchRate'] ?? 0.0).toDouble(), 
      doubleStitchRate: (json['doubleStitchRate'] ?? 0.0).toDouble(),
      ledger: json['ledger'] != null ? (json['ledger'] as List).map((e) => LedgerEntry.fromJson(e)).toList() : [],
    );
  }
}

@collection
class CustomerRecord {
  Id isarId = Isar.autoIncrement;

  String orderId;
  String tokenNumber; 
  String name; 
  String mobile; 
  String address;

  @Name("bookingDate")
  DateTime? _bookingDate;
  @ignore
  DateTime get bookingDate => _bookingDate ?? DateTime.now();
  @ignore
  set bookingDate(DateTime val) => _bookingDate = val;

  @Name("requiredDate")
  DateTime? _requiredDate;
  @ignore
  DateTime get requiredDate => _requiredDate ?? DateTime.now();
  @ignore
  set requiredDate(DateTime val) => _requiredDate = val;

  String garmentType; 
  int quantity; 
  double totalAmount;
  double advance; 
  double remaining; 
  String status; 
  List < String > individualStatuses; 
  List < RequirementGroup > requirementGroups; 
  String assignedTailorId; 
  double tailorWages;

  CustomerRecord({
    this.orderId = '', this.tokenNumber = '', this.name = '', this.mobile = '', this.address = '', 
    DateTime? bookingDate, DateTime? requiredDate,
    this.garmentType = '', this.quantity = 1, this.totalAmount = 0.0, this.advance = 0.0, this.remaining = 0.0, this.status = 'New Order',
    this.individualStatuses = const [], 
    this.requirementGroups = const [], 
    this.assignedTailorId = '', this.tailorWages = 0.0,
  }) {
    _bookingDate = bookingDate;
    _requiredDate = requiredDate;
  }

  Map < String , dynamic > toJson() {
    return {
      'orderId': orderId, 'tokenNumber': tokenNumber, 'name': name, 'mobile': mobile, 'address': address, 'bookingDate': bookingDate.toIso8601String(), 'requiredDate': requiredDate.toIso8601String(),
      'garmentType': garmentType, 'quantity': quantity, 'totalAmount': totalAmount, 'advance': advance, 'remaining': remaining, 'status': status,
      'individualStatuses': individualStatuses, 'requirementGroups': requirementGroups.map((e) => e.toJson()).toList(),
      'assignedTailorId': assignedTailorId, 'tailorWages': tailorWages,
    };
  }

  factory CustomerRecord.fromJson(Map < String , dynamic > json) {
    int q = json['quantity'] ?? 1;
    String mainStatus = json['status'] ?? 'New Order';
    List < String > loadedStatuses = json['individualStatuses'] != null ? (json['individualStatuses'] as List).map((e) => e.toString()).toList() : List.generate(q, (index) => mainStatus);

    List < RequirementGroup > loadedGroups = [];
    if (json['requirementGroups'] != null) {
      loadedGroups = (json['requirementGroups'] as List).map((e) => RequirementGroup.fromJson(e)).toList();
    } else {
      RequirementGroup oldGroup = json['requirementGroup'] != null ? RequirementGroup.fromJson(json['requirementGroup']) : RequirementGroup();
      if (json['measurements'] != null) oldGroup.measurements = Map < String , String > .from(json['measurements']);
      oldGroup.garmentType = json['garmentType'] ?? 'Qameez Shalwar';
      oldGroup.quantity = q;
      oldGroup.price = q > 0 ? (json['totalAmount'] ?? 0.0) / q : 0.0;
      loadedGroups.add(oldGroup);
    }

    return CustomerRecord(
      orderId: json['orderId'] ?? '', tokenNumber: json['tokenNumber'] ?? '', name: json['name'] ?? '', mobile: json['mobile'] ?? '', address: json['address'] ?? '',
      bookingDate: json['bookingDate'] != null ? DateTime.parse(json['bookingDate']) : DateTime.now(), 
      requiredDate: json['requiredDate'] != null ? DateTime.parse(json['requiredDate']) : DateTime.now(),
      garmentType: json['garmentType'] ?? '', quantity: q, totalAmount: (json['totalAmount'] ?? 0).toDouble(), advance: (json['advance'] ?? 0).toDouble(), remaining: (json['remaining'] ?? 0).toDouble(),
      status: mainStatus, individualStatuses: loadedStatuses, requirementGroups: loadedGroups, assignedTailorId: json['assignedTailorId'] ?? '', tailorWages: (json['tailorWages'] ?? 0.0).toDouble(),
    );
  }
}

@collection
class ExpenseRecord {
  Id isarId = Isar.autoIncrement;

  String id; 
  String title; 
  double amount; 
  
  @Name("date")
  DateTime? _date;
  @ignore
  DateTime get date => _date ?? DateTime.now();
  @ignore
  set date(DateTime val) => _date = val;

  String type;
  
  ExpenseRecord({
    this.id = '', 
    this.title = '', 
    this.amount = 0.0, 
    DateTime? date, 
    this.type = 'Daily'
  }) {
    _date = date;
  }
  
  Map < String , dynamic > toJson() => {'id': id, 'title': title, 'amount': amount, 'date': date.toIso8601String(), 'type': type};
  
  factory ExpenseRecord.fromJson(Map < String , dynamic > json) => ExpenseRecord(
    id: json['id'] ?? '', title: json['title'] ?? '', amount: (json['amount'] ?? 0.0).toDouble(),
    date: json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(), type: json['type'] ?? 'Daily',
  );
}

@collection
class PosGroup {
  Id isarId = Isar.autoIncrement;

  String id;
  String name;
  List < String > subgroups;

  PosGroup({
    this.id = '', 
    this.name = '', 
    this.subgroups = const []
  }); 

  Map < String , dynamic > toJson() => {
        'id': id,
        'name': name,
        'subgroups': subgroups,
      };

  factory PosGroup.fromJson(Map < String , dynamic > json) => PosGroup(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        subgroups: json['subgroups'] != null ? List < String > .from(json['subgroups']) : [],
      );
}

@collection
class PosProduct {
  Id isarId = Isar.autoIncrement;

  String id;
  String name;
  String uom; 
  String groupName;
  String subgroupName;
  bool isActive;
  double defaultQty;
  String description;
  double purchasePrice;
  double costPrice;     
  double sellingPrice;
  double markup; 
  bool priceChangeAllowed;
  double reorderPoint;
  double preferredQty;
  bool lowStockWarning;
  String color; 
  String imagePath; 
  double stockQuantity;

  PosProduct({
    this.id = '',
    this.name = '',
    this.uom = 'Meter',
    this.groupName = '',
    this.subgroupName = '',
    this.isActive = true,
    this.defaultQty = 1.0,
    this.description = '',
    this.purchasePrice = 0.0, 
    this.costPrice = 0.0,
    this.sellingPrice = 0.0,
    this.markup = 0.0,
    this.priceChangeAllowed = true,
    this.reorderPoint = 0.0,
    this.preferredQty = 0.0,
    this.lowStockWarning = true,
    this.color = '',
    this.imagePath = '',
    this.stockQuantity = 0.0,
  });

  Map < String , dynamic > toJson() => {
        'id': id,
        'name': name,
        'uom': uom,
        'groupName': groupName,
        'subgroupName': subgroupName,
        'isActive': isActive,
        'defaultQty': defaultQty,
        'description': description,
        'purchasePrice': purchasePrice,
        'costPrice': costPrice,
        'sellingPrice': sellingPrice,
        'markup': markup,
        'priceChangeAllowed': priceChangeAllowed,
        'reorderPoint': reorderPoint,
        'preferredQty': preferredQty,
        'lowStockWarning': lowStockWarning,
        'color': color,
        'imagePath': imagePath,
        'stockQuantity': stockQuantity,
      };

  factory PosProduct.fromJson(Map < String , dynamic > json) => PosProduct(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        uom: json['uom'] ?? 'Meter',
        groupName: json['groupName'] ?? '',
        subgroupName: json['subgroupName'] ?? '',
        isActive: json['isActive'] ?? true,
        defaultQty: (json['defaultQty'] ?? 1.0).toDouble(),
        description: json['description'] ?? '',
        purchasePrice: (json['purchasePrice'] ?? 0.0).toDouble(),
        costPrice: (json['costPrice'] ?? 0.0).toDouble(),
        sellingPrice: (json['sellingPrice'] ?? 0.0).toDouble(),
        markup: (json['markup'] ?? 0.0).toDouble(),
        priceChangeAllowed: json['priceChangeAllowed'] ?? true,
        reorderPoint: (json['reorderPoint'] ?? 0.0).toDouble(),
        preferredQty: (json['preferredQty'] ?? 0.0).toDouble(),
        lowStockWarning: json['lowStockWarning'] ?? true,
        color: json['color'] ?? '',
        imagePath: json['imagePath'] ?? '',
        stockQuantity: (json['stockQuantity'] ?? 0.0).toDouble(),
      );
}

@embedded
class InvoiceItem {
  String productId;
  String productName;
  double quantity;
  double sellingPrice;
  double costPrice;

  @ignore
  PosProduct get product => PosProduct(
    id: productId, name: productName, sellingPrice: sellingPrice, costPrice: costPrice
  );

  InvoiceItem({
    this.productId = '',
    this.productName = '',
    this.quantity = 0.0,
    this.sellingPrice = 0.0,
    this.costPrice = 0.0,
  });

  Map < String , dynamic > toJson() => {
    'productId': productId,
    'productName': productName,
    'quantity': quantity,
    'sellingPrice': sellingPrice,
    'costPrice': costPrice,
  };

  factory InvoiceItem.fromJson(Map < String , dynamic > json) {
    return InvoiceItem(
      productId: json['productId'] ?? '',
      productName: json['productName'] ?? '',
      quantity: (json['quantity'] ?? 0.0).toDouble(),
      sellingPrice: (json['sellingPrice'] ?? 0.0).toDouble(),
      costPrice: (json['costPrice'] ?? 0.0).toDouble(),
    );
  }
}

@collection
class InvoiceRecord {
  Id isarId = Isar.autoIncrement;

  String invoiceId;
  
  @Name("date")
  DateTime? _date;
  @ignore
  DateTime get date => _date ?? DateTime.now();
  @ignore
  set date(DateTime val) => _date = val;

  List < InvoiceItem > items;
  double totalAmount;
  double discount;
  double cashTendered;
  String paymentType;
  String customerName;
  String customerPhone;

  InvoiceRecord({
    this.invoiceId = '',
    DateTime? date,
    this.items = const [],
    this.totalAmount = 0.0,
    this.discount = 0.0,
    this.cashTendered = 0.0,
    this.paymentType = 'Cash',
    this.customerName = '',
    this.customerPhone = '',
  }) {
    _date = date;
  }

  @ignore
  double get totalCost => items.fold(0, (sum, item) => sum + (item.costPrice * item.quantity));
  @ignore
  double get profit => totalAmount - totalCost;

  Map < String , dynamic > toJson() => {
    'invoiceId': invoiceId,
    'date': date.toIso8601String(),
    'items': items.map((i) => i.toJson()).toList(),
    'totalAmount': totalAmount,
    'discount': discount,
    'cashTendered': cashTendered,
    'paymentType': paymentType,
    'customerName': customerName,
    'customerPhone': customerPhone,
  };

  factory InvoiceRecord.fromJson(Map < String , dynamic > json) {
    return InvoiceRecord(
      invoiceId: json['invoiceId'] ?? '',
      date: json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
      items: json['items'] != null 
          ? (json['items'] as List).map((i) => InvoiceItem.fromJson(i as Map < String , dynamic > )).toList() 
          : [],
      totalAmount: (json['totalAmount'] ?? 0.0).toDouble(),
      discount: (json['discount'] ?? 0.0).toDouble(),
      cashTendered: (json['cashTendered'] ?? 0.0).toDouble(),
      paymentType: json['paymentType'] ?? 'Cash',
      customerName: json['customerName'] ?? '',
      customerPhone: json['customerPhone'] ?? '',
    );
  }
}

List < CustomerRecord > savedCustomers = [];
List < Map < String , dynamic > > recycleBin = [];
List < StaffRecord > shopStaff = [];
List < ExpenseRecord > shopExpenses = [];

List < PosGroup > posGroups = [];
List < PosProduct > posProducts = [];
List < InvoiceRecord > invoiceHistory = []; 

Future < void > saveAppData() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setStringList('customers_data', savedCustomers.map((e) => jsonEncode(e.toJson())).toList());
  await prefs.setStringList('recycle_bin_data', recycleBin.map((e) => jsonEncode(e)).toList());
  await prefs.setStringList('staff_data', shopStaff.map((e) => jsonEncode(e.toJson())).toList());
  await prefs.setStringList('expenses_data', shopExpenses.map((e) => jsonEncode(e.toJson())).toList());
  
  await prefs.setStringList('pos_groups_data', posGroups.map((e) => jsonEncode(e.toJson())).toList());
  await prefs.setStringList('pos_products_data', posProducts.map((e) => jsonEncode(e.toJson())).toList());
  
  await prefs.setStringList('invoice_history_data', invoiceHistory.map((e) => jsonEncode(e.toJson())).toList());
  
  await prefs.setInt('next_token_number', nextTokenNumber);
}

Future < void > loadAppData() async {
  final prefs = await SharedPreferences.getInstance();
  nextTokenNumber = prefs.getInt('next_token_number') ?? 1;

  List < String > ? jsonList = prefs.getStringList('customers_data');
  if (jsonList != null) savedCustomers = jsonList.map((e) => CustomerRecord.fromJson(jsonDecode(e))).toList();

  List < String > ? staffList = prefs.getStringList('staff_data');
  if (staffList != null) shopStaff = staffList.map((e) => StaffRecord.fromJson(jsonDecode(e))).toList();

  List < String > ? expList = prefs.getStringList('expenses_data');
  if (expList != null) shopExpenses = expList.map((e) => ExpenseRecord.fromJson(jsonDecode(e))).toList();

  List < String > ? posGList = prefs.getStringList('pos_groups_data');
  if (posGList != null) posGroups = posGList.map((e) => PosGroup.fromJson(jsonDecode(e))).toList();

  List < String > ? posPList = prefs.getStringList('pos_products_data');
  if (posPList != null) posProducts = posPList.map((e) => PosProduct.fromJson(jsonDecode(e))).toList();

  List < String > ? invList = prefs.getStringList('invoice_history_data');
  if (invList != null) {
    invoiceHistory = invList.map((e) => InvoiceRecord.fromJson(jsonDecode(e))).toList();
  }

  List < String > ? binList = prefs.getStringList('recycle_bin_data');
  if (binList != null) {
    DateTime now = DateTime.now();
    recycleBin = binList.map((e) => jsonDecode(e) as Map < String , dynamic > ).where((item) => now.difference(DateTime.parse(item['deletedAt'])).inDays <= 30).toList();
  }
}

String sanitizeUrdu(String input) {
  if (input.isEmpty) return input;
  return input
      .replaceAll('\uFB90', '\u06A9')
      .replaceAll('\uFB8E', '\u06A9')
      .replaceAll('\uFB8F', '\u06A9')
      .replaceAll('\uFB91', '\u06A9')
      .replaceAll('\u0643', '\u06A9') 
      .replaceAll('\uFEEB', '\u06D2') 
      .replaceAll('\uFEEA', '\u06D2');
}

Future < void > generateAndShareUniversalPdf({
  required String title,
  required String subtitle,
  required List < String > headers,
  required List < List < String > > rows,
  required String fileName,
}) async {
  final pdf = pw.Document();

  final fontData = await rootBundle.load('assets/fonts/urdu_font.ttf');
  final urduFont = pw.Font.ttf(fontData);

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      theme: pw.ThemeData.withFont(base: urduFont, bold: urduFont),
      textDirection: pw.TextDirection.rtl, 
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              sanitizeUrdu(title), 
              style: pw.TextStyle(font: urduFont, fontSize: 20, fontWeight: pw.FontWeight.bold)
            ),
            pw.SizedBox(height: 6),
            pw.Text(
              sanitizeUrdu(subtitle), 
              style: pw.TextStyle(font: urduFont, fontSize: 14)
            ),
            pw.Divider(thickness: 2),
            pw.SizedBox(height: 10),
            pw.Table.fromTextArray(
              headers: headers.map((h) => sanitizeUrdu(h)).toList(), 
              headerStyle: pw.TextStyle(
                font: urduFont, 
                color: PdfColors.white, 
                fontWeight: pw.FontWeight.bold,
              ),
              headerDecoration: const pw.BoxDecoration(color: PdfColor.fromInt(0xFF7CB342)),
              cellStyle: pw.TextStyle(font: urduFont, fontSize: 12),
              cellAlignment: pw.Alignment.centerRight,
              data: rows.map((row) => row.map((cell) => sanitizeUrdu(cell)).toList()).toList(), 
            ),
          ],
        );
      },
    ),
  );

  await Printing.sharePdf(bytes: await pdf.save(), filename: fileName);
}