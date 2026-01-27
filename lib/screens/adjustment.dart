import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/providers/app_user_controller_provider.dart';
import 'package:water_saver/utils/theme/app_themes.dart';
import 'package:water_saver/widgets/adjustments_page/tank_setting.dart';
import 'package:water_saver/utils/l10n/app_localizations.dart';

class AdjustmentsPage extends ConsumerWidget {
  const AdjustmentsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(appUserControllerProvider.notifier);
    final appUserData = ref.watch(appUserControllerProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          AppLocalizations.of(context)!.adjustments,
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
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: constraints.maxWidth * 0.04,
            vertical: constraints.maxHeight * 0.02,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(constraints.maxHeight * 0.015),
                  child: Text(
                    AppLocalizations.of(context)!.fillRequiredDetails,
                    style: TextStyle(
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontSize: 16.sp,
                      color: Colors.white70,
                    ),
                  ),
                ),
                SizedBox(height: constraints.maxHeight * 0.02),
                TankSettingsWidget(
                  title: AppLocalizations.of(context)!.roofTopTank,
                  motorOffValue: double.parse(
                      appUserData.requireValue.userDataReceive.rftThUpPercent),
                  motorOnValue: double.parse(
                      appUserData.requireValue.userDataReceive.rftThDnPercent),
                  onMotorOffChanged: controller.updateMotorOffThresholdTank,
                  onMotorOnChanged: controller.updateMotorOnThresholdTank,
                ),
                SizedBox(height: constraints.maxHeight * 0.02),
                TankSettingsWidget(
                  title: AppLocalizations.of(context)!.reservoir,
                  motorOffValue: null,
                  motorOnValue: double.parse(
                      appUserData.requireValue.userDataReceive.rsvThDnPercent),
                  onMotorOnChanged: controller.updateMotorOnThresholdReservoir,
                  onMotorOffChanged: null,
                ),
                SizedBox(height: constraints.maxHeight * 0.03),
                ElevatedButton(
                  onPressed: () async {
                    if (!controller.validateThresholds()) {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (BuildContext context) {
                          return Container(
                            margin: EdgeInsets.all(2.h),
                            padding: EdgeInsets.symmetric(
                                vertical: 3.h, horizontal: 4.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Icon(Icons.error,
                                              color: Colors.red, size: 18.sp),
                                          SizedBox(width: 2.w),
                                          Flexible(
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .savingUnsuccessful,
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        AppLocalizations.of(context)!.ok,
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                      return;
                    }
                    await controller.saveAdjustments();
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (BuildContext context) {
                        return Container(
                          margin: EdgeInsets.all(2.h),
                          padding: EdgeInsets.symmetric(
                              vertical: 3.h, horizontal: 4.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Icon(Icons.check_circle,
                                            color: Colors.blue, size: 18.sp),
                                        SizedBox(width: 2.w),
                                        Flexible(
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .savingSuccessful,
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!.ok,
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.textGradientColors,
                    minimumSize: Size(constraints.maxWidth * 0.8,
                        constraints.maxHeight * 0.06),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.save,
                    style: TextStyle(
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
