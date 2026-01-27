import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:water_saver/utils/l10n/app_localizations.dart';
import 'package:water_saver/utils/theme/app_themes.dart';

class InsightsWidget extends StatelessWidget {
  final int buckets;
  final int washingMachines;

  const InsightsWidget({
    super.key,
    required this.buckets,
    required this.washingMachines,
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
                EdgeInsets.symmetric(vertical: constraints.maxHeight * 0.08),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth * 0.05),
                  child: Text(
                    AppLocalizations.of(context)!.insights,
                    style: TextStyle(
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textGradientColors,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: constraints.maxHeight * 0.01),
                  child: Container(
                    width: constraints.maxWidth * 0.87,
                    padding: EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth * 0.02,
                        vertical: constraints.maxHeight * 0.05),
                    margin: EdgeInsets.symmetric(
                        vertical: constraints.maxHeight * 0.02),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(constraints.maxWidth * 0.03),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(
                            Icons.format_color_fill,
                            size: constraints.maxWidth * 0.06,
                          ),
                        ),
                        SizedBox(width: constraints.maxWidth * 0.04),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.enoughFor,
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context)!
                                  .bucketsCount(buckets),
                              style: TextStyle(
                                fontFamily: GoogleFonts.inter().fontFamily,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textGradientColors,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: constraints.maxHeight * 0.01),
                  child: Container(
                    width: constraints.maxWidth * 0.87,
                    padding: EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth * 0.02,
                        vertical: constraints.maxHeight * 0.05),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(3.w),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(
                            Icons.local_laundry_service,
                            size: constraints.maxWidth * 0.06,
                          ),
                        ),
                        SizedBox(width: constraints.maxWidth * 0.04),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.enoughFor,
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context)!
                                  .washingMachinesCount(washingMachines),
                              style: TextStyle(
                                fontFamily: GoogleFonts.inter().fontFamily,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textGradientColors,
                              ),
                            ),
                          ],
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
    });
  }
}
