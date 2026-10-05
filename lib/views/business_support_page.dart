import 'package:flutter/material.dart';
import '../services/bizmap_service.dart';
import '../models/enterprise_data.dart';

class BusinessSupportPage extends StatelessWidget {
  const BusinessSupportPage({super.key});

  void _showAddSupportDialog(BuildContext context, String category) {
    final titleController = TextEditingController();
    final countController = TextEditingController();
    final pctController = TextEditingController();
    final descController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Add Support Need ($category)'),
        content: SizedBox(
          width: 450,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Need Title *', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: countController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Respondent Count', border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: pctController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(labelText: 'Percentage (%)', border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descController,
                maxLines: 2,
                decoration: const InputDecoration(labelText: 'Description / Context', border: OutlineInputBorder()),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D472B)),
            onPressed: () {
              if (titleController.text.trim().isEmpty) return;
              final newItem = SupportNeedItem(
                title: titleController.text.trim(),
                count: int.tryParse(countController.text.trim()) ?? 0,
                percentage: double.tryParse(pctController.text.trim()) ?? 0.0,
                description: descController.text.trim(),
              );

              final bizService = BizMapService();
              final current = bizService.supportData;

              List<SupportNeedItem> overall = List.from(current.overallNeeds);
              List<SupportNeedItem> financing = List.from(current.accessToFinancing);
              List<SupportNeedItem> marketing = List.from(current.marketingAndDigitalPromotion);
              List<SupportNeedItem> management = List.from(current.businessManagementAndTraining);

              if (category == 'Overall') {
                overall.add(newItem);
              } else if (category == 'Financing') {
                financing.add(newItem);
              } else if (category == 'Marketing') {
                marketing.add(newItem);
              } else {
                management.add(newItem);
              }

              bizService.updateBusinessSupportData(BusinessSupportData(
                overallNeeds: overall,
                accessToFinancing: financing,
                marketingAndDigitalPromotion: marketing,
                businessManagementAndTraining: management,
              ));

              Navigator.of(ctx).pop();
            },
            child: const Text('Add Need', style: TextStyle(color: Colors.white)),
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
        final support = bizService.supportData;
        final isAdmin = bizService.isAdmin;

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1140),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Page Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 4,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFC59B27),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'BUSINESS SUPPORT NEEDS',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.1,
                                  color: Color(0xFF0D472B),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Strategic interventions and developmental support identified by Barangay Casile enterprises.',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blueGrey.shade200),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.verified_user, size: 14, color: Color(0xFF0D472B)),
                            SizedBox(width: 6),
                            Text(
                              'All Data Provided by Admin',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF0D472B)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // 1. Overall Support Needs
                  _buildSupportCategoryCard(
                    context: context,
                    title: 'Overall Support Needs Ranking',
                    subtitle: 'Top prioritized requirements aggregated across all Casile business sectors',
                    icon: Icons.format_list_numbered_rounded,
                    items: support.overallNeeds,
                    accentColor: const Color(0xFF0D472B),
                    isAdmin: isAdmin,
                    onAdd: () => _showAddSupportDialog(context, 'Overall'),
                  ),

                  const SizedBox(height: 28),

                  // 2. Access to Financing
                  _buildSupportCategoryCard(
                    context: context,
                    title: 'Access to Financing Support',
                    subtitle: 'Credit facilities, soft loan programs, and working capital needs',
                    icon: Icons.account_balance_rounded,
                    items: support.accessToFinancing,
                    accentColor: const Color(0xFFC59B27),
                    isAdmin: isAdmin,
                    onAdd: () => _showAddSupportDialog(context, 'Financing'),
                  ),

                  const SizedBox(height: 28),

                  // 3. Marketing & Digital Promotion
                  _buildSupportCategoryCard(
                    context: context,
                    title: 'Marketing & Digital Promotion',
                    subtitle: 'Brand exposure, online channels, social media selling, and trade exhibits',
                    icon: Icons.campaign_rounded,
                    items: support.marketingAndDigitalPromotion,
                    accentColor: const Color(0xFF198754),
                    isAdmin: isAdmin,
                    onAdd: () => _showAddSupportDialog(context, 'Marketing'),
                  ),

                  const SizedBox(height: 28),

                  // 4. Business Management & Entrepreneurship Training
                  _buildSupportCategoryCard(
                    context: context,
                    title: 'Business Management & Entrepreneurship Training',
                    subtitle: 'Capacity building, bookkeeping literacy, costing, inventory, and compliance seminars',
                    icon: Icons.school_rounded,
                    items: support.businessManagementAndTraining,
                    accentColor: const Color(0xFF0C2340),
                    isAdmin: isAdmin,
                    onAdd: () => _showAddSupportDialog(context, 'Management'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSupportCategoryCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required List<SupportNeedItem> items,
    required Color accentColor,
    required bool isAdmin,
    required VoidCallback onAdd,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: accentColor, size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
                if (isAdmin)
                  OutlinedButton.icon(
                    onPressed: onAdd,
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('Add Need'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: accentColor,
                      side: BorderSide(color: accentColor),
                    ),
                  ),
              ],
            ),
            const Divider(height: 28),
            if (items.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text('No recorded support needs in this category.', style: TextStyle(color: Colors.grey.shade600)),
              )
            else
              Column(
                children: items.map((item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item.title,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1E293B),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: accentColor.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '${item.percentage.toStringAsFixed(1)}% (${item.count} respondents)',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: accentColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: (item.percentage / 100.0).clamp(0.0, 1.0),
                              minHeight: 6,
                              backgroundColor: Colors.grey.shade200,
                              valueColor: AlwaysStoppedAnimation<Color>(accentColor),
                            ),
                          ),
                          if (item.description.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Text(
                              item.description,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade700,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
