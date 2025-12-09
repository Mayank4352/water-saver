import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/theme/app_themes.dart';
import 'package:water_saver/widgets/home_page/water_tank.dart';

class WaterTankWidget extends StatefulWidget {
  final double fillPercentage;
  final double waterLevel;
  final double tankHeight;
  final int volume;
  final bool isMotorOn;

  const WaterTankWidget({
    super.key,
    required this.fillPercentage,
    required this.waterLevel,
    required this.tankHeight,
    required this.volume,
    this.isMotorOn = false,
  });

  @override
  State<WaterTankWidget> createState() => _WaterTankWidgetState();
}

class _WaterTankWidgetState extends State<WaterTankWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _bubbleController;
  final List<Bubble> _bubbles = [];
  final Random _random = Random();
  bool _shouldGenerateBubbles = false;

  @override
  void initState() {
    super.initState();
    _bubbleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
    )..addListener(_updateBubbles);

    if (widget.isMotorOn) {
      _shouldGenerateBubbles = true;
      _bubbleController.repeat();
    }
  }

  @override
  void didUpdateWidget(WaterTankWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isMotorOn && !oldWidget.isMotorOn) {
      _shouldGenerateBubbles = true;
      _bubbleController.repeat();
    } else if (!widget.isMotorOn && oldWidget.isMotorOn) {
      _shouldGenerateBubbles = false;
    }
  }

  void _updateBubbles() {
    if (!_shouldGenerateBubbles && _bubbles.isEmpty) {
      _bubbleController.stop();
      return;
    }
    if (_shouldGenerateBubbles && _random.nextDouble() < 0.028) {
      _bubbles.add(Bubble(
        x: _random.nextDouble() * 0.7 + 0.15,
        y: 1.0,
        size: _random.nextDouble() * 4,
        speed: _random.nextDouble() * 0.01,
        opacity: _random.nextDouble() * 0.3 + 0.6,
      ));
    }
    for (var bubble in _bubbles) {
      bubble.y -= bubble.speed;
      bubble.size += (_random.nextDouble() - 0.5) * 0.1;
      bubble.size = bubble.size.clamp(3.0, 14.0);
    }
    final waterSurface = 1 - (widget.fillPercentage / 100);
    _bubbles.removeWhere((b) => b.y < waterSurface + 0.02);
  }

  @override
  void dispose() {
    _bubbleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.05),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '${widget.volume} L',
                        style: TextStyle(
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textGradientColors,
                        ),
                      ),
                      Text(
                        'volume',
                        style: TextStyle(
                            fontSize: 14.sp,
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        '${widget.waterLevel.toStringAsFixed(1)} m',
                        style: TextStyle(
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textGradientColors,
                        ),
                      ),
                      Text(
                        'from the bottom',
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w900),
                      ),
                      Text(
                        '${widget.fillPercentage.toStringAsFixed(0)}%',
                        style: TextStyle(
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textGradientColors,
                        ),
                      ),
                      Text(
                        'filled',
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(constraints.maxHeight * 0.02),
                  child: SizedBox(
                    width: constraints.maxWidth * 0.4,
                    height: constraints.maxHeight * 0.9,
                    child: AnimatedBuilder(
                      animation: _bubbleController,
                      builder: (context, child) {
                        return Water3DWaveWidget(
                          fillPercentage: widget.fillPercentage / 100,
                          size: Size(
                            constraints.maxWidth * 0.4,
                            constraints.maxHeight * 0.9,
                          ),
                          bubbles: _bubbles,
                          isMotorOn: widget.isMotorOn,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
