import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/controllers/graph_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:water_saver/utils/l10n/app_localizations.dart';
import 'package:water_saver/utils/theme/app_themes.dart';
import 'package:water_saver/models/graph_page_model.dart';

class ThresholdHistoryGraph extends StatelessWidget {
  final GraphController controller;
  final GraphPageModel pageData;

  const ThresholdHistoryGraph({
    super.key,
    required this.controller,
    required this.pageData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).cardColor,
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
              AppLocalizations.of(context)!.upperLowerThreshold,
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
      height: 35.h,
      child: LineChart(
        motorStateLineChartData(context),
        duration: const Duration(milliseconds: 250),
      ),
    );
  }

  LineChartData motorStateLineChartData(BuildContext context) => LineChartData(
        lineTouchData: motorLineTouchData(context),
        gridData: motorGridData,
        titlesData: motorTitlesData(context),
        borderData: motorBorderData,
        lineBarsData: motorLineBarsData,
        backgroundColor: Colors.transparent,
        minX: 0,
        maxX: _getMaxX(),
        maxY: 101,
        minY: 0,
      );

  LineTouchData motorLineTouchData(BuildContext context) => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) =>
              Colors.blueGrey.withValues(alpha: 0.8),
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            return touchedBarSpots.map((barSpot) {
              final isLowerThreshold = barSpot.barIndex == 0;
              final status = isLowerThreshold
                  ? AppLocalizations.of(context)!.lowerThreshold
                  : AppLocalizations.of(context)!.upperThreshold;

              return LineTooltipItem(
                '$status\n${barSpot.x}, ${barSpot.y}',
                const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              );
            }).toList();
          },
        ),
      );

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

  FlTitlesData motorTitlesData(BuildContext context) => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: thresholdBottomTitles(context),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: thresholdLeftTitles,
        ),
      );

  SideTitles get thresholdLeftTitles => SideTitles(
        getTitlesWidget: (double value, TitleMeta meta) {
          TextStyle style = TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textGradientColors,
            fontSize: 12,
          );
          String text = '${value.toInt()}';

          return Text(text == '101' ? '' : text,
              style: style, textAlign: TextAlign.center);
        },
        showTitles: true,
        interval: 25,
        reservedSize: 45,
      );

  SideTitles thresholdBottomTitles(BuildContext context) => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: _getBottomTitleInterval(),
        getTitlesWidget: (double value, TitleMeta meta) {
          TextStyle style = TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textGradientColors,
            fontSize: 12,
          );

          String text = _getBottomTitleText(context, value);
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(text, style: style),
          );
        },
      );

  FlGridData get motorGridData => FlGridData(
        show: true,
        horizontalInterval: 25,
        drawHorizontalLine: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            dashArray: [3, 3],
            color: AppColors.textGradientColors,
            strokeWidth: 2,
          );
        },
      );

  FlBorderData get motorBorderData => FlBorderData(
        show: false,
      );
  List<LineChartBarData> get motorLineBarsData => [
        LineChartBarData(
          isCurved: false,
          color: Colors.green,
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) {
              return FlDotCirclePainter(
                radius: 6,
                color: Colors.green,
                strokeWidth: 2,
                strokeColor: Colors.white,
              );
            },
          ),
          belowBarData: BarAreaData(show: false),
          spots: controller.returnFlSpotFromRFTLowerThreshold(),
        ),
        LineChartBarData(
          isCurved: false,
          color: Colors.red,
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) {
              return FlDotCirclePainter(
                radius: 6,
                color: Colors.red,
                strokeWidth: 2,
                strokeColor: Colors.white,
              );
            },
          ),
          belowBarData: BarAreaData(show: false),
          spots: controller.returnFlSpotFromRFTUpperThreshold(),
        ),
      ];
  double _getMaxX() {
    switch (pageData.selectedPeriod) {
      case SelectedPeriod.week:
        return 6;
      case SelectedPeriod.fifteenDays:
        return 14;
      case SelectedPeriod.month:
        return 29;
    }
  }

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
        return '${value.toInt()}';
    }
  }
}
