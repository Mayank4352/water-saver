import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:onboarding/onboarding.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/utils/l10n/app_localizations.dart';

class OnboardingScreens extends StatelessWidget {
  const OnboardingScreens({super.key});

  void handlePostOnboarding(BuildContext context) async {
    final router = GoRouter.of(context);
    final messenger = ScaffoldMessenger.of(context);
    try {
      await GetIt.I<FlutterSecureStorage>()
          .write(key: "isOnboardingComplete", value: 'true');
    } catch (e) {
      messenger.showSnackBar(SnackBar(
          content: Text(
              AppLocalizations.of(context)!.someErrorOccurred(e.toString()))));
    }
    router.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Onboarding(
      swipeableBody: [
        Image.asset(
          'assets/images/onboarding_screen1.png',
          fit: BoxFit.cover,
        ),
        Image.asset(
          'assets/images/onboarding_screen2.png',
          fit: BoxFit.cover,
        ),
      ],
      startIndex: 0,
      buildFooter: (context, netDragDistance, pagesLength, currentIndex,
              setIndex, slideDirection) =>
          Container(
        height: 16.h,
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: 5.w,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 30.w,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xFFF5FAFF),
                  foregroundColor: const Color(0xFF2196F3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  side: BorderSide.none,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                ),
                onPressed: () async {
                  handlePostOnboarding(context);
                },
                child: Text(
                  AppLocalizations.of(context)!.skip,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Indicator<TrianglePainter>(
              painter: TrianglePainter(
                  currentPageIndex: currentIndex,
                  pagesLength: pagesLength,
                  netDragPercent: netDragDistance,
                  slideDirection: slideDirection,
                  inactivePainter: Paint()
                    ..color = Color.fromARGB(255, 220, 218, 255),
                  activePainter: Paint()
                    ..color = Color.fromARGB(255, 90, 158, 255),
                  width: 10,
                  translate: true,
                  space: 6.9),
            ),
            SizedBox(
              width: 30.w,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF21A5FD),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                ),
                onPressed: () {
                  if (currentIndex == pagesLength - 1) {
                    handlePostOnboarding(context);
                    return;
                  }
                  setIndex(currentIndex + 1);
                },
                child: Text(
                  AppLocalizations.of(context)!.continueButton,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
