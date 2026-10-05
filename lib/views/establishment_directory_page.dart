import 'package:flutter/material.dart';
import '../services/bizmap_service.dart';
import '../widgets/establishment_card.dart';
import '../widgets/establishment_dialog.dart';

class EstablishmentDirectoryPage extends StatefulWidget {
  const EstablishmentDirectoryPage({super.key});

  @override
  State<EstablishmentDirectoryPage> createState() => _EstablishmentDirectoryPageState();
}

class _EstablishmentDirectoryPageState extends State<EstablishmentDirectoryPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedTypeFilter = 'All';
  String _selectedOwnershipFilter = 'All';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bizService = BizMapService();

    return AnimatedBuilder(
      animation: bizService,
      builder: (context, _) {
        final allEstablishments = bizService.establishments;
        final isAdmin = bizService.isAdmin;

        // Extract unique types and ownerships for filters
        final types = ['All', ...{...allEstablishments.map((e) => e.businessType)}];
        final ownerships = ['All', ...{...allEstablishments.map((e) => e.natureOfOwnership)}];

        // Filter establishments
        final query = _searchController.text.trim().toLowerCase();
        final filtered = allEstablishments.where((e) {
          final matchesQuery = query.isEmpty ||
              e.name.toLowerCase().contains(query) ||
              e.idNo.toLowerCase().contains(query) ||
              e.businessType.toLowerCase().contains(query) ||
              e.businessRegistrations.any((r) => r.toLowerCase().contains(query));

          final matchesType = _selectedTypeFilter == 'All' || e.businessType == _selectedTypeFilter;
          final matchesOwnership = _selectedOwnershipFilter == 'All' || e.natureOfOwnership == _selectedOwnershipFilter;

          return matchesQuery && matchesType && matchesOwnership;
        }).toList();

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1140),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
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
                                'PROFILE PER ESTABLISHMENT',
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
                            'Individual enterprise profiles, identification numbers, and acquired registrations in Casile.',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),

                      // Admin Add Button
                      if (isAdmin)
                        ElevatedButton.icon(
                          onPressed: () => EstablishmentDialog.show(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0D472B),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                          ),
                          icon: const Icon(Icons.add_business_rounded, size: 18),
                          label: const Text(
                            'Register Establishment',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Search and Filter Bar
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.grey.shade200),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          // Search field
                          TextField(
                            controller: _searchController,
                            onChanged: (_) => setState(() {}),
                            decoration: InputDecoration(
                              hintText: 'Search by business name, ID No. (e.g. BC-2024-001), or registration...',
                              prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF0D472B)),
                              suffixIcon: _searchController.text.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(Icons.clear),
                                      onPressed: () {
                                        _searchController.clear();
                                        setState(() {});
                                      },
                                    )
                                  : null,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade50,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Filter dropdowns
                          Row(
                            children: [
                              // Type filter
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: _selectedTypeFilter,
                                  decoration: InputDecoration(
                                    labelText: 'Filter by Business Type',
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                  ),
                                  items: types
                                      .map((t) => DropdownMenuItem(value: t, child: Text(t, overflow: TextOverflow.ellipsis)))
                                      .toList(),
                                  onChanged: (val) {
                                    if (val != null) setState(() => _selectedTypeFilter = val);
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Ownership filter
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: _selectedOwnershipFilter,
                                  decoration: InputDecoration(
                                    labelText: 'Filter by Nature of Ownership',
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                  ),
                                  items: ownerships
                                      .map((o) => DropdownMenuItem(value: o, child: Text(o)))
                                      .toList(),
                                  onChanged: (val) {
                                    if (val != null) setState(() => _selectedOwnershipFilter = val);
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Reset Button
                              OutlinedButton.icon(
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {
                                    _selectedTypeFilter = 'All';
                                    _selectedOwnershipFilter = 'All';
                                  });
                                },
                                icon: const Icon(Icons.refresh_rounded, size: 16),
                                label: const Text('Reset'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Results Count
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Showing ${filtered.length} of ${allEstablishments.length} establishments',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      if (isAdmin)
                        Text(
                          'Admin mode: Click edit or delete on cards to manage entries.',
                          style: TextStyle(fontSize: 12, color: Colors.amber.shade900, fontStyle: FontStyle.italic),
                        ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Establishment Cards List
                  if (filtered.isEmpty)
                    Card(
                      elevation: 0,
                      color: Colors.grey.shade100,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(48),
                        child: Column(
                          children: [
                            Icon(Icons.search_off_rounded, size: 48, color: Colors.grey.shade400),
                            const SizedBox(height: 12),
                            const Text(
                              'No establishments match your search criteria.',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Try clearing filters or searching with a different keyword.',
                              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        return EstablishmentCard(establishment: filtered[index]);
                      },
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
