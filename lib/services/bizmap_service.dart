import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import '../models/researcher_member.dart';
import '../models/establishment.dart';
import '../models/enterprise_data.dart';
import 'mock_data.dart';

class BizMapService extends ChangeNotifier {
  static final BizMapService _instance = BizMapService._internal();
  factory BizMapService() => _instance;
  BizMapService._internal() {
    _initData();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isAdmin = false;
  bool get isAdmin => _isAdmin;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String? _statusMessage;
  String? get statusMessage => _statusMessage;

  List<ResearcherMember> _researchers = [];
  List<ResearcherMember> get researchers => _researchers;

  List<Establishment> _establishments = [];
  List<Establishment> get establishments => _establishments;

  EnterpriseDashboardSummary _dashboardSummary = InitialData.getInitialDashboardSummary();
  EnterpriseDashboardSummary get dashboardSummary => _dashboardSummary;

  BusinessSupportData _supportData = InitialData.getInitialSupportData();
  BusinessSupportData get supportData => _supportData;

  BusinessChallengesData _challengesData = InitialData.getInitialChallengesData();
  BusinessChallengesData get challengesData => _challengesData;

  // Admin login logic
  bool loginAdmin(String password) {
    if (password.trim() == 'admin123' || password.trim() == 'casile2024' || password.trim() == 'admin') {
      _isAdmin = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logoutAdmin() {
    _isAdmin = false;
    notifyListeners();
  }

  Future<void> _initData() async {
    _isLoading = true;
    notifyListeners();

    _researchers = InitialData.getInitialResearchers();
    _establishments = InitialData.getInitialEstablishments();
    _dashboardSummary = InitialData.getInitialDashboardSummary();
    _supportData = InitialData.getInitialSupportData();
    _challengesData = InitialData.getInitialChallengesData();

    try {
      // Attempt to sync from Firestore if available
      final resSnapshot = await _firestore.collection('researchers').get();
      if (resSnapshot.docs.isNotEmpty) {
        _researchers = resSnapshot.docs
            .map((doc) => ResearcherMember.fromMap(doc.data(), docId: doc.id))
            .toList();
      }

      final estSnapshot = await _firestore.collection('establishments').get();
      if (estSnapshot.docs.isNotEmpty) {
        _establishments = estSnapshot.docs
            .map((doc) => Establishment.fromMap(doc.data(), docId: doc.id))
            .toList();
      }

      final dashDoc = await _firestore.collection('settings').doc('dashboard_summary').get();
      if (dashDoc.exists && dashDoc.data() != null) {
        _dashboardSummary = EnterpriseDashboardSummary.fromMap(dashDoc.data()!);
      }

      final supportDoc = await _firestore.collection('settings').doc('business_support').get();
      if (supportDoc.exists && supportDoc.data() != null) {
        _supportData = BusinessSupportData.fromMap(supportDoc.data()!);
      }

      final challengesDoc = await _firestore.collection('settings').doc('business_challenges').get();
      if (challengesDoc.exists && challengesDoc.data() != null) {
        _challengesData = BusinessChallengesData.fromMap(challengesDoc.data()!);
      }
    } catch (e) {
      debugPrint('Firestore fetch error or offline, fallback to initial data: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // --- Image Pick & 2MB Validation ---
  Future<String?> pickResearcherImage() async {
    try {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1600,
        maxHeight: 1600,
        imageQuality: 85,
      );

      if (image == null) {
        return null;
      }

      final bytes = await image.readAsBytes();
      const int maxSizeBytes = 2 * 1024 * 1024; // 2MB limit

      if (bytes.lengthInBytes > maxSizeBytes) {
        final currentMB = (bytes.lengthInBytes / (1024 * 1024)).toStringAsFixed(2);
        throw Exception(
          'Image size exceeds 2MB limit! The selected image is ${currentMB}MB. Please choose an image smaller than 2MB.',
        );
      }

      final ext = image.name.split('.').last.toLowerCase();
      final mime = (ext == 'jpg' || ext == 'jpeg') ? 'image/jpeg' : 'image/png';
      final base64String = base64Encode(bytes);
      return 'data:$mime;base64,$base64String';
    } catch (e) {
      rethrow;
    }
  }

  // --- Researcher Management ---
  Future<void> addResearcher(ResearcherMember member) async {
    _researchers.add(member);
    notifyListeners();

    try {
      await _firestore.collection('researchers').doc(member.id).set(member.toMap());
    } catch (e) {
      debugPrint('Error syncing researcher to firestore: $e');
    }
  }

  Future<void> deleteResearcher(String id) async {
    _researchers.removeWhere((item) => item.id == id);
    notifyListeners();

    try {
      await _firestore.collection('researchers').doc(id).delete();
    } catch (e) {
      debugPrint('Error deleting researcher in firestore: $e');
    }
  }

  // --- Establishment Management ---
  Future<void> addEstablishment(Establishment establishment) async {
    _establishments.insert(0, establishment);
    _recalculateDashboardMetrics();
    notifyListeners();

    try {
      await _firestore.collection('establishments').doc(establishment.id).set(establishment.toMap());
    } catch (e) {
      debugPrint('Error syncing establishment to firestore: $e');
    }
  }

  Future<void> updateEstablishment(Establishment establishment) async {
    final index = _establishments.indexWhere((e) => e.id == establishment.id);
    if (index != -1) {
      _establishments[index] = establishment;
      _recalculateDashboardMetrics();
      notifyListeners();

      try {
        await _firestore.collection('establishments').doc(establishment.id).set(establishment.toMap());
      } catch (e) {
        debugPrint('Error updating establishment in firestore: $e');
      }
    }
  }

  Future<void> deleteEstablishment(String id) async {
    _establishments.removeWhere((e) => e.id == id);
    _recalculateDashboardMetrics();
    notifyListeners();

    try {
      await _firestore.collection('establishments').doc(id).delete();
    } catch (e) {
      debugPrint('Error deleting establishment in firestore: $e');
    }
  }

  void _recalculateDashboardMetrics() {
    // Dynamically update dashboard summary if establishments are modified
    final total = _establishments.length;
    if (total == 0) return;

    int registered = 0;
    int lguAssisted = 0;
    final Map<String, int> types = {};
    final Map<String, int> ownership = {};
    final Map<String, int> registrations = {};

    for (final e in _establishments) {
      if (e.businessRegistrations.isNotEmpty) registered++;
      if (e.receivedLguAssistance) lguAssisted++;

      types[e.businessType] = (types[e.businessType] ?? 0) + 1;
      ownership[e.natureOfOwnership] = (ownership[e.natureOfOwnership] ?? 0) + 1;

      for (final r in e.businessRegistrations) {
        registrations[r] = (registrations[r] ?? 0) + 1;
      }
    }

    String mainType = 'Retail / Sari-Sari';
    int maxCount = 0;
    types.forEach((k, v) {
      if (v > maxCount) {
        maxCount = v;
        mainType = '$k (${((v / total) * 100).toStringAsFixed(0)}%)';
      }
    });

    _dashboardSummary = EnterpriseDashboardSummary(
      totalEnterprises: total > _dashboardSummary.totalEnterprises ? total : _dashboardSummary.totalEnterprises,
      registeredBusinesses: registered,
      receivedLguAssistance: lguAssisted,
      mainBusinessType: mainType,
      businessTypes: types.isNotEmpty ? types : _dashboardSummary.businessTypes,
      natureOfOwnership: ownership.isNotEmpty ? ownership : _dashboardSummary.natureOfOwnership,
      employeeDistribution: _dashboardSummary.employeeDistribution,
      yearsOfOperation: _dashboardSummary.yearsOfOperation,
      capitalizationDistribution: _dashboardSummary.capitalizationDistribution,
      annualSalesDistribution: _dashboardSummary.annualSalesDistribution,
      businessRegistrations: registrations.isNotEmpty ? registrations : _dashboardSummary.businessRegistrations,
    );
  }

  // --- Admin update for Dashboard Summary ---
  Future<void> updateDashboardSummary(EnterpriseDashboardSummary summary) async {
    _dashboardSummary = summary;
    notifyListeners();

    try {
      await _firestore.collection('settings').doc('dashboard_summary').set(summary.toMap());
    } catch (e) {
      debugPrint('Error saving dashboard summary: $e');
    }
  }

  // --- Admin update for Business Support Data ---
  Future<void> updateBusinessSupportData(BusinessSupportData data) async {
    _supportData = data;
    notifyListeners();

    try {
      await _firestore.collection('settings').doc('business_support').set(data.toMap());
    } catch (e) {
      debugPrint('Error saving support data: $e');
    }
  }

  // --- Admin update for Challenges Data ---
  Future<void> updateBusinessChallengesData(BusinessChallengesData data) async {
    _challengesData = data;
    notifyListeners();

    try {
      await _firestore.collection('settings').doc('business_challenges').set(data.toMap());
    } catch (e) {
      debugPrint('Error saving challenges data: $e');
    }
  }
}
