import 'package:flutter/material.dart';
import '../models/researcher_member.dart';
import '../services/bizmap_service.dart';
import 'smart_image.dart';

class MemberCard extends StatelessWidget {
  final ResearcherMember member;

  const MemberCard({super.key, required this.member});

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Researcher'),
        content: Text('Are you sure you want to remove ${member.name} from the research team?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade700),
            onPressed: () {
              BizMapService().deleteResearcher(member.id);
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Removed ${member.name}')),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bizService = BizMapService();

    return AnimatedBuilder(
      animation: bizService,
      builder: (context, _) {
        final isAdmin = bizService.isAdmin;

        return Card(
          elevation: 3,
          shadowColor: Colors.black12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Top Action Bar if Admin
                if (isAdmin)
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                      tooltip: 'Delete Member',
                      onPressed: () => _confirmDelete(context),
                    ),
                  ),

                // Member Photo with Gold Ring border
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFFD4AF37), Color(0xFF0D472B)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: SmartImage(
                      imageUrl: member.imageUrl,
                      width: 100,
                      height: 100,
                      fallbackInitials: member.name.isNotEmpty
                          ? member.name.split(' ').map((e) => e.isNotEmpty ? e[0] : '').take(2).join()
                          : 'RM',
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // Name
                Text(
                  member.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),

                const SizedBox(height: 6),

                // Role Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D472B).withOpacity(0.08),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFF0D472B).withOpacity(0.2)),
                  ),
                  child: Text(
                    member.role,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0D472B),
                    ),
                  ),
                ),

                if (member.bio != null && member.bio!.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Text(
                    member.bio!,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      height: 1.3,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
