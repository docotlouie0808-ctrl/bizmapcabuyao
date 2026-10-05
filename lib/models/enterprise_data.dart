import 'dart:convert';

class EnterpriseDashboardSummary {
  final int totalEnterprises;
  final int registeredBusinesses;
  final int receivedLguAssistance;
  final String mainBusinessType;
  final Map<String, int> businessTypes;
  final Map<String, int> natureOfOwnership;
  final Map<String, int> employeeDistribution;
  final Map<String, int> yearsOfOperation;
  final Map<String, int> capitalizationDistribution;
  final Map<String, int> annualSalesDistribution;
  final Map<String, int> businessRegistrations;

  EnterpriseDashboardSummary({
    required this.totalEnterprises,
    required this.registeredBusinesses,
    required this.receivedLguAssistance,
    required this.mainBusinessType,
    required this.businessTypes,
    required this.natureOfOwnership,
    required this.employeeDistribution,
    required this.yearsOfOperation,
    required this.capitalizationDistribution,
    required this.annualSalesDistribution,
    required this.businessRegistrations,
  });

  Map<String, dynamic> toMap() {
    return {
      'totalEnterprises': totalEnterprises,
      'registeredBusinesses': registeredBusinesses,
      'receivedLguAssistance': receivedLguAssistance,
      'mainBusinessType': mainBusinessType,
      'businessTypes': businessTypes,
      'natureOfOwnership': natureOfOwnership,
      'employeeDistribution': employeeDistribution,
      'yearsOfOperation': yearsOfOperation,
      'capitalizationDistribution': capitalizationDistribution,
      'annualSalesDistribution': annualSalesDistribution,
      'businessRegistrations': businessRegistrations,
    };
  }

  factory EnterpriseDashboardSummary.fromMap(Map<String, dynamic> map) {
    return EnterpriseDashboardSummary(
      totalEnterprises: (map['totalEnterprises'] as num?)?.toInt() ?? 0,
      registeredBusinesses: (map['registeredBusinesses'] as num?)?.toInt() ?? 0,
      receivedLguAssistance: (map['receivedLguAssistance'] as num?)?.toInt() ?? 0,
      mainBusinessType: map['mainBusinessType'] ?? 'Sari-Sari & Retail Stores',
      businessTypes: Map<String, int>.from(map['businessTypes'] ?? {}),
      natureOfOwnership: Map<String, int>.from(map['natureOfOwnership'] ?? {}),
      employeeDistribution: Map<String, int>.from(map['employeeDistribution'] ?? {}),
      yearsOfOperation: Map<String, int>.from(map['yearsOfOperation'] ?? {}),
      capitalizationDistribution: Map<String, int>.from(map['capitalizationDistribution'] ?? {}),
      annualSalesDistribution: Map<String, int>.from(map['annualSalesDistribution'] ?? {}),
      businessRegistrations: Map<String, int>.from(map['businessRegistrations'] ?? {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory EnterpriseDashboardSummary.fromJson(String source) =>
      EnterpriseDashboardSummary.fromMap(json.decode(source));
}

class SupportNeedItem {
  final String title;
  final int count;
  final double percentage;
  final String description;

  SupportNeedItem({
    required this.title,
    required this.count,
    required this.percentage,
    required this.description,
  });

  Map<String, dynamic> toMap() => {
    'title': title,
    'count': count,
    'percentage': percentage,
    'description': description,
  };

  factory SupportNeedItem.fromMap(Map<String, dynamic> map) => SupportNeedItem(
    title: map['title'] ?? '',
    count: (map['count'] as num?)?.toInt() ?? 0,
    percentage: (map['percentage'] as num?)?.toDouble() ?? 0.0,
    description: map['description'] ?? '',
  );
}

class BusinessSupportData {
  final List<SupportNeedItem> overallNeeds;
  final List<SupportNeedItem> accessToFinancing;
  final List<SupportNeedItem> marketingAndDigitalPromotion;
  final List<SupportNeedItem> businessManagementAndTraining;

  BusinessSupportData({
    required this.overallNeeds,
    required this.accessToFinancing,
    required this.marketingAndDigitalPromotion,
    required this.businessManagementAndTraining,
  });

  Map<String, dynamic> toMap() => {
    'overallNeeds': overallNeeds.map((x) => x.toMap()).toList(),
    'accessToFinancing': accessToFinancing.map((x) => x.toMap()).toList(),
    'marketingAndDigitalPromotion': marketingAndDigitalPromotion.map((x) => x.toMap()).toList(),
    'businessManagementAndTraining': businessManagementAndTraining.map((x) => x.toMap()).toList(),
  };

  factory BusinessSupportData.fromMap(Map<String, dynamic> map) {
    return BusinessSupportData(
      overallNeeds: (map['overallNeeds'] as List? ?? [])
          .map((x) => SupportNeedItem.fromMap(Map<String, dynamic>.from(x)))
          .toList(),
      accessToFinancing: (map['accessToFinancing'] as List? ?? [])
          .map((x) => SupportNeedItem.fromMap(Map<String, dynamic>.from(x)))
          .toList(),
      marketingAndDigitalPromotion: (map['marketingAndDigitalPromotion'] as List? ?? [])
          .map((x) => SupportNeedItem.fromMap(Map<String, dynamic>.from(x)))
          .toList(),
      businessManagementAndTraining: (map['businessManagementAndTraining'] as List? ?? [])
          .map((x) => SupportNeedItem.fromMap(Map<String, dynamic>.from(x)))
          .toList(),
    );
  }
}

class BusinessChallengesData {
  final List<SupportNeedItem> financingChallenges;
  final List<SupportNeedItem> otherChallenges;

  BusinessChallengesData({
    required this.financingChallenges,
    required this.otherChallenges,
  });

  Map<String, dynamic> toMap() => {
    'financingChallenges': financingChallenges.map((x) => x.toMap()).toList(),
    'otherChallenges': otherChallenges.map((x) => x.toMap()).toList(),
  };

  factory BusinessChallengesData.fromMap(Map<String, dynamic> map) {
    return BusinessChallengesData(
      financingChallenges: (map['financingChallenges'] as List? ?? [])
          .map((x) => SupportNeedItem.fromMap(Map<String, dynamic>.from(x)))
          .toList(),
      otherChallenges: (map['otherChallenges'] as List? ?? [])
          .map((x) => SupportNeedItem.fromMap(Map<String, dynamic>.from(x)))
          .toList(),
    );
  }
}
