import 'dart:async';
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/models/firebase_model.dart';
import 'package:water_saver/utils/l10n/app_localizations.dart';

class CalibrationScreen extends StatefulWidget {
  const CalibrationScreen({super.key});

  @override
  State<CalibrationScreen> createState() => _CalibrationScreenState();
}

class _CalibrationScreenState extends State<CalibrationScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  StreamSubscription<DocumentSnapshot>? _sub;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _listenForCalibration();
  }

  Future<void> _listenForCalibration() async {
    final storage = GetIt.I<FlutterSecureStorage>();
    final deviceId = await storage.read(key: 'deviceId') ?? '';

    if (deviceId.isEmpty) return;

    _sub = FBCollections.userDataUpload
        .doc(deviceId)
        .snapshots()
        .listen((snapshot) async {
      final raw = snapshot.data();
      final data = raw is Map<String, dynamic> ? raw : <String, dynamic>{};
      final calibDone = (data['CALIB_DONE'] ?? 'no').toString();
      if (calibDone.toLowerCase() == 'yes') {
        final isOnboardingComplete = bool.parse(
            (await storage.read(key: 'isOnboardingComplete')) ?? 'false');
        if (!mounted) return;
        if (isOnboardingComplete) {
          context.go('/home');
        } else {
          context.go('/onboarding');
        }
      }
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bg = const Color(0xFF071526);
    final blue = const Color(0xFF1E40AF);
    final water = const Color(0xFF2196F3);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          AppLocalizations.of(context)!.calibration,
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _AnimatedTank(
                  controller: _controller, waterColor: water, rimColor: blue),
              SizedBox(height: 4.h),
              Text(
                AppLocalizations.of(context)!.calibrationMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70),
              ),
              SizedBox(height: 3.h),
              const CircularProgressIndicator(color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedTank extends StatelessWidget {
  final AnimationController controller;
  final Color waterColor;
  final Color rimColor;

  const _AnimatedTank({
    required this.controller,
    required this.waterColor,
    required this.rimColor,
  });

  @override
  Widget build(BuildContext context) {
    final width = 55.w;
    final height = 35.h;

    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(color: rimColor.withValues(alpha: 0.2)),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: height * 0.5,
                width: double.infinity,
                color: waterColor.withValues(alpha: 0.7),
              ),
            ),
            AnimatedBuilder(
              animation: controller,
              builder: (context, _) {
                final t = controller.value;
                final center = height * 0.55;
                final amp = height * 0.12;
                final y = center + amp * math.sin(2 * math.pi * t);

                return CustomPaint(
                  size: Size(width, height),
                  painter: _LinePainter(y: y),
                );
              },
            ),
            IgnorePointer(
              ignoring: true,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: rimColor, width: 2),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LinePainter extends CustomPainter {
  final double y;
  _LinePainter({required this.y});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
  }

  @override
  bool shouldRepaint(covariant _LinePainter oldDelegate) => oldDelegate.y != y;
}
