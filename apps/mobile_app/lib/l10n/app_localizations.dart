import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_am.dart';
import 'app_localizations_en.dart';

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
    Locale('am'),
    Locale('en')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'CarpoolConnect'**
  String get appTitle;

  /// No description provided for @tagline.
  ///
  /// In en, this message translates to:
  /// **'Let\'s ride together'**
  String get tagline;

  /// No description provided for @signInWithPhone.
  ///
  /// In en, this message translates to:
  /// **'Continue with Phone Number'**
  String get signInWithPhone;

  /// No description provided for @signInWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get signInWithGoogle;

  /// No description provided for @signInWithFacebook.
  ///
  /// In en, this message translates to:
  /// **'Continue with Facebook'**
  String get signInWithFacebook;

  /// No description provided for @tosAgreement.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you agree to our Terms of Service and Privacy Policy.'**
  String get tosAgreement;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @verifyPhone.
  ///
  /// In en, this message translates to:
  /// **'Verify Phone'**
  String get verifyPhone;

  /// No description provided for @enterOtp.
  ///
  /// In en, this message translates to:
  /// **'Enter the OTP sent to your phone'**
  String get enterOtp;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @setupProfile.
  ///
  /// In en, this message translates to:
  /// **'Setup Profile'**
  String get setupProfile;

  /// No description provided for @tellUsAboutYourself.
  ///
  /// In en, this message translates to:
  /// **'Tell us about yourself'**
  String get tellUsAboutYourself;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @howWillYouUseApp.
  ///
  /// In en, this message translates to:
  /// **'How will you use Carpool Connect?'**
  String get howWillYouUseApp;

  /// No description provided for @commuter.
  ///
  /// In en, this message translates to:
  /// **'Commuter'**
  String get commuter;

  /// No description provided for @driver.
  ///
  /// In en, this message translates to:
  /// **'Driver'**
  String get driver;

  /// No description provided for @completeSetup.
  ///
  /// In en, this message translates to:
  /// **'Complete Setup'**
  String get completeSetup;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @searchRide.
  ///
  /// In en, this message translates to:
  /// **'Search for a ride'**
  String get searchRide;

  /// No description provided for @offerRide.
  ///
  /// In en, this message translates to:
  /// **'Offer a ride'**
  String get offerRide;

  /// No description provided for @online.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get online;

  /// No description provided for @offline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get offline;

  /// No description provided for @activities.
  ///
  /// In en, this message translates to:
  /// **'Activities'**
  String get activities;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Tokens'**
  String get wallet;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logout;

  /// No description provided for @activeTrips.
  ///
  /// In en, this message translates to:
  /// **'Active Trips'**
  String get activeTrips;

  /// No description provided for @rideHistory.
  ///
  /// In en, this message translates to:
  /// **'Ride History'**
  String get rideHistory;

  /// No description provided for @manageRequests.
  ///
  /// In en, this message translates to:
  /// **'Manage Requests'**
  String get manageRequests;

  /// No description provided for @tokenBalance.
  ///
  /// In en, this message translates to:
  /// **'Token Balance'**
  String get tokenBalance;

  /// No description provided for @redeemTokens.
  ///
  /// In en, this message translates to:
  /// **'Redeem Tokens'**
  String get redeemTokens;

  /// No description provided for @withdraw.
  ///
  /// In en, this message translates to:
  /// **'Redeem'**
  String get withdraw;

  /// No description provided for @tokens.
  ///
  /// In en, this message translates to:
  /// **'tokens'**
  String get tokens;

  /// No description provided for @rateRide.
  ///
  /// In en, this message translates to:
  /// **'Rate Your Ride'**
  String get rateRide;

  /// No description provided for @chat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// No description provided for @safety.
  ///
  /// In en, this message translates to:
  /// **'Safety & SOS'**
  String get safety;

  /// No description provided for @documentVerification.
  ///
  /// In en, this message translates to:
  /// **'Document Verification'**
  String get documentVerification;

  /// No description provided for @roleSwitcher.
  ///
  /// In en, this message translates to:
  /// **'Switch Role'**
  String get roleSwitcher;

  /// No description provided for @cancelRide.
  ///
  /// In en, this message translates to:
  /// **'Cancel Ride'**
  String get cancelRide;

  /// No description provided for @rideDetails.
  ///
  /// In en, this message translates to:
  /// **'Ride Details'**
  String get rideDetails;

  /// No description provided for @pickup.
  ///
  /// In en, this message translates to:
  /// **'Pickup'**
  String get pickup;

  /// No description provided for @destination.
  ///
  /// In en, this message translates to:
  /// **'Destination'**
  String get destination;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @distance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get distance;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'tokens'**
  String get currency;

  /// No description provided for @km.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get km;

  /// No description provided for @noActiveTrips.
  ///
  /// In en, this message translates to:
  /// **'No active trips'**
  String get noActiveTrips;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @rateApp.
  ///
  /// In en, this message translates to:
  /// **'Rate the App'**
  String get rateApp;

  /// No description provided for @openSourceLicenses.
  ///
  /// In en, this message translates to:
  /// **'Open Source Licenses'**
  String get openSourceLicenses;

  /// No description provided for @driverMode.
  ///
  /// In en, this message translates to:
  /// **'Driver Mode'**
  String get driverMode;

  /// No description provided for @commuterMode.
  ///
  /// In en, this message translates to:
  /// **'Commuter Mode'**
  String get commuterMode;

  /// No description provided for @recentTransactions.
  ///
  /// In en, this message translates to:
  /// **'Recent Transactions'**
  String get recentTransactions;

  /// No description provided for @topUp.
  ///
  /// In en, this message translates to:
  /// **'Token Reward'**
  String get topUp;

  /// No description provided for @ridePayment.
  ///
  /// In en, this message translates to:
  /// **'Redemption'**
  String get ridePayment;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @privacyAndSecurity.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Security'**
  String get privacyAndSecurity;

  /// No description provided for @helpAndSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpAndSupport;

  /// No description provided for @deactivateAccount.
  ///
  /// In en, this message translates to:
  /// **'Deactivate Account'**
  String get deactivateAccount;

  /// No description provided for @lookingForDrivers.
  ///
  /// In en, this message translates to:
  /// **'Looking for nearby drivers...'**
  String get lookingForDrivers;

  /// No description provided for @waitingForRequests.
  ///
  /// In en, this message translates to:
  /// **'Waiting for ride requests...'**
  String get waitingForRequests;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @publishRide.
  ///
  /// In en, this message translates to:
  /// **'Publish Ride'**
  String get publishRide;

  /// No description provided for @passengerName.
  ///
  /// In en, this message translates to:
  /// **'Passenger Name'**
  String get passengerName;

  /// No description provided for @decline.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get decline;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @submitRating.
  ///
  /// In en, this message translates to:
  /// **'Submit Rating'**
  String get submitRating;

  /// No description provided for @guest.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get guest;

  /// No description provided for @safetyPriority.
  ///
  /// In en, this message translates to:
  /// **'Your safety is our priority'**
  String get safetyPriority;

  /// No description provided for @sosEmergency.
  ///
  /// In en, this message translates to:
  /// **'SOS Emergency'**
  String get sosEmergency;

  /// No description provided for @sosEmergencyDesc.
  ///
  /// In en, this message translates to:
  /// **'Immediately notify authorities and your emergency contacts.'**
  String get sosEmergencyDesc;

  /// No description provided for @shareLiveTrip.
  ///
  /// In en, this message translates to:
  /// **'Share Live Trip'**
  String get shareLiveTrip;

  /// No description provided for @shareLiveTripDesc.
  ///
  /// In en, this message translates to:
  /// **'Share your real-time location with friends or family.'**
  String get shareLiveTripDesc;

  /// No description provided for @callSupport.
  ///
  /// In en, this message translates to:
  /// **'Call Support'**
  String get callSupport;

  /// No description provided for @callSupportDesc.
  ///
  /// In en, this message translates to:
  /// **'Talk to our 24/7 safety support team.'**
  String get callSupportDesc;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @pickupSpotMessage.
  ///
  /// In en, this message translates to:
  /// **'Okay, I am waiting at the pickup spot.'**
  String get pickupSpotMessage;

  /// No description provided for @onMyWayMessage.
  ///
  /// In en, this message translates to:
  /// **'I am coming in 5 mins'**
  String get onMyWayMessage;

  /// No description provided for @privacyPolicyContent.
  ///
  /// In en, this message translates to:
  /// **'Your privacy is important to us. CarpoolConnect collects personal data such as your name, phone number, and location data to provide our services.\n\n- Location Data: We track your location to match you with nearby drivers or passengers.\n- Data Sharing: We do not sell your personal data to third parties.\n- Security: We implement standard security measures to protect your information.\n\nFor full details on how we process your data, please read the complete Privacy Policy.'**
  String get privacyPolicyContent;

  /// No description provided for @tosContent.
  ///
  /// In en, this message translates to:
  /// **'By using CarpoolConnect, you agree to abide by our community guidelines, ensuring safe, respectful, and reliable rides. CarpoolConnect acts as a matching platform and is not a transportation provider. Users must verify their identities and adhere to local traffic laws.\n\n1. Account Registration: You must provide accurate information.\n2. User Conduct: Treat others with respect.\n3. Payments: Transactions for rides are processed securely.\n4. Liability: We are not responsible for user conduct during rides.\n\nPlease read the full detailed Terms of Service document.'**
  String get tosContent;

  /// No description provided for @verification.
  ///
  /// In en, this message translates to:
  /// **'Verification'**
  String get verification;

  /// No description provided for @verifyIdentity.
  ///
  /// In en, this message translates to:
  /// **'Verify your identity'**
  String get verifyIdentity;

  /// No description provided for @verificationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Upload your documents to unlock all features.'**
  String get verificationSubtitle;

  /// No description provided for @drivingLicense.
  ///
  /// In en, this message translates to:
  /// **'Driving License'**
  String get drivingLicense;

  /// No description provided for @nationalId.
  ///
  /// In en, this message translates to:
  /// **'National ID'**
  String get nationalId;

  /// No description provided for @vehicleRegistration.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Registration'**
  String get vehicleRegistration;

  /// No description provided for @submitForReview.
  ///
  /// In en, this message translates to:
  /// **'Submit for Review'**
  String get submitForReview;

  /// No description provided for @areYouSure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get areYouSure;

  /// No description provided for @deactivateSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Deactivating your account will disable your profile and remove your name and photo from most things you\'ve shared on Carpool Connect.'**
  String get deactivateSubtitle;

  /// No description provided for @deactivateMyAccount.
  ///
  /// In en, this message translates to:
  /// **'Deactivate My Account'**
  String get deactivateMyAccount;

  /// No description provided for @activeTrip.
  ///
  /// In en, this message translates to:
  /// **'Active Trip'**
  String get activeTrip;

  /// No description provided for @driverOnTheWay.
  ///
  /// In en, this message translates to:
  /// **'{name} is on the way'**
  String driverOnTheWay(Object name);

  /// No description provided for @recurringRide.
  ///
  /// In en, this message translates to:
  /// **'Recurring Ride'**
  String get recurringRide;

  /// No description provided for @recurringRideSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Repeat this ride on selected days'**
  String get recurringRideSubtitle;

  /// No description provided for @switchText.
  ///
  /// In en, this message translates to:
  /// **'Switch'**
  String get switchText;
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
      <String>['am', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'am':
      return AppLocalizationsAm();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
