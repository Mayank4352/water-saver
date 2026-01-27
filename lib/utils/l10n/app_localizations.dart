import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi')
  ];

  /// The application title
  ///
  /// In en, this message translates to:
  /// **'Water Saver'**
  String get appTitle;

  /// Welcome message
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// Login button text
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Logout button text
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Settings page title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Home page title
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Profile page title
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Personal information page title
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInfo;

  /// WiFi configuration page title
  ///
  /// In en, this message translates to:
  /// **'WiFi Configuration'**
  String get wifiConfig;

  /// Calibration page title
  ///
  /// In en, this message translates to:
  /// **'Calibration'**
  String get calibration;

  /// Onboarding page title
  ///
  /// In en, this message translates to:
  /// **'Onboarding'**
  String get onboarding;

  /// Save button text
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Loading indicator text
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Error message
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Success message
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// Login screen title
  ///
  /// In en, this message translates to:
  /// **'Let\'s Get Started!'**
  String get letsGetStarted;

  /// Login screen subtitle
  ///
  /// In en, this message translates to:
  /// **'Let\'s dive in into your account'**
  String get letsDiveIn;

  /// Privacy policy text
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy  ·  Terms of Service'**
  String get privacyPolicy;

  /// Error when user not found
  ///
  /// In en, this message translates to:
  /// **'User does not exist'**
  String get userDoesNotExist;

  /// Login failure message
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get loginFailed;

  /// Adjustments page title
  ///
  /// In en, this message translates to:
  /// **'Adjustments'**
  String get adjustments;

  /// Instruction text
  ///
  /// In en, this message translates to:
  /// **'Kindly fill the required details below'**
  String get fillRequiredDetails;

  /// Tank name
  ///
  /// In en, this message translates to:
  /// **'Roof Top Tank'**
  String get roofTopTank;

  /// Reservoir name
  ///
  /// In en, this message translates to:
  /// **'Reservoir'**
  String get reservoir;

  /// Analysis page title
  ///
  /// In en, this message translates to:
  /// **'Analysis'**
  String get analysis;

  /// Error with dynamic message
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String errorWithMessage(String message);

  /// Calibration instruction message
  ///
  /// In en, this message translates to:
  /// **'Keep the system idle. We are calibrating your tank...\nThis may take a few moments.'**
  String get calibrationMessage;

  /// Skip button
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// Continue button
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// Generic error message
  ///
  /// In en, this message translates to:
  /// **'Some error occurred {error}'**
  String someErrorOccurred(String error);

  /// When data is not available
  ///
  /// In en, this message translates to:
  /// **'Not provided'**
  String get notProvided;

  /// WiFi config page title
  ///
  /// In en, this message translates to:
  /// **'Configure Wi-Fi Network'**
  String get configureWiFiNetwork;

  /// Splash screen loading message
  ///
  /// In en, this message translates to:
  /// **'Initializing user data...'**
  String get initializingUserData;

  /// Auto mode text
  ///
  /// In en, this message translates to:
  /// **'Auto Mode'**
  String get autoMode;

  /// Manual mode text
  ///
  /// In en, this message translates to:
  /// **'Manual Mode'**
  String get manualMode;

  /// Device connected message
  ///
  /// In en, this message translates to:
  /// **'Device {bssid} is connected to the Wi-Fi'**
  String deviceConnected(String bssid);

  /// OK button
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Confirm dialog title
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// Yes button
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No button
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// Name label
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// Surname label
  ///
  /// In en, this message translates to:
  /// **'Surname'**
  String get surname;

  /// Phone label
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// Address label
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// State label
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get state;

  /// Country label
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// Pin code label
  ///
  /// In en, this message translates to:
  /// **'Pin Code'**
  String get pinCode;

  /// Device information section title
  ///
  /// In en, this message translates to:
  /// **'Device Information'**
  String get deviceInformation;

  /// Date of purchase label
  ///
  /// In en, this message translates to:
  /// **'Date of Purchase'**
  String get dateOfPurchase;

  /// When email is not available
  ///
  /// In en, this message translates to:
  /// **'No email provided'**
  String get noEmailProvided;

  /// Retry button
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retryButton;

  /// Saving unsuccessful message
  ///
  /// In en, this message translates to:
  /// **'Saving unsuccessful'**
  String get savingUnsuccessful;

  /// Saving successful message
  ///
  /// In en, this message translates to:
  /// **'Saved Successfully!'**
  String get savingSuccessful;

  /// Not allowed dialog title
  ///
  /// In en, this message translates to:
  /// **'Not Allowed'**
  String get notAllowed;

  /// Manual mode restriction message
  ///
  /// In en, this message translates to:
  /// **'This action cannot be performed in Manual mode.'**
  String get cannotPerformInManualMode;

  /// Motor manual limit message
  ///
  /// In en, this message translates to:
  /// **'Manual ON limit reached (3 times/24h). Try later.'**
  String get manualOnLimitReached;

  /// Auto mode off message
  ///
  /// In en, this message translates to:
  /// **'Auto Mode turned OFF'**
  String get autoModeTurnedOff;

  /// Auto mode on message
  ///
  /// In en, this message translates to:
  /// **'Auto Mode turned ON'**
  String get autoModeTurnedOn;

  /// Warning dialog title
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// Auto mode disable warning message
  ///
  /// In en, this message translates to:
  /// **'You\'re trying to disable Auto mode which may degrade performance and can damage components.\nWe suggest adjusting thresholds in the Adjustments page.'**
  String get autoModeDisableWarning;

  /// Responsibility confirmation text
  ///
  /// In en, this message translates to:
  /// **'I ({userName}) will take responsibility for any damages from turning Auto mode off.'**
  String autoModeResponsibility(String userName);

  /// Confirm auto mode off message
  ///
  /// In en, this message translates to:
  /// **'Do you really want to turn Auto Mode off?'**
  String get confirmAutoModeOff;

  /// Personal info menu item
  ///
  /// In en, this message translates to:
  /// **'Personal Info'**
  String get personalInfoMenu;

  /// Reminders menu item
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get reminders;

  /// Set WiFi network menu item
  ///
  /// In en, this message translates to:
  /// **'Set Wi-Fi Network'**
  String get setWiFiNetwork;

  /// Account and security menu item
  ///
  /// In en, this message translates to:
  /// **'Account & Security'**
  String get accountSecurity;

  /// Linked accounts menu item
  ///
  /// In en, this message translates to:
  /// **'Linked Accounts'**
  String get linkedAccounts;

  /// Data and analytics menu item
  ///
  /// In en, this message translates to:
  /// **'Data & Analytics'**
  String get dataAnalytics;

  /// Help and support menu item
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupport;

  /// Logout failed message
  ///
  /// In en, this message translates to:
  /// **'Logout failed'**
  String get logoutFailed;

  /// WiFi network details header
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi Network Details'**
  String get wifiNetworkDetails;

  /// Network name label
  ///
  /// In en, this message translates to:
  /// **'Name: {name}'**
  String networkName(String name);

  /// BSSID label
  ///
  /// In en, this message translates to:
  /// **'BSSID: {bssid}'**
  String bssidLabel(String bssid);

  /// Unknown value placeholder
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// Enter WiFi password label
  ///
  /// In en, this message translates to:
  /// **'Enter Wi-Fi Password'**
  String get enterWifiPassword;

  /// Enter password hint text
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get enterPassword;

  /// Password length validation message
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters long'**
  String get passwordTooShort;

  /// Configuring device progress message
  ///
  /// In en, this message translates to:
  /// **'Configuring device...'**
  String get configuringDevice;

  /// Empty password validation message
  ///
  /// In en, this message translates to:
  /// **'Please enter Wi-Fi password'**
  String get pleaseEnterPassword;

  /// Configure device button text
  ///
  /// In en, this message translates to:
  /// **'Configure Device'**
  String get configureDevice;

  /// Go to home button text
  ///
  /// In en, this message translates to:
  /// **'Go to Home'**
  String get goToHome;

  /// Location permission required title
  ///
  /// In en, this message translates to:
  /// **'Location Permission Required'**
  String get locationPermissionRequired;

  /// Location permission explanation message
  ///
  /// In en, this message translates to:
  /// **'To configure Wi-Fi networks for your device, we need precise location permission.'**
  String get locationPermissionMessage;

  /// Open settings button text
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get openSettings;

  /// WiFi turned off title
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi is Turned Off'**
  String get wifiTurnedOff;

  /// Turn on WiFi message
  ///
  /// In en, this message translates to:
  /// **'Please turn on Wi-Fi to configure your device.'**
  String get turnOnWifiMessage;

  /// Motor off threshold label
  ///
  /// In en, this message translates to:
  /// **'Level Threshold: Motor Off'**
  String get motorOffThreshold;

  /// Motor on threshold label
  ///
  /// In en, this message translates to:
  /// **'Level Threshold: Motor On'**
  String get motorOnThreshold;

  /// Tank threshold validation error message
  ///
  /// In en, this message translates to:
  /// **'Motor off threshold must be greater than motor on threshold'**
  String get thresholdValidation;

  /// Graph legend for normal pump operation
  ///
  /// In en, this message translates to:
  /// **'Pump On and off normally'**
  String get pumpOnOffNormally;

  /// Graph legend for power failure
  ///
  /// In en, this message translates to:
  /// **'Power failure during Pump: ON'**
  String get powerFailureDuringPumpOn;

  /// Graph legend for current pump state
  ///
  /// In en, this message translates to:
  /// **'At present the Pump is ON'**
  String get pumpCurrentlyOn;

  /// Pump activity graph title
  ///
  /// In en, this message translates to:
  /// **'Pump Activity'**
  String get pumpActivity;

  /// Motor on status
  ///
  /// In en, this message translates to:
  /// **'Motor ON'**
  String get motorOn;

  /// Motor off status
  ///
  /// In en, this message translates to:
  /// **'Motor OFF'**
  String get motorOff;

  /// Monday short label
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get monday;

  /// Tuesday short label
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get tuesday;

  /// Wednesday short label
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get wednesday;

  /// Thursday short label
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get thursday;

  /// Friday short label
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get friday;

  /// Saturday short label
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get saturday;

  /// Sunday short label
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get sunday;

  /// Upper and lower threshold graph title
  ///
  /// In en, this message translates to:
  /// **'Upper and Lower Threshold'**
  String get upperLowerThreshold;

  /// Lower threshold label
  ///
  /// In en, this message translates to:
  /// **'Lower Threshold'**
  String get lowerThreshold;

  /// Upper threshold label
  ///
  /// In en, this message translates to:
  /// **'Upper Threshold'**
  String get upperThreshold;

  /// Water consumption graph title
  ///
  /// In en, this message translates to:
  /// **'Water Consumption'**
  String get waterConsumption;

  /// Insights widget title
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get insights;

  /// Enough for label
  ///
  /// In en, this message translates to:
  /// **'Enough for'**
  String get enoughFor;

  /// Buckets count label
  ///
  /// In en, this message translates to:
  /// **'{count} 2L-buckets'**
  String bucketsCount(int count);

  /// Washing machines count label
  ///
  /// In en, this message translates to:
  /// **'{count} washing machines'**
  String washingMachinesCount(int count);

  /// Water controls widget title
  ///
  /// In en, this message translates to:
  /// **'Water Controls'**
  String get waterControls;

  /// Motor label
  ///
  /// In en, this message translates to:
  /// **'Motor'**
  String get motor;

  /// Volume label
  ///
  /// In en, this message translates to:
  /// **'volume'**
  String get volume;

  /// From the bottom label
  ///
  /// In en, this message translates to:
  /// **'from the bottom'**
  String get fromTheBottom;

  /// Filled label
  ///
  /// In en, this message translates to:
  /// **'filled'**
  String get filled;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
