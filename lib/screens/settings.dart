import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/controllers/auth_controller.dart';
import 'package:water_saver/providers/app_user_controller_provider.dart';
import 'package:water_saver/providers/graph_controller_provider.dart';
import 'package:water_saver/utils/theme/app_themes.dart';
import 'package:water_saver/utils/l10n/app_localizations.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          AppLocalizations.of(context)!.settings,
          style: TextStyle(
            fontFamily: GoogleFonts.inter().fontFamily,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textGradientColors,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth * 0.04,
              vertical: constraints.maxHeight * 0.02,
            ),
            child: Column(
              children: [
                _buildSettingsSection(
                  context,
                  constraints,
                  children: [
                    _buildProfileOption(
                      constraints,
                      icon: Icons.person_outline,
                      title: AppLocalizations.of(context)!.personalInfoMenu,
                      onTap: () => context.push('/personalInfo'),
                    ),
                    _buildDivider(constraints),
                    _buildProfileOption(
                      constraints,
                      icon: Icons.notifications_outlined,
                      title: AppLocalizations.of(context)!.reminders,
                      onTap: () {},
                    ),
                    _buildDivider(constraints),
                    _buildProfileOption(
                      constraints,
                      icon: Icons.wifi,
                      title: AppLocalizations.of(context)!.setWiFiNetwork,
                      onTap: () => context.push('/wifiConfig'),
                    ),
                  ],
                ),
                SizedBox(height: constraints.maxHeight * 0.02),
                _buildSettingsSection(
                  context,
                  constraints,
                  children: [
                    _buildProfileOption(
                      constraints,
                      icon: Icons.security_outlined,
                      title: AppLocalizations.of(context)!.accountSecurity,
                      onTap: () {},
                    ),
                    _buildDivider(constraints),
                    _buildProfileOption(
                      constraints,
                      icon: Icons.link_outlined,
                      title: AppLocalizations.of(context)!.linkedAccounts,
                      onTap: () {},
                    ),
                  ],
                ),
                SizedBox(height: constraints.maxHeight * 0.02),
                _buildSettingsSection(
                  context,
                  constraints,
                  children: [
                    _buildProfileOption(
                      constraints,
                      icon: Icons.analytics_outlined,
                      title: AppLocalizations.of(context)!.dataAnalytics,
                      onTap: () {},
                    ),
                    _buildDivider(constraints),
                    _buildProfileOption(
                      constraints,
                      icon: Icons.help_outline,
                      title: AppLocalizations.of(context)!.helpSupport,
                      onTap: () {},
                    ),
                  ],
                ),
                SizedBox(height: constraints.maxHeight * 0.02),
                _buildSettingsSection(
                  context,
                  constraints,
                  children: [
                    _buildProfileOption(
                      constraints,
                      icon: Icons.logout,
                      title: AppLocalizations.of(context)!.logout,
                      onTap: () {
                        final router = GoRouter.of(context);
                        final messenger = ScaffoldMessenger.of(context);
                        AuthController().signOut().then((value) {
                          if (value) {
                            ref.invalidate(appUserControllerProvider);
                            ref.invalidate(graphControllerProvider);
                            router.go('/login');
                          } else {
                            messenger.showSnackBar(
                              SnackBar(
                                  content: Text(AppLocalizations.of(context)!
                                      .logoutFailed)),
                            );
                          }
                        });
                      },
                      isLogout: true,
                    ),
                  ],
                ),
                SizedBox(height: constraints.maxHeight * 0.03),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSettingsSection(
    BuildContext context,
    BoxConstraints constraints, {
    required List<Widget> children,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.02),
      child: FakeGlass(
        shape: LiquidRoundedSuperellipse(borderRadius: 20),
        settings: LiquidGlassSettings(glassColor: Theme.of(context).cardColor),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: constraints.maxHeight * 0.01),
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption(
    BoxConstraints constraints, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: constraints.maxWidth * 0.04,
          vertical: constraints.maxHeight * 0.03,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isLogout ? Colors.red : AppColors.textGradientColors,
              size: 6.w,
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w900,
                  color: isLogout ? Colors.red : AppColors.textGradientColors,
                ),
              ),
            ),
            if (!isLogout)
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white54,
                size: 4.w,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(BoxConstraints constraints) {
    return Divider(
      height: 1,
      thickness: 1,
      color: const Color.fromARGB(60, 129, 128, 128),
      indent: 4.w,
      endIndent: 4.w,
    );
  }
}
