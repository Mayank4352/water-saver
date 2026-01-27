import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/utils/l10n/app_localizations.dart';
import 'package:water_saver/utils/theme/app_themes.dart';
import 'package:water_saver/screens/adjustment.dart';
import 'package:water_saver/screens/home.dart';
import 'package:water_saver/screens/settings.dart';
import 'package:water_saver/screens/analysis.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const AnalysisPage(),
    const AdjustmentsPage(),
    const SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 100.h,
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: _pages[_selectedIndex],
          bottomNavigationBar: FakeGlass(
            shape: LiquidRoundedRectangle(borderRadius: 20),
            // shape: LiquidRoundedSuperellipse(borderRadius: 20),
            settings:
                LiquidGlassSettings(glassColor: Theme.of(context).cardColor),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Theme.of(context).iconTheme.color,
              unselectedItemColor: AppColors.inactivePageColor,
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: AppLocalizations.of(context)!.home,
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.analytics),
                    label: AppLocalizations.of(context)!.analysis),
                BottomNavigationBarItem(
                    icon: Icon(Icons.handyman),
                    label: AppLocalizations.of(context)!.adjustments),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: AppLocalizations.of(context)!.settings),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
