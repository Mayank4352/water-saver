import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/controllers/app_user_controller.dart';
import 'package:water_saver/models/app_user.dart';
import 'package:water_saver/providers/app_user_controller_provider.dart';
import 'package:water_saver/models/user_data_upload.dart';
import 'package:water_saver/theme/app_themes.dart';
import 'package:water_saver/widgets/home_page/tank_widget.dart';
import 'package:water_saver/widgets/home_page/motor_controls.dart';
import 'package:water_saver/widgets/home_page/insights.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  Timer? _timer;
  bool _isAutoMode = true;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _initAutoMode();
  }

  Future<void> _initAutoMode() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final controller = ref.read(appUserControllerProvider.notifier);
      final v = await controller.getAutoMode();
      if (mounted) setState(() => _isAutoMode = v);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startDataAnimation(List<int> rftData, List<int> rsvData) {
    _timer?.cancel();
    _currentIndex = 0;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _currentIndex++;
      if (_currentIndex >= rftData.length) {
        // Stop after one complete cycle
        timer.cancel();
        _currentIndex = rftData.length - 1; // Keep at last valid index
      }
      if (mounted) {
        setState(() {}); // Trigger rebuild with new index
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appUserController = ref.watch(appUserControllerProvider.notifier);

    final appUser = ref.watch(appUserControllerProvider);

    return appUser.when(
        data: (appUser) => buildHomeBody(appUser, appUserController),
        error: (error, stackTrace) => Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Text(
                  'Error: $error',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
        loading: () => Scaffold(
              backgroundColor: Colors.transparent,
              body: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ));
  }

  Widget buildHomeBody(AppUser appUser, AppUserController appUserController) {
    final messenger = ScaffoldMessenger.of(context);
    final int tank = int.parse(appUser.userDataReceive.rftHeight);
    final List<int> rftData = appUser.userDataUpload.rftLevelData;
    final List<int> rsvData = appUser.userDataUpload.rsvLevelData;

    if (_timer == null || !_timer!.isActive) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _startDataAnimation(rftData, rsvData);
      });
    }
    final int currentTankLevel = rftData.isNotEmpty
        ? rftData[_currentIndex.clamp(0, rftData.length - 1)]
        : 0;
    double fillPercentage =
        (tank > 0) ? ((currentTankLevel / tank) * 100).clamp(0.0, 100.0) : 0.0;
    double waterLevel = currentTankLevel / 100.0;
    int volume = ((currentTankLevel / tank) * 492).round();
    int buckets = (volume / 2).floor();
    int washingMachines = (volume / 20).floor();

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(
              // fontSize: 14.sp,
              color: AppColors.textGradientColors,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 24.h,
            width: double.infinity,
            child: WaterTankWidget(
              fillPercentage: fillPercentage,
              waterLevel: waterLevel,
              tankHeight: tank / 100.0,
              volume: volume,
              isMotorOn: appUser.userDataUpload.motorOn == "yes",
            ),
          ),
          SizedBox(
            height: 24.h,
            child: MotorControlsWidget(
              isMotorOn: appUser.userDataUpload.motorOn == "yes",
              isAutoMode: _isAutoMode,
              onMotorToggle: () async {
                if (_isAutoMode) {
                  await showDialog<void>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      backgroundColor: const Color(0xFF0F1C2E),
                      title: const Text('Not Allowed',
                          style: TextStyle(color: Colors.white)),
                      content: const Text(
                          'This action cannot be performed in Mannual mode.',
                          style: TextStyle(color: Color(0xFFE2E8F0))),
                      actions: [
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFF4ADE80),
                          ),
                          onPressed: () => Navigator.of(ctx).pop(),
                          child: const Text('Ok'),
                        ),
                      ],
                    ),
                  );
                  return;
                }

                final motorLimit = appUser.userDataUpload.motorOn != 'yes';
                if (motorLimit) {
                  final allowed =
                      await appUserController.canTurnMotorOn(appUser);
                  if (!allowed) {
                    if (!mounted) return;
                    messenger.showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Manual ON limit reached (3 times/24h). Try later.'),
                      ),
                    );
                    return;
                  }
                }

                await appUserController.updateMotorState(
                  motorLimit,
                  source: MotorState.manual,
                );
              },
              onAutoToggle: () async {
                if (_isAutoMode) {
                  final consentGiven =
                      appUser.userDataReceive.autoToggleConsent == true;
                  if (!consentGiven) {
                    final gotConsent = await _showConsentDialog(
                        context, appUser.userProfile.name);
                    if (gotConsent == true) {
                      await appUserController.acceptAutoToggleConsent();
                    } else {
                      return;
                    }
                  }
                  if (!mounted) return;
                  final confirm = await _confirmAutoOff(context);
                  if (confirm == true) {
                    await appUserController.setAutoMode(false);
                    if (!mounted) return;
                    messenger.showSnackBar(
                      const SnackBar(content: Text('Auto Mode turned OFF')),
                    );
                    setState(() => _isAutoMode = false);
                  }
                } else {
                  await appUserController.setAutoMode(true);
                  if (!mounted) return;
                  messenger.showSnackBar(
                    const SnackBar(content: Text('Auto Mode turned ON')),
                  );
                  setState(() => _isAutoMode = true);
                }
              },
              onMotorButtonPressed: () async {},
            ),
          ),
          SizedBox(
            height: 27.h,
            child: InsightsWidget(
              buckets: buckets,
              washingMachines: washingMachines,
            ),
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }

  Future<bool?> _showConsentDialog(
      BuildContext context, String userName) async {
    bool checked = false;
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return StatefulBuilder(builder: (ctx, setState) {
          return AlertDialog(
            backgroundColor: const Color(0xFF0F1C2E),
            title: const Text('Warning', style: TextStyle(color: Colors.white)),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "You're trying to disable Auto mode which may degrade performance and can damage components.\nWe suggest adjusting thresholds in the Adjustments page.",
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: checked,
                        onChanged: (v) => setState(() => checked = v ?? false),
                        activeColor: const Color(0xFF4ADE80),
                        side: const BorderSide(color: Colors.white),
                      ),
                      Expanded(
                        child: Text(
                          'I ($userName) will take responsibility for any damages from turning Auto mode off.',
                          style: const TextStyle(color: Color(0xFFEF4444)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF4ADE80),
                ),
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFFEF4444),
                ),
                onPressed: checked ? () => Navigator.of(ctx).pop(true) : null,
                child: const Text('Save'),
              ),
            ],
          );
        });
      },
    );
  }

  Future<bool?> _confirmAutoOff(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF0F1C2E),
        title: const Text('Confirm', style: TextStyle(color: Colors.white)),
        content: const Text('Do you really want to turn Auto Mode off?',
            style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF4ADE80),
            ),
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFEF4444),
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
