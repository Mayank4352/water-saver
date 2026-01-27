import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/controllers/graph_controller.dart';
import 'package:water_saver/utils/theme/app_themes.dart';
import 'package:water_saver/models/graph_page_model.dart';
import 'package:water_saver/providers/graph_controller_provider.dart';
import 'package:water_saver/widgets/analysis/motor_graph.dart';
import 'package:water_saver/widgets/analysis/threshold_history_graph.dart';
import 'package:water_saver/widgets/analysis/water_consumption_graph.dart';
import 'package:water_saver/widgets/analysis/graph_legend.dart';
import 'package:water_saver/controllers/graph_period_controller.dart';
import 'package:water_saver/utils/l10n/app_localizations.dart';

class AnalysisPage extends ConsumerWidget {
  const AnalysisPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(graphControllerProvider.notifier);
    final pageData = ref.watch(graphControllerProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          AppLocalizations.of(context)!.analysis,
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
      body: pageData.when(
        data: (data) => buildReportBody(controller, data),
        error: (error, stackTrace) => Center(
            child: Text(AppLocalizations.of(context)!
                .errorWithMessage(error.toString()))),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget buildReportBody(GraphController controller, GraphPageModel pageData) {
    return Builder(builder: (context) {
      return SingleChildScrollView(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GraphPeriodControllerWidget(
              controller: controller,
              pageData: pageData,
            ),
            MotorStateGraph(
              controller: controller,
              pageData: pageData,
            ),
            WaterConsumptionGraph(
              controller: controller,
              pageData: pageData,
            ),
            ThresholdHistoryGraph(controller: controller, pageData: pageData),
            GraphLegendWidget(),
          ],
        ),
      );
    });
  }
}
