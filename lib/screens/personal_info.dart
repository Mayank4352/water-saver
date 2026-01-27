import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/providers/app_user_controller_provider.dart';
import 'package:water_saver/utils/theme/app_themes.dart';
import 'package:water_saver/utils/l10n/app_localizations.dart';

class PersonalInfoScreen extends ConsumerWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appUserAsync = ref.watch(appUserControllerProvider);

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
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context)!.profile,
              style: TextStyle(
                fontFamily: GoogleFonts.inter().fontFamily,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textGradientColors,
              ),
            ),
            backgroundColor: Colors.transparent,
            foregroundColor: AppColors.textGradientColors,
            elevation: 0,
            scrolledUnderElevation: 0,
            centerTitle: true,
          ),
          body: appUserAsync.when(
            data: (appUser) => _buildContent(context, appUser.userProfile),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(AppLocalizations.of(context)!
                      .errorWithMessage(error.toString())),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => ref.invalidate(appUserControllerProvider),
                    child: Text(AppLocalizations.of(context)!.retryButton),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context, dynamic profile) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final padding = constraints.maxWidth * 0.04;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Column(
            children: [
              SizedBox(height: 1.h),
              // Profile Header with FakeGlass
              _glassCard(
                context,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: padding, vertical: 1.5.h),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.textGradientColors.withAlpha(30),
                            width: 3,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: constraints.maxWidth * 0.08,
                          backgroundColor: AppColors.textGradientColors,
                          child: Text(
                            _getInitials(profile.name, profile.surname),
                            style: TextStyle(
                              fontFamily: GoogleFonts.inter().fontFamily,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${profile.name} ${profile.surname}'.trim(),
                              style: TextStyle(
                                fontFamily: GoogleFonts.inter().fontFamily,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textGradientColors,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 0.3.h),
                            Text(
                              profile.email.isEmpty
                                  ? AppLocalizations.of(context)!
                                      .noEmailProvided
                                  : profile.email,
                              style: TextStyle(
                                fontFamily: GoogleFonts.inter().fontFamily,
                                fontSize: 13.sp,
                                color: AppColors.inactivePageColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 1.5.h),
              // Personal Information
              Expanded(
                flex: 3,
                child: _glassCard(
                  context,
                  child: _buildInfoSection(
                    context,
                    title: AppLocalizations.of(context)!.personalInfo,
                    items: [
                      (AppLocalizations.of(context)!.name, profile.name),
                      (AppLocalizations.of(context)!.surname, profile.surname),
                      (AppLocalizations.of(context)!.phone, profile.contact),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 1.5.h),
              // Address
              Expanded(
                flex: 4,
                child: _glassCard(
                  context,
                  child: _buildInfoSection(
                    context,
                    title: AppLocalizations.of(context)!.address,
                    items: [
                      (AppLocalizations.of(context)!.address, profile.address),
                      (AppLocalizations.of(context)!.state, profile.state),
                      (AppLocalizations.of(context)!.country, profile.country),
                      (AppLocalizations.of(context)!.pinCode, profile.pin),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 1.5.h),
              // Device Information
              _glassCard(
                context,
                child: _buildInfoSection(
                  context,
                  title: AppLocalizations.of(context)!.deviceInformation,
                  items: [
                    (
                      AppLocalizations.of(context)!.dateOfPurchase,
                      profile.dateOfPurchase
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
            ],
          ),
        );
      },
    );
  }

  Widget _glassCard(BuildContext context, {required Widget child}) {
    return IntrinsicHeight(
      child: FakeGlass(
        shape: LiquidRoundedSuperellipse(borderRadius: 20),
        settings: LiquidGlassSettings(glassColor: Theme.of(context).cardColor),
        child: child,
      ),
    );
  }

  Widget _buildInfoSection(
    BuildContext context, {
    required String title,
    required List<(String, String)> items,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: GoogleFonts.inter().fontFamily,
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textGradientColors,
            ),
          ),
          SizedBox(height: 0.8.h),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: items
                  .expand((item) => [
                        _infoRow(context, item.$1, item.$2),
                        if (item != items.last) _divider(),
                      ])
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(BuildContext context, String label, String value) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              fontFamily: GoogleFonts.inter().fontFamily,
              fontSize: 15.sp,
              color: AppColors.inactivePageColor,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value.isEmpty ? AppLocalizations.of(context)!.notProvided : value,
            style: TextStyle(
              fontFamily: GoogleFonts.inter().fontFamily,
              fontSize: 15.sp,
              color: AppColors.textGradientColors,
              fontWeight: FontWeight.w900,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _divider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: const Color.fromARGB(60, 129, 128, 128),
    );
  }

  String _getInitials(String firstName, String lastName) {
    String initials = '';
    if (firstName.isNotEmpty) initials += firstName[0].toUpperCase();
    if (lastName.isNotEmpty) initials += lastName[0].toUpperCase();
    return initials.isEmpty ? 'U' : initials;
  }
}
