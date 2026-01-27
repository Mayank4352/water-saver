import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/utils/l10n/app_localizations.dart';
import 'package:water_saver/utils/theme/app_themes.dart';

class TankSettingsWidget extends ConsumerWidget {
  final String title;
  final double? motorOffValue;
  final double motorOnValue;
  final void Function(double)? onMotorOffChanged;
  final void Function(double) onMotorOnChanged;

  const TankSettingsWidget({
    super.key,
    required this.title,
    this.motorOffValue,
    required this.motorOnValue,
    this.onMotorOffChanged,
    required this.onMotorOnChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: FakeGlass(
        shape: LiquidRoundedSuperellipse(
          borderRadius: 20,
        ),
        settings: LiquidGlassSettings(glassColor: Theme.of(context).cardColor),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 2.h,
            horizontal: 4.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("helo"),
              Text(
                title,
                style: TextStyle(
                  fontFamily: GoogleFonts.inter().fontFamily,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textGradientColors,
                ),
              ),
              SizedBox(height: 2.h),
              if (motorOffValue != null && onMotorOffChanged != null)
                _buildSliderSection(
                  context,
                  label: AppLocalizations.of(context)!.motorOffThreshold,
                  value: motorOffValue ?? 0,
                  onChanged: (value) =>
                      onMotorOffChanged!(value < 2 ? 2 : value),
                ),
              _buildSliderSection(
                context,
                label: AppLocalizations.of(context)!.motorOnThreshold,
                value: motorOnValue,
                onChanged: (value) => onMotorOnChanged(value < 1 ? 1 : value),
              ),
              if ((motorOffValue ?? 101) <= motorOnValue)
                Padding(
                  padding: EdgeInsets.only(top: 1.h),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.w,
                      vertical: 1.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.red.withValues(alpha: 0.4),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.red,
                          size: 18.sp,
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context)!.thresholdValidation,
                            style: TextStyle(
                              fontFamily: GoogleFonts.inter().fontFamily,
                              color: Colors.red,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSliderSection(
    BuildContext context, {
    required String label,
    required double value,
    required void Function(double) onChanged,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 1.5.h),
      padding: EdgeInsets.symmetric(
        horizontal: 3.w,
        vertical: 1.5.h,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: GoogleFonts.inter().fontFamily,
              fontSize: 14.sp,
              color: AppColors.textGradientColors,
            ),
          ),
          SizedBox(height: 1.h),
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 20,
              activeTrackColor: AppColors.textGradientColors,
              inactiveTrackColor: Colors.grey.shade300,
              thumbShape: SliderComponentShape.noThumb,
              overlayShape: SliderComponentShape.noOverlay,
            ),
            child: Slider(
              value: value,
              min: 0.0,
              max: 100.0,
              divisions: 100,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
