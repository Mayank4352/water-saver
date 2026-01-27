// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Water Saver';

  @override
  String get welcome => 'Welcome';

  @override
  String get login => 'Login';

  @override
  String get logout => 'Logout';

  @override
  String get settings => 'Settings';

  @override
  String get home => 'Home';

  @override
  String get profile => 'Profile';

  @override
  String get personalInfo => 'Personal Information';

  @override
  String get wifiConfig => 'WiFi Configuration';

  @override
  String get calibration => 'Calibration';

  @override
  String get onboarding => 'Onboarding';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get loading => 'Loading...';

  @override
  String get error => 'Error';

  @override
  String get success => 'Success';

  @override
  String get letsGetStarted => 'Let\'s Get Started!';

  @override
  String get letsDiveIn => 'Let\'s dive in into your account';

  @override
  String get privacyPolicy => 'Privacy Policy  ·  Terms of Service';

  @override
  String get userDoesNotExist => 'User does not exist';

  @override
  String get loginFailed => 'Login failed';

  @override
  String get adjustments => 'Adjustments';

  @override
  String get fillRequiredDetails => 'Kindly fill the required details below';

  @override
  String get roofTopTank => 'Roof Top Tank';

  @override
  String get reservoir => 'Reservoir';

  @override
  String get analysis => 'Analysis';

  @override
  String errorWithMessage(String message) {
    return 'Error: $message';
  }

  @override
  String get calibrationMessage =>
      'Keep the system idle. We are calibrating your tank...\nThis may take a few moments.';

  @override
  String get skip => 'Skip';

  @override
  String get continueButton => 'Continue';

  @override
  String someErrorOccurred(String error) {
    return 'Some error occurred $error';
  }

  @override
  String get notProvided => 'Not provided';

  @override
  String get configureWiFiNetwork => 'Configure Wi-Fi Network';

  @override
  String get initializingUserData => 'Initializing user data...';

  @override
  String get autoMode => 'Auto Mode';

  @override
  String get manualMode => 'Manual Mode';

  @override
  String deviceConnected(String bssid) {
    return 'Device $bssid is connected to the Wi-Fi';
  }

  @override
  String get ok => 'OK';

  @override
  String get confirm => 'Confirm';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get name => 'Name';

  @override
  String get surname => 'Surname';

  @override
  String get phone => 'Phone';

  @override
  String get address => 'Address';

  @override
  String get state => 'State';

  @override
  String get country => 'Country';

  @override
  String get pinCode => 'Pin Code';

  @override
  String get deviceInformation => 'Device Information';

  @override
  String get dateOfPurchase => 'Date of Purchase';

  @override
  String get noEmailProvided => 'No email provided';

  @override
  String get retryButton => 'Retry';

  @override
  String get savingUnsuccessful => 'Saving unsuccessful';

  @override
  String get savingSuccessful => 'Saved Successfully!';

  @override
  String get notAllowed => 'Not Allowed';

  @override
  String get cannotPerformInManualMode =>
      'This action cannot be performed in Manual mode.';

  @override
  String get manualOnLimitReached =>
      'Manual ON limit reached (3 times/24h). Try later.';

  @override
  String get autoModeTurnedOff => 'Auto Mode turned OFF';

  @override
  String get autoModeTurnedOn => 'Auto Mode turned ON';

  @override
  String get warning => 'Warning';

  @override
  String get autoModeDisableWarning =>
      'You\'re trying to disable Auto mode which may degrade performance and can damage components.\nWe suggest adjusting thresholds in the Adjustments page.';

  @override
  String autoModeResponsibility(String userName) {
    return 'I ($userName) will take responsibility for any damages from turning Auto mode off.';
  }

  @override
  String get confirmAutoModeOff => 'Do you really want to turn Auto Mode off?';

  @override
  String get personalInfoMenu => 'Personal Info';

  @override
  String get reminders => 'Reminders';

  @override
  String get setWiFiNetwork => 'Set Wi-Fi Network';

  @override
  String get accountSecurity => 'Account & Security';

  @override
  String get linkedAccounts => 'Linked Accounts';

  @override
  String get dataAnalytics => 'Data & Analytics';

  @override
  String get helpSupport => 'Help & Support';

  @override
  String get logoutFailed => 'Logout failed';

  @override
  String get wifiNetworkDetails => 'Wi-Fi Network Details';

  @override
  String networkName(String name) {
    return 'Name: $name';
  }

  @override
  String bssidLabel(String bssid) {
    return 'BSSID: $bssid';
  }

  @override
  String get unknown => 'Unknown';

  @override
  String get enterWifiPassword => 'Enter Wi-Fi Password';

  @override
  String get enterPassword => 'Enter password';

  @override
  String get passwordTooShort => 'Password must be at least 8 characters long';

  @override
  String get configuringDevice => 'Configuring device...';

  @override
  String get pleaseEnterPassword => 'Please enter Wi-Fi password';

  @override
  String get configureDevice => 'Configure Device';

  @override
  String get goToHome => 'Go to Home';

  @override
  String get locationPermissionRequired => 'Location Permission Required';

  @override
  String get locationPermissionMessage =>
      'To configure Wi-Fi networks for your device, we need precise location permission.';

  @override
  String get openSettings => 'Open Settings';

  @override
  String get wifiTurnedOff => 'Wi-Fi is Turned Off';

  @override
  String get turnOnWifiMessage =>
      'Please turn on Wi-Fi to configure your device.';

  @override
  String get motorOffThreshold => 'Level Threshold: Motor Off';

  @override
  String get motorOnThreshold => 'Level Threshold: Motor On';

  @override
  String get thresholdValidation =>
      'Motor off threshold must be greater than motor on threshold';

  @override
  String get pumpOnOffNormally => 'Pump On and off normally';

  @override
  String get powerFailureDuringPumpOn => 'Power failure during Pump: ON';

  @override
  String get pumpCurrentlyOn => 'At present the Pump is ON';

  @override
  String get pumpActivity => 'Pump Activity';

  @override
  String get motorOn => 'Motor ON';

  @override
  String get motorOff => 'Motor OFF';

  @override
  String get monday => 'Mon';

  @override
  String get tuesday => 'Tue';

  @override
  String get wednesday => 'Wed';

  @override
  String get thursday => 'Thu';

  @override
  String get friday => 'Fri';

  @override
  String get saturday => 'Sat';

  @override
  String get sunday => 'Sun';

  @override
  String get upperLowerThreshold => 'Upper and Lower Threshold';

  @override
  String get lowerThreshold => 'Lower Threshold';

  @override
  String get upperThreshold => 'Upper Threshold';

  @override
  String get waterConsumption => 'Water Consumption';

  @override
  String get insights => 'Insights';

  @override
  String get enoughFor => 'Enough for';

  @override
  String bucketsCount(int count) {
    return '$count 2L-buckets';
  }

  @override
  String washingMachinesCount(int count) {
    return '$count washing machines';
  }

  @override
  String get waterControls => 'Water Controls';

  @override
  String get motor => 'Motor';

  @override
  String get volume => 'volume';

  @override
  String get fromTheBottom => 'from the bottom';

  @override
  String get filled => 'filled';
}
