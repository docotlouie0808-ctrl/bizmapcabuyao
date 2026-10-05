import 'dart:convert';

class Establishment {
  final String id;
  final String idNo;
  final String name;
  final String businessType;
  final String natureOfOwnership;
  final List<String> businessRegistrations;
  final int numEmployees;
  final double yearsOfOperation;
  final double estimatedCapitalization;
  final double estimatedAnnualSales;
  final bool receivedLguAssistance;
  final String lguAssistanceDetails;
  final String address;
  final String contactNumber;

  Establishment({
    required this.id,
    required this.idNo,
    required this.name,
    required this.businessType,
    required this.natureOfOwnership,
    required this.businessRegistrations,
    this.numEmployees = 1,
    this.yearsOfOperation = 1.0,
    this.estimatedCapitalization = 10000.0,
    this.estimatedAnnualSales = 50000.0,
    this.receivedLguAssistance = false,
    this.lguAssistanceDetails = '',
    this.address = 'Brgy. Casile, Cabuyao City',
    this.contactNumber = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idNo': idNo,
      'name': name,
      'businessType': businessType,
      'natureOfOwnership': natureOfOwnership,
      'businessRegistrations': businessRegistrations,
      'numEmployees': numEmployees,
      'yearsOfOperation': yearsOfOperation,
      'estimatedCapitalization': estimatedCapitalization,
      'estimatedAnnualSales': estimatedAnnualSales,
      'receivedLguAssistance': receivedLguAssistance,
      'lguAssistanceDetails': lguAssistanceDetails,
      'address': address,
      'contactNumber': contactNumber,
    };
  }

  factory Establishment.fromMap(Map<String, dynamic> map, {String? docId}) {
    return Establishment(
      id: docId ?? map['id'] ?? '',
      idNo: map['idNo'] ?? '',
      name: map['name'] ?? '',
      businessType: map['businessType'] ?? 'Retail Store',
      natureOfOwnership: map['natureOfOwnership'] ?? 'Sole Proprietorship',
      businessRegistrations: List<String>.from(map['businessRegistrations'] ?? []),
      numEmployees: (map['numEmployees'] as num?)?.toInt() ?? 1,
      yearsOfOperation: (map['yearsOfOperation'] as num?)?.toDouble() ?? 1.0,
      estimatedCapitalization: (map['estimatedCapitalization'] as num?)?.toDouble() ?? 10000.0,
      estimatedAnnualSales: (map['estimatedAnnualSales'] as num?)?.toDouble() ?? 50000.0,
      receivedLguAssistance: map['receivedLguAssistance'] as bool? ?? false,
      lguAssistanceDetails: map['lguAssistanceDetails'] ?? '',
      address: map['address'] ?? 'Brgy. Casile, Cabuyao City',
      contactNumber: map['contactNumber'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Establishment.fromJson(String source) =>
      Establishment.fromMap(json.decode(source));
}
