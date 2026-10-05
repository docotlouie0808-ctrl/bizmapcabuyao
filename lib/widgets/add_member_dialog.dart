import 'package:flutter/material.dart';
import '../models/researcher_member.dart';
import '../services/bizmap_service.dart';
import 'smart_image.dart';

class AddMemberDialog extends StatefulWidget {
  const AddMemberDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (ctx) => const AddMemberDialog(),
    );
  }

  @override
  State<AddMemberDialog> createState() => _AddMemberDialogState();
}

class _AddMemberDialogState extends State<AddMemberDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _roleController = TextEditingController();
  final _bioController = TextEditingController();

  String? _selectedImageData;
  bool _isUploading = false;
  String? _imageError;

  @override
  void dispose() {
    _nameController.dispose();
    _roleController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    setState(() {
      _isUploading = true;
      _imageError = null;
    });

    try {
      final img = await BizMapService().pickResearcherImage();
      if (img != null) {
        setState(() {
          _selectedImageData = img;
        });
      }
    } catch (e) {
      setState(() {
        _imageError = e.toString().replaceAll('Exception: ', '');
      });
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  void _saveMember() {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedImageData == null) {
      setState(() {
        _imageError = 'Please upload a researcher photo (max 2MB).';
      });
      return;
    }

    final newMember = ResearcherMember(
      id: 'res_${DateTime.now().millisecondsSinceEpoch}',
      name: _nameController.text.trim(),
      role: _roleController.text.trim(),
      imageUrl: _selectedImageData!,
      bio: _bioController.text.trim().isNotEmpty ? _bioController.text.trim() : null,
    );

    BizMapService().addResearcher(newMember);
    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF0D472B),
        content: Text('Researcher "${newMember.name}" successfully added!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: const [
          Icon(Icons.person_add_rounded, color: Color(0xFF0D472B)),
          SizedBox(width: 10),
          Text(
            'Add Researcher Member',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
      content: SizedBox(
        width: 480,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Upload Area (Max 2MB)
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: _imageError != null ? Colors.red : Colors.grey.shade300,
                            width: 1.5,
                          ),
                        ),
                        child: _selectedImageData != null
                            ? SmartImage(
                                imageUrl: _selectedImageData!,
                                width: 120,
                                height: 120,
                                borderRadius: 15,
                              )
                            : Icon(
                                Icons.add_a_photo_outlined,
                                size: 40,
                                color: Colors.grey.shade400,
                              ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton.icon(
                        onPressed: _isUploading ? null : _pickImage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0D472B),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        ),
                        icon: _isUploading
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                              )
                            : const Icon(Icons.upload_file, size: 18),
                        label: Text(_selectedImageData != null ? 'Change Image' : 'Upload Image (Max 2MB)'),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Allowed formats: JPG, PNG • Max size: 2MB',
                        style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                      ),
                      if (_imageError != null) ...[
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.red.shade200),
                          ),
                          child: Text(
                            _imageError!,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.red.shade800, fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Name field
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Researcher Full Name *',
                    hintText: 'e.g. Dr. Juan Dela Cruz',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Please enter researcher name';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 14),

                // Role field
                TextFormField(
                  controller: _roleController,
                  decoration: const InputDecoration(
                    labelText: 'Role / Designation *',
                    hintText: 'e.g. Lead Project Researcher, Field Interviewer',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.badge_outlined),
                  ),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Please enter designation/role';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 14),

                // Bio / Field Notes
                TextFormField(
                  controller: _bioController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Bio / Specialization (Optional)',
                    hintText: 'e.g. Microenterprise Data Specialist',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.description_outlined),
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
          onPressed: _saveMember,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0D472B),
            foregroundColor: Colors.white,
          ),
          child: const Text('Save Member'),
        ),
      ],
    );
  }
}
