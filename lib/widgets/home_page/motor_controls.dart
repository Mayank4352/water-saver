import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:water_saver/utils/l10n/app_localizations.dart';
import 'package:water_saver/utils/theme/app_themes.dart';
import 'package:water_saver/widgets/home_page/control_switch.dart';

class MotorControlsWidget extends StatelessWidget {
  final bool isMotorOn;
  final bool isAutoMode;
  final VoidCallback onMotorToggle;
  final VoidCallback onAutoToggle;
  final VoidCallback onMotorButtonPressed;

  const MotorControlsWidget({
    super.key,
    required this.isMotorOn,
    required this.isAutoMode,
    required this.onMotorToggle,
    required this.onAutoToggle,
    required this.onMotorButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.02),
        child: FakeGlass(
          shape: LiquidRoundedSuperellipse(
            borderRadius: 20,
          ),
          settings:
              LiquidGlassSettings(glassColor: Theme.of(context).cardColor),
          child: Padding(
            padding:
                EdgeInsets.symmetric(vertical: constraints.maxHeight * 0.05),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth * 0.05),
                  child: Text(
                    AppLocalizations.of(context)!.waterControls,
                    style: TextStyle(
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textGradientColors,
                    ),
                  ),
                ),
                Container(
                  width: constraints.maxWidth * 0.85,
                  padding: EdgeInsets.symmetric(
                      vertical: constraints.maxHeight * 0.05),
                  margin: EdgeInsets.symmetric(
                      vertical: constraints.maxHeight * 0.02),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(constraints.maxWidth * 0.03),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.water_drop,
                          size: constraints.maxWidth * 0.06,
                        ),
                      ),
                      SizedBox(width: constraints.maxWidth * 0.04),
                      Text(
                        AppLocalizations.of(context)!.motor,
                        style: TextStyle(
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textGradientColors,
                        ),
                      ),
                      Spacer(),
                      ControlSwitch(
                        switchValue: isMotorOn,
                        onTap: onMotorToggle,
                        width: constraints.maxWidth * 0.2,
                        height: constraints.maxHeight * 0.2,
                        circularBorderRadius: 20,
                        activeThumbColor: Theme.of(context).iconTheme.color!,
                      )
                    ],
                  ),
                ),
                Container(
                  width: constraints.maxWidth * 0.85,
                  padding: EdgeInsets.symmetric(
                      vertical: constraints.maxHeight * 0.05),
                  margin: EdgeInsets.symmetric(
                      vertical: constraints.maxHeight * 0.02),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(constraints.maxWidth * 0.03),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.auto_mode,
                          size: constraints.maxWidth * 0.06,
                        ),
                      ),
                      SizedBox(width: constraints.maxWidth * 0.04),
                      Text(
                        AppLocalizations.of(context)!.autoMode,
                        style: TextStyle(
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textGradientColors,
                        ),
                      ),
                      Spacer(),
                      ControlSwitch(
                        switchValue: isAutoMode,
                        onTap: onAutoToggle,
                        width: constraints.maxWidth * 0.2,
                        height: constraints.maxHeight * 0.2,
                        circularBorderRadius: 20,
                        activeThumbColor: Theme.of(context).iconTheme.color!,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
