// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'जल सेवर';

  @override
  String get welcome => 'स्वागत है';

  @override
  String get login => 'लॉगिन';

  @override
  String get logout => 'लॉगआउट';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get home => 'होम';

  @override
  String get profile => 'प्रोफ़ाइल';

  @override
  String get personalInfo => 'व्यक्तिगत जानकारी';

  @override
  String get wifiConfig => 'WiFi कॉन्फ़िगरेशन';

  @override
  String get calibration => 'कैलिब्रेशन';

  @override
  String get onboarding => 'ऑनबोर्डिंग';

  @override
  String get save => 'सहेजें';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get loading => 'लोड हो रहा है...';

  @override
  String get error => 'त्रुटि';

  @override
  String get success => 'सफल';

  @override
  String get letsGetStarted => 'चलिए शुरू करते हैं!';

  @override
  String get letsDiveIn => 'चलिए आपके खाते में प्रवेश करें';

  @override
  String get privacyPolicy => 'गोपनीयता नीति  ·  सेवा की शर्तें';

  @override
  String get userDoesNotExist => 'उपयोगकर्ता मौजूद नहीं है';

  @override
  String get loginFailed => 'लॉगिन विफल रहा';

  @override
  String get adjustments => 'समायोजन';

  @override
  String get fillRequiredDetails => 'कृपया नीचे आवश्यक विवरण भरें';

  @override
  String get roofTopTank => 'छत की टंकी';

  @override
  String get reservoir => 'जलाशय';

  @override
  String get analysis => 'विश्लेषण';

  @override
  String errorWithMessage(String message) {
    return 'त्रुटि: $message';
  }

  @override
  String get calibrationMessage =>
      'सिस्टम को निष्क्रिय रखें। हम आपकी टंकी को कैलिब्रेट कर रहे हैं...\nइसमें कुछ समय लग सकता है।';

  @override
  String get skip => 'छोड़ें';

  @override
  String get continueButton => 'जारी रखें';

  @override
  String someErrorOccurred(String error) {
    return 'कुछ त्रुटि हुई $error';
  }

  @override
  String get notProvided => 'प्रदान नहीं किया गया';

  @override
  String get configureWiFiNetwork => 'WiFi नेटवर्क कॉन्फ़िगर करें';

  @override
  String get initializingUserData => 'उपयोगकर्ता डेटा प्रारंभ हो रहा है...';

  @override
  String get autoMode => 'ऑटो मोड';

  @override
  String get manualMode => 'मैनुअल मोड';

  @override
  String deviceConnected(String bssid) {
    return 'डिवाइस $bssid Wi-Fi से कनेक्ट हो गया है';
  }

  @override
  String get ok => 'ठीक है';

  @override
  String get confirm => 'पुष्टि करें';

  @override
  String get yes => 'हाँ';

  @override
  String get no => 'नहीं';

  @override
  String get name => 'नाम';

  @override
  String get surname => 'उपनाम';

  @override
  String get phone => 'फ़ोन';

  @override
  String get address => 'पता';

  @override
  String get state => 'राज्य';

  @override
  String get country => 'देश';

  @override
  String get pinCode => 'पिन कोड';

  @override
  String get deviceInformation => 'डिवाइस जानकारी';

  @override
  String get dateOfPurchase => 'खरीद की तारीख';

  @override
  String get noEmailProvided => 'ईमेल प्रदान नहीं किया गया';

  @override
  String get retryButton => 'पुनः प्रयास करें';

  @override
  String get savingUnsuccessful => 'सहेजना असफल रहा';

  @override
  String get savingSuccessful => 'सफलतापूर्वक सहेजा गया!';

  @override
  String get notAllowed => 'अनुमति नहीं है';

  @override
  String get cannotPerformInManualMode =>
      'यह क्रिया मैनुअल मोड में नहीं की जा सकती।';

  @override
  String get manualOnLimitReached =>
      'मैनुअल ON सीमा पहुँच गई (3 बार/24 घंटे)। बाद में प्रयास करें।';

  @override
  String get autoModeTurnedOff => 'ऑटो मोड बंद हो गया';

  @override
  String get autoModeTurnedOn => 'ऑटो मोड चालू हो गया';

  @override
  String get warning => 'चेतावनी';

  @override
  String get autoModeDisableWarning =>
      'आप ऑटो मोड को अक्षम करने का प्रयास कर रहे हैं जो प्रदर्शन को खराब कर सकता है और घटकों को नुकसान पहुंचा सकता है।\nहम समायोजन पृष्ठ में सीमा को समायोजित करने का सुझाव देते हैं।';

  @override
  String autoModeResponsibility(String userName) {
    return 'मैं ($userName) ऑटो मोड बंद करने से होने वाले किसी भी नुकसान की जिम्मेदारी लूंगा/लूंगी।';
  }

  @override
  String get confirmAutoModeOff => 'क्या आप वाकई ऑटो मोड बंद करना चाहते हैं?';

  @override
  String get personalInfoMenu => 'व्यक्तिगत जानकारी';

  @override
  String get reminders => 'रिमाइंडर';

  @override
  String get setWiFiNetwork => 'WiFi नेटवर्क सेट करें';

  @override
  String get accountSecurity => 'खाता और सुरक्षा';

  @override
  String get linkedAccounts => 'लिंक किए गए खाते';

  @override
  String get dataAnalytics => 'डेटा और विश्लेषण';

  @override
  String get helpSupport => 'सहायता और समर्थन';

  @override
  String get logoutFailed => 'लॉगआउट विफल रहा';

  @override
  String get wifiNetworkDetails => 'Wi-Fi नेटवर्क विवरण';

  @override
  String networkName(String name) {
    return 'नाम: $name';
  }

  @override
  String bssidLabel(String bssid) {
    return 'BSSID: $bssid';
  }

  @override
  String get unknown => 'अज्ञात';

  @override
  String get enterWifiPassword => 'Wi-Fi पासवर्ड दर्ज करें';

  @override
  String get enterPassword => 'पासवर्ड दर्ज करें';

  @override
  String get passwordTooShort => 'पासवर्ड कम से कम 8 अक्षर लंबा होना चाहिए';

  @override
  String get configuringDevice => 'डिवाइस को कॉन्फ़िगर किया जा रहा है...';

  @override
  String get pleaseEnterPassword => 'कृपया Wi-Fi पासवर्ड दर्ज करें';

  @override
  String get configureDevice => 'डिवाइस कॉन्फ़िगर करें';

  @override
  String get goToHome => 'होम पर जाएं';

  @override
  String get locationPermissionRequired => 'स्थान अनुमति आवश्यक';

  @override
  String get locationPermissionMessage =>
      'आपके डिवाइस के लिए Wi-Fi नेटवर्क को कॉन्फ़िगर करने के लिए, हमें सटीक स्थान अनुमति की आवश्यकता है।';

  @override
  String get openSettings => 'सेटिंग्स खोलें';

  @override
  String get wifiTurnedOff => 'Wi-Fi बंद है';

  @override
  String get turnOnWifiMessage =>
      'कृपया अपने डिवाइस को कॉन्फ़िगर करने के लिए Wi-Fi चालू करें।';

  @override
  String get motorOffThreshold => 'स्तर सीमा: मोटर बंद';

  @override
  String get motorOnThreshold => 'स्तर सीमा: मोटर चालू';

  @override
  String get thresholdValidation =>
      'मोटर बंद सीमा मोटर चालू सीमा से अधिक होनी चाहिए';

  @override
  String get pumpOnOffNormally => 'पंप सामान्य रूप से चालू और बंद';

  @override
  String get powerFailureDuringPumpOn => 'पंप चालू के दौरान बिजली की विफलता';

  @override
  String get pumpCurrentlyOn => 'वर्तमान में पंप चालू है';

  @override
  String get pumpActivity => 'पंप गतिविधि';

  @override
  String get motorOn => 'मोटर चालू';

  @override
  String get motorOff => 'मोटर बंद';

  @override
  String get monday => 'सोम';

  @override
  String get tuesday => 'मंगल';

  @override
  String get wednesday => 'बुध';

  @override
  String get thursday => 'गुरु';

  @override
  String get friday => 'शुक्र';

  @override
  String get saturday => 'शनि';

  @override
  String get sunday => 'रवि';

  @override
  String get upperLowerThreshold => 'ऊपरी और निचली सीमा';

  @override
  String get lowerThreshold => 'निचली सीमा';

  @override
  String get upperThreshold => 'ऊपरी सीमा';

  @override
  String get waterConsumption => 'पानी की खपत';

  @override
  String get insights => 'जानकारी';

  @override
  String get enoughFor => 'के लिए पर्याप्त';

  @override
  String bucketsCount(int count) {
    return '$count 2L-बाल्टियाँ';
  }

  @override
  String washingMachinesCount(int count) {
    return '$count वॉशिंग मशीनें';
  }

  @override
  String get waterControls => 'जल नियंत्रण';

  @override
  String get motor => 'मोटर';

  @override
  String get volume => 'आयतन';

  @override
  String get fromTheBottom => 'तल से';

  @override
  String get filled => 'भरा हुआ';
}
