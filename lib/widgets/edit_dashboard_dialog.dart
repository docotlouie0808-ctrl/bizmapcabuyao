import 'package:flutter/material.dart';
import '../models/enterprise_data.dart';
import '../services/bizmap_service.dart';

class EditDashboardDialog extends StatefulWidget {
  final EnterpriseDashboardSummary current;

  const EditDashboardDialog({super.key, required this.current});

  static Future<void> show(BuildContext context, EnterpriseDashboardSummary current) {
    return showDialog(
      context: context,
      builder: (ctx) => EditDashboardDialog(current: current),
    );
  }

  @override
  State<EditDashboardDialog> createState() => _EditDashboardDialogState();
}

class _EditDashboardDialogState extends State<EditDashboardDialog> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _totalController;
  late TextEditingController _registeredController;
  late TextEditingController _lguController;
  late TextEditingController _mainTypeController;

  @override
  void initState() {
    super.initState();
    _totalController = TextEditingController(text: widget.current.totalEnterprises.toString());
    _registeredController = TextEditingController(text: widget.current.registeredBusinesses.toString());
    _lguController = TextEditingController(text: widget.current.receivedLguAssistance.toString());
    _mainTypeController = TextEditingController(text: widget.current.mainBusinessType);
  }

  @override
  void dispose() {
    _totalController.dispose();
    _registeredController.dispose();
    _lguController.dispose();
    _mainTypeController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final updated = EnterpriseDashboardSummary(
      totalEnterprises: int.tryParse(_totalController.text.trim()) ?? widget.current.totalEnterprises,
      registeredBusinesses: int.tryParse(_registeredController.text.trim()) ?? widget.current.registeredBusinesses,
      receivedLguAssistance: int.tryParse(_lguController.text.trim()) ?? widget.current.receivedLguAssistance,
      mainBusinessType: _mainTypeController.text.trim(),
      businessTypes: widget.current.businessTypes,
      natureOfOwnership: widget.current.natureOfOwnership,
      employeeDistribution: widget.current.employeeDistribution,
      yearsOfOperation: widget.current.yearsOfOperation,
      capitalizationDistribution: widget.current.capitalizationDistribution,
      annualSalesDistribution: widget.current.annualSalesDistribution,
      businessRegistrations: widget.current.businessRegistrations,
    );

    BizMapService().updateDashboardSummary(updated);
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Color(0xFF0D472B),
        content: Text('Dashboard summary figures updated successfully!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: const [
          Icon(Icons.edit_calendar_rounded, color: Color(0xFF0D472B)),
          SizedBox(width: 10),
          Text('Edit Dashboard Metrics (Admin)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
        ],
      ),
      content: SizedBox(
        width: 480,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _totalController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Total Enterprises *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.store),
                ),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _registeredController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Registered Businesses *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.verified),
                ),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _lguController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'LGU Assistance Beneficiaries *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.handshake),
                ),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _mainTypeController,
                decoration: const InputDecoration(
                  labelText: 'Main Business Type Description *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: _save,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0D472B),
            foregroundColor: Colors.white,
          ),
          child: const Text('Save Metrics'),
        ),
      ],
    );
  }
}
