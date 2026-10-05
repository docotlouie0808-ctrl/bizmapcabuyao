import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/establishment.dart';
import '../services/bizmap_service.dart';
import 'establishment_dialog.dart';

class EstablishmentCard extends StatelessWidget {
  final Establishment establishment;

  const EstablishmentCard({super.key, required this.establishment});

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Establishment Record'),
        content: Text('Are you sure you want to delete "${establishment.name}" (${establishment.idNo})?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade700),
            onPressed: () {
              BizMapService().deleteEstablishment(establishment.id);
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Deleted "${establishment.name}"')),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showDetails(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(locale: 'en_PH', symbol: '₱', decimalDigits: 0);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF0D472B).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.storefront, color: Color(0xFF0D472B)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    establishment.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    'ID No: ${establishment.idNo}',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
        content: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDetailRow('Type of Business', establishment.businessType, Icons.category_outlined),
                _buildDetailRow('Nature of Ownership', establishment.natureOfOwnership, Icons.account_balance_outlined),
                _buildDetailRow('Address', establishment.address, Icons.location_on_outlined),
                if (establishment.contactNumber.isNotEmpty)
                  _buildDetailRow('Contact', establishment.contactNumber, Icons.phone_outlined),
                _buildDetailRow('Number of Employees', '${establishment.numEmployees} worker(s)', Icons.groups_outlined),
                _buildDetailRow('Years in Operation', '${establishment.yearsOfOperation} years', Icons.timeline_outlined),
                _buildDetailRow('Estimated Capitalization', currencyFormatter.format(establishment.estimatedCapitalization), Icons.payments_outlined),
                _buildDetailRow('Estimated Annual Sales', currencyFormatter.format(establishment.estimatedAnnualSales), Icons.trending_up_outlined),
                
                const Divider(height: 24),
                
                const Text(
                  'Business Registrations Acquired:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 8),
                if (establishment.businessRegistrations.isEmpty)
                  Text('None / Informal status', style: TextStyle(color: Colors.grey.shade600, fontStyle: FontStyle.italic))
                else
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: establishment.businessRegistrations.map((reg) {
                      return Chip(
                        avatar: const Icon(Icons.verified, size: 16, color: Color(0xFF0D472B)),
                        label: Text(reg, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                        backgroundColor: const Color(0xFF0D472B).withOpacity(0.08),
                        side: BorderSide(color: const Color(0xFF0D472B).withOpacity(0.2)),
                      );
                    }).toList(),
                  ),

                const SizedBox(height: 16),
                const Text(
                  'LGU Assistance Status:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: establishment.receivedLguAssistance ? Colors.green.shade50 : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: establishment.receivedLguAssistance ? Colors.green.shade300 : Colors.grey.shade300,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        establishment.receivedLguAssistance ? Icons.check_circle : Icons.info_outline,
                        color: establishment.receivedLguAssistance ? Colors.green.shade700 : Colors.grey.shade600,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          establishment.receivedLguAssistance
                              ? (establishment.lguAssistanceDetails.isNotEmpty
                                  ? establishment.lguAssistanceDetails
                                  : 'Received LGU assistance from Cabuyao City')
                              : 'No LGU assistance received to date.',
                          style: TextStyle(
                            fontSize: 12,
                            color: establishment.receivedLguAssistance ? Colors.green.shade900 : Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: const Color(0xFF0D472B)),
          const SizedBox(width: 10),
          SizedBox(
            width: 160,
            child: Text(
              label,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade700, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bizService = BizMapService();
    final currencyFormatter = NumberFormat.currency(locale: 'en_PH', symbol: '₱', decimalDigits: 0);

    return AnimatedBuilder(
      animation: bizService,
      builder: (context, _) {
        final isAdmin = bizService.isAdmin;

        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row: ID, Name, and Admin Actions
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ID Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0D472B),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        establishment.idNo,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Name and Type
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            establishment.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                establishment.businessType,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF0D472B),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text('•', style: TextStyle(color: Colors.grey)),
                              const SizedBox(width: 8),
                              Text(
                                establishment.natureOfOwnership,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // LGU assistance badge
                    if (establishment.receivedLguAssistance)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade100,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.amber.shade400),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.stars, size: 14, color: Colors.amber.shade900),
                            const SizedBox(width: 4),
                            Text(
                              'LGU Assisted',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber.shade900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (isAdmin) ...[
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.edit_outlined, size: 20, color: Color(0xFF0D472B)),
                        tooltip: 'Edit Establishment',
                        onPressed: () => EstablishmentDialog.show(context, existing: establishment),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, size: 20, color: Colors.red),
                        tooltip: 'Delete Establishment',
                        onPressed: () => _confirmDelete(context),
                      ),
                    ],
                  ],
                ),

                const Divider(height: 24),

                // Registrations
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Acquired Registrations: ',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: establishment.businessRegistrations.isEmpty
                          ? Text(
                              'None / Informal',
                              style: TextStyle(fontSize: 12, color: Colors.grey.shade600, fontStyle: FontStyle.italic),
                            )
                          : Wrap(
                              spacing: 6,
                              runSpacing: 4,
                              children: establishment.businessRegistrations.map((reg) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.check, size: 12, color: Color(0xFF0D472B)),
                                      const SizedBox(width: 4),
                                      Text(
                                        reg,
                                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Quick stats preview
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Employees: ${establishment.numEmployees}  |  Years: ${establishment.yearsOfOperation} yrs  |  Capital: ${currencyFormatter.format(establishment.estimatedCapitalization)}',
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                    ),
                    TextButton.icon(
                      onPressed: () => _showDetails(context),
                      icon: const Icon(Icons.arrow_forward_rounded, size: 16, color: Color(0xFF0D472B)),
                      label: const Text(
                        'Full Profile',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF0D472B)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
