import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
import 'services/bizmap_service.dart';
import 'widgets/top_nav_bar.dart';
import 'widgets/admin_dialog.dart';
import 'widgets/footer.dart';
import 'views/home_page.dart';
import 'views/enterprise_profile_page.dart';
import 'views/business_support_page.dart';
import 'views/business_challenges_page.dart';
import 'views/establishment_directory_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase initialization notice: $e');
  }

  // Pre-initialize singleton service
  BizMapService();

  runApp(const BizMapCabuyaoApp());
}

class BizMapCabuyaoApp extends StatelessWidget {
  const BizMapCabuyaoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTheme = ThemeData(
      useMaterial3: true,
      fontFamily: GoogleFonts.inter().fontFamily,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0D472B),
        primary: const Color(0xFF0D472B),
        secondary: const Color(0xFFC59B27),
        surface: const Color(0xFFF8FAF9),
      ),
      scaffoldBackgroundColor: const Color(0xFFF8FAF9),
    );

    return MaterialApp(
      title: 'BizMap Cabuyao • Brgy. Casile',
      debugShowCheckedModeBanner: false,
      theme: baseTheme.copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0D472B),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const MainPortalScreen(),
    );
  }
}

class MainPortalScreen extends StatefulWidget {
  const MainPortalScreen({super.key});

  @override
  State<MainPortalScreen> createState() => _MainPortalScreenState();
}

class _MainPortalScreenState extends State<MainPortalScreen> {
  int _currentIndex = 0;
  final ScrollController _scrollController = ScrollController();

  void _onNavigate(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget _buildCurrentPage() {
    switch (_currentIndex) {
      case 0:
        return HomePage(onNavigate: _onNavigate);
      case 1:
        return const EnterpriseProfilePage();
      case 2:
        return const BusinessSupportPage();
      case 3:
        return const BusinessChallengesPage();
      case 4:
        return const EstablishmentDirectoryPage();
      default:
        return HomePage(onNavigate: _onNavigate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(66),
        child: TopNavBar(
          selectedIndex: _currentIndex,
          onItemSelected: _onNavigate,
          onAdminToggle: () => AdminDialog.show(context),
        ),
      ),
      drawer: isMobile
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Color(0xFF0D472B),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.map_rounded, color: Color(0xFFFFDF73), size: 36),
                        const SizedBox(height: 10),
                        const Text(
                          'BIZMAP CABUYAO',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Brgy. Casile Research Portal',
                          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home_rounded),
                    title: const Text('Home & Researchers'),
                    selected: _currentIndex == 0,
                    onTap: () {
                      Navigator.pop(context);
                      _onNavigate(0);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.analytics_rounded),
                    title: const Text('Enterprise Profile'),
                    selected: _currentIndex == 1,
                    onTap: () {
                      Navigator.pop(context);
                      _onNavigate(1);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.handshake_rounded),
                    title: const Text('Business Support Needs'),
                    selected: _currentIndex == 2,
                    onTap: () {
                      Navigator.pop(context);
                      _onNavigate(2);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.warning_amber_rounded),
                    title: const Text('Business Challenges'),
                    selected: _currentIndex == 3,
                    onTap: () {
                      Navigator.pop(context);
                      _onNavigate(3);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.storefront_rounded),
                    title: const Text('Profile Per Establishment'),
                    selected: _currentIndex == 4,
                    onTap: () {
                      Navigator.pop(context);
                      _onNavigate(4);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.lock_outline, color: Color(0xFFC59B27)),
                    title: const Text('Admin Management'),
                    onTap: () {
                      Navigator.pop(context);
                      AdminDialog.show(context);
                    },
                  ),
                ],
              ),
            )
          : null,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            _buildCurrentPage(),
            PortalFooter(onNavigate: _onNavigate),
          ],
        ),
      ),
    );
  }
}
