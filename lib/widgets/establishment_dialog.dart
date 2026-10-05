import 'package:flutter/material.dart';
import '../models/establishment.dart';
import '../services/bizmap_service.dart';

class EstablishmentDialog extends StatefulWidget {
  final Establishment? existing;

  const EstablishmentDialog({super.key, this.existing});

  static Future<void> show(BuildContext context, {Establishment? existing}) {
    return showDialog(
      context: context,
      builder: (ctx) => EstablishmentDialog(existing: existing),
    );
  }

  @override
  State<EstablishmentDialog> createState() => _EstablishmentDialogState();
}

class _EstablishmentDialogState extends State<EstablishmentDialog> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _idNoController;
  late TextEditingController _nameController;
  late TextEditingController _employeesController;
  late TextEditingController _yearsController;
  late TextEditingController _capitalController;
  late TextEditingController _salesController;
  late TextEditingController _addressController;
  late TextEditingController _contactController;
  late TextEditingController _lguDetailsController;

  late String _selectedType;
  late String _selectedOwnership;
  late bool _receivedLgu;
  late List<String> _selectedRegistrations;

  final List<String> _businessTypes = [
    'Sari-Sari Store',
    'Agri-Business & Farming',
    'Food & Beverage / Restaurant',
    'Automotive & Motorcycle Repair',
    'Cooperative / Agri-Trading',
    'Agri-Product Retail',
    'Bakery & Food Processing',
    'Water Refilling / Utility',
    'Personal Care & Services',
    'Wholesale & Hardware Retail',
    'Other Microenterprise',
  ];

  final List<String> _ownershipTypes = [
    'Sole Proprietorship',
    'Partnership',
    'Cooperative',
    'Corporation',
  ];

  final List<String> _availableRegistrations = [
    'Barangay Business Clearance',
    'Mayor\'s Permit',
    'DTI Registration',
    'BIR Certificate (Form 2303)',
    'Sanitary Permit',
    'CDA (Cooperative Development Authority)',
    'SEC Registration',
    'SSS / PhilHealth / Pag-IBIG',
  ];

  @override
  void initState() {
    super.initState();
    final item = widget.existing;
    _idNoController = TextEditingController(text: item?.idNo ?? 'BC-2024-${DateTime.now().millisecondsSinceEpoch % 1000}');
    _nameController = TextEditingController(text: item?.name ?? '');
    _employeesController = TextEditingController(text: item?.numEmployees.toString() ?? '2');
    _yearsController = TextEditingController(text: item?.yearsOfOperation.toString() ?? '3.0');
    _capitalController = TextEditingController(text: item?.estimatedCapitalization.toStringAsFixed(0) ?? '50000');
    _salesController = TextEditingController(text: item?.estimatedAnnualSales.toStringAsFixed(0) ?? '150000');
    _addressController = TextEditingController(text: item?.address ?? 'Brgy. Casile, Cabuyao City');
    _contactController = TextEditingController(text: item?.contactNumber ?? '');
    _lguDetailsController = TextEditingController(text: item?.lguAssistanceDetails ?? '');

    _selectedType = item?.businessType ?? _businessTypes.first;
    if (!_businessTypes.contains(_selectedType)) {
      _businessTypes.add(_selectedType);
    }

    _selectedOwnership = item?.natureOfOwnership ?? _ownershipTypes.first;
    _receivedLgu = item?.receivedLguAssistance ?? false;
    _selectedRegistrations = List<String>.from(item?.businessRegistrations ?? ['Barangay Business Clearance']);
  }

  @override
  void dispose() {
    _idNoController.dispose();
    _nameController.dispose();
    _employeesController.dispose();
    _yearsController.dispose();
    _capitalController.dispose();
    _salesController.dispose();
    _addressController.dispose();
    _contactController.dispose();
    _lguDetailsController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final isEdit = widget.existing != null;
    final establishment = Establishment(
      id: isEdit ? widget.existing!.id : 'est_${DateTime.now().millisecondsSinceEpoch}',
      idNo: _idNoController.text.trim(),
      name: _nameController.text.trim(),
      businessType: _selectedType,
      natureOfOwnership: _selectedOwnership,
      businessRegistrations: _selectedRegistrations,
      numEmployees: int.tryParse(_employeesController.text.trim()) ?? 1,
      yearsOfOperation: double.tryParse(_yearsController.text.trim()) ?? 1.0,
      estimatedCapitalization: double.tryParse(_capitalController.text.trim()) ?? 10000.0,
      estimatedAnnualSales: double.tryParse(_salesController.text.trim()) ?? 50000.0,
      receivedLguAssistance: _receivedLgu,
      lguAssistanceDetails: _receivedLgu ? _lguDetailsController.text.trim() : '',
      address: _addressController.text.trim(),
      contactNumber: _contactController.text.trim(),
    );

    if (isEdit) {
      BizMapService().updateEstablishment(establishment);
    } else {
      BizMapService().addEstablishment(establishment);
    }

    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF0D472B),
        content: Text(
          isEdit
              ? 'Establishment "${establishment.name}" updated successfully!'
              : 'Establishment "${establishment.name}" registered successfully!',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existing != null;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          Icon(
            isEdit ? Icons.edit_note_rounded : Icons.add_business_rounded,
            color: const Color(0xFF0D472B),
          ),
          const SizedBox(width: 10),
          Text(
            isEdit ? 'Edit Establishment Profile' : 'Register New Establishment',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
      content: SizedBox(
        width: 600,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // ID and Name row
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: _idNoController,
                        decoration: const InputDecoration(
                          labelText: 'ID No. *',
                          hintText: 'e.g. BC-2024-001',
                          border: OutlineInputBorder(),
                        ),
                        validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Name of Business *',
                          hintText: 'e.g. Casile Heights Cafe',
                          border: OutlineInputBorder(),
                        ),
                        validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // Type of business & Nature of ownership row
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedType,
                        decoration: const InputDecoration(
                          labelText: 'Type of Business *',
                          border: OutlineInputBorder(),
                        ),
                        items: _businessTypes
                            .map((t) => DropdownMenuItem(value: t, child: Text(t, overflow: TextOverflow.ellipsis)))
                            .toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _selectedType = val);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedOwnership,
                        decoration: const InputDecoration(
                          labelText: 'Nature of Ownership *',
                          border: OutlineInputBorder(),
                        ),
                        items: _ownershipTypes
                            .map((o) => DropdownMenuItem(value: o, child: Text(o)))
                            .toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _selectedOwnership = val);
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Business Registrations (Multi-Select)
                const Text(
                  'Business Registrations Acquired:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: _availableRegistrations.map((reg) {
                    final isChecked = _selectedRegistrations.contains(reg);
                    return FilterChip(
                      selected: isChecked,
                      selectedColor: const Color(0xFF0D472B).withOpacity(0.18),
                      checkmarkColor: const Color(0xFF0D472B),
                      label: Text(
                        reg,
                        style: TextStyle(
                          fontSize: 12,
                          color: isChecked ? const Color(0xFF0D472B) : Colors.black87,
                          fontWeight: isChecked ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedRegistrations.add(reg);
                          } else {
                            _selectedRegistrations.remove(reg);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),

                const SizedBox(height: 16),

                // Numerical statistics
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _employeesController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'No. of Employees',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _yearsController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(
                          labelText: 'Years in Operation',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _capitalController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Capitalization (₱)',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _salesController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Annual Sales (₱)',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // LGU Assistance
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Received LGU Assistance?', style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: const Text('e.g. seed capital, training, tax relief, equipment assistance'),
                  value: _receivedLgu,
                  activeColor: const Color(0xFF0D472B),
                  onChanged: (val) => setState(() => _receivedLgu = val),
                ),

                if (_receivedLgu) ...[
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _lguDetailsController,
                    decoration: const InputDecoration(
                      labelText: 'LGU Assistance Details',
                      hintText: 'e.g. Seed capital grant from Cabuyao LEDIPO',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],

                const SizedBox(height: 14),

                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address in Brgy. Casile',
                    hintText: 'e.g. Purok 2, Brgy. Casile, Cabuyao City',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _contactController,
                  decoration: const InputDecoration(
                    labelText: 'Contact Number',
                    hintText: 'e.g. 0917-123-4567',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _save,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0D472B),
            foregroundColor: Colors.white,
          ),
          child: Text(isEdit ? 'Save Changes' : 'Register Establishment'),
        ),
      ],
    );
  }
}
