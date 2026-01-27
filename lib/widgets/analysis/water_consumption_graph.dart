import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/controllers/graph_controller.dart';
import 'package:water_saver/utils/l10n/app_localizations.dart';
import 'package:water_saver/utils/theme/app_themes.dart';
import 'package:water_saver/models/graph_page_model.dart';

class WaterConsumptionGraph extends StatelessWidget {
  final GraphController controller;
  final GraphPageModel pageData;
  const WaterConsumptionGraph(
      {super.key, required this.pageData, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: Container(
        padding: EdgeInsets.all(
          4.w,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.waterConsumption,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textGradientColors,
              ),
            ),
            SizedBox(height: 2.h),
            _buildFlLineChart(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFlLineChart(BuildContext context) {
    return SizedBox(
        height: 35.h, child: BarChart(waterConsumptionBarChartData(context)));
  }

  BarChartData waterConsumptionBarChartData(BuildContext context) =>
      BarChartData(
        minY: 0, barGroups: controller.getWaterConsumptionBars(),
        titlesData: waterConsumptionTitlesData(context),

        // gridData: FlGridData(show: true),
      );

  FlTitlesData waterConsumptionTitlesData(BuildContext context) => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: motorBottomTitles(context),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        // leftTitles: AxisTitles(
        //   sideTitles: motorLeftTitles,
        // ),
      );

  SideTitles get motorLeftTitles => SideTitles(
        getTitlesWidget: (double value, TitleMeta meta) {
          const style = TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: 12,
          );
          // Display water level/consumption values
          String text = value.toInt().toString();
          return Text(text, style: style, textAlign: TextAlign.center);
        },
        showTitles: true,
        interval: 10000000, // Adjust based on your data range
        reservedSize: 45,
      );

  SideTitles motorBottomTitles(BuildContext context) => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: _getBottomTitleInterval(),
        getTitlesWidget: (double value, TitleMeta meta) {
          const style = TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: 12,
          );

          String text = _getBottomTitleText(context, value);
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(text, style: style),
          );
        },
      );

  double _getBottomTitleInterval() {
    switch (pageData.selectedPeriod) {
      case SelectedPeriod.week:
        return 1;
      case SelectedPeriod.fifteenDays:
        return 3;
      case SelectedPeriod.month:
        return 5;
    }
  }

  String _getBottomTitleText(BuildContext context, double value) {
    switch (pageData.selectedPeriod) {
      case SelectedPeriod.week:
        return _getDayLabel(context, value);
      case SelectedPeriod.fifteenDays:
        return '${value.toInt()}';
      case SelectedPeriod.month:
        return value % 2 != 0 ? "" : '${value.toInt()}';
    }
  }

  String _getDayLabel(BuildContext context, double x) {
    final localizations = AppLocalizations.of(context)!;
    final weekdayLabels = [
      localizations.monday,
      localizations.tuesday,
      localizations.wednesday,
      localizations.thursday,
      localizations.friday,
      localizations.saturday,
      localizations.sunday,
    ];

    List<String> days = List.generate(7, (index) {
      final date = DateTime.now().subtract(Duration(days: 6 - index));
      return weekdayLabels[date.weekday - 1];
    });

    int dayIndex = (x.toInt()).clamp(0, 6);
    return days[dayIndex];
  }
}
