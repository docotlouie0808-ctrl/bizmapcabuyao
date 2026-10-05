import 'package:flutter/material.dart';
import '../services/bizmap_service.dart';

class AdminDialog extends StatefulWidget {
  const AdminDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (ctx) => const AdminDialog(),
    );
  }

  @override
  State<AdminDialog> createState() => _AdminDialogState();
}

class _AdminDialogState extends State<AdminDialog> {
  final TextEditingController _passController = TextEditingController();
  String? _errorMessage;
  bool _obscureText = true;

  @override
  void dispose() {
    _passController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    final service = BizMapService();
    final success = service.loginAdmin(_passController.text);
    if (success) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color(0xFF0D472B),
          content: Text('Admin mode activated. You can now add/edit/delete records.'),
        ),
      );
    } else {
      setState(() {
        _errorMessage = 'Invalid admin passcode. (Default: admin123)';
      });
    }
  }

  void _handleLogout() {
    BizMapService().logoutAdmin();
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Admin mode deactivated.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final service = BizMapService();
    final isAdmin = service.isAdmin;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isAdmin ? Colors.red.shade100 : Colors.amber.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isAdmin ? Icons.admin_panel_settings : Icons.lock_rounded,
              color: isAdmin ? Colors.red.shade900 : Colors.amber.shade900,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            isAdmin ? 'Admin Session' : 'Admin Authorization',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
      content: SizedBox(
        width: 380,
        child: isAdmin
            ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'You are currently authenticated as Administrator.',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'You have full permissions to:\n• Add & delete researcher members with 2MB image upload\n• Edit Enterprise Profile & aggregated indicators\n• Add, edit, and delete Establishments\n• Update Business Support & Challenges data',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade700, height: 1.5),
                  ),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Enter administrator passcode to manage researcher profiles, establishments, and survey data.',
                    style: TextStyle(fontSize: 13, height: 1.4),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passController,
                    obscureText: _obscureText,
                    onSubmitted: (_) => _handleLogin(),
                    decoration: InputDecoration(
                      labelText: 'Admin Passcode',
                      hintText: 'Enter passcode (default: admin123)',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      prefixIcon: const Icon(Icons.key),
                      suffixIcon: IconButton(
                        icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                        onPressed: () => setState(() => _obscureText = !_obscureText),
                      ),
                      errorText: _errorMessage,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Demo Hint: Use "admin123" to access admin features.',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
        if (isAdmin)
          ElevatedButton(
            onPressed: _handleLogout,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade700),
            child: const Text('Log Out Admin', style: TextStyle(color: Colors.white)),
          )
        else
          ElevatedButton(
            onPressed: _handleLogin,
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D472B)),
            child: const Text('Unlock Admin Mode', style: TextStyle(color: Colors.white)),
          ),
      ],
    );
  }
}
