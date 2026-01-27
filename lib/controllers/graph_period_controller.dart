import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/controllers/graph_controller.dart';
import 'package:water_saver/utils/theme/app_themes.dart';
import 'package:water_saver/models/graph_page_model.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class GraphPeriodControllerWidget extends StatelessWidget {
  const GraphPeriodControllerWidget(
      {super.key, required this.controller, required this.pageData});
  final GraphController controller;
  final GraphPageModel pageData;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: pageData.selectedPeriod.index,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(100)),
        child: IntrinsicWidth(
          child: TabBar(
            tabs: SelectedPeriod.values
                .map((period) => Tab(text: period.label))
                .toList(),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.white,
            unselectedLabelColor: AppColors.textGradientColors,
            indicator: RectangularIndicator(
                color: Theme.of(context).iconTheme.color!,
                paintingStyle: PaintingStyle.fill,
                bottomLeftRadius: 100,
                topLeftRadius: 100,
                bottomRightRadius: 100,
                topRightRadius: 100,
                verticalPadding: 0.5.h,
                horizontalPadding: 1.w),
            onTap: (value) => controller.changeSelectedPeriod(
              SelectedPeriod.values.elementAt(value),
            ),
            dividerColor: Colors.transparent,
            dividerHeight: 0,
          ),
        ),
      ),
    );
  }
}
