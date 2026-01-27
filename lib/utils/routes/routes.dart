import 'package:go_router/go_router.dart';
import 'package:water_saver/screens/calibration.dart';
import 'package:water_saver/screens/login_screen.dart';
import 'package:water_saver/screens/onboarding_screens.dart';
import 'package:water_saver/screens/personal_info.dart';
import 'package:water_saver/screens/settings.dart';
import 'package:water_saver/screens/splash.dart';
import 'package:water_saver/screens/wifi_config.dart';
import 'package:water_saver/widgets/nav_bar.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const BottomNavBar(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreens(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: '/calibration',
      builder: (context, state) => const CalibrationScreen(),
    ),
    GoRoute(
      path: '/wifiConfig',
      builder: (context, state) => const WifiConfigScreen(),
    ),
    GoRoute(
      path: '/personalInfo',
      builder: (context, state) => const PersonalInfoScreen(),
    ),
  ],
);
