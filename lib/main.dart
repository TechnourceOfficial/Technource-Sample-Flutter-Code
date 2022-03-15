import 'dart:convert';
import 'package:cutit_new/route/routes.dart';
import 'package:cutit_new/shared_pref/shared_preference_helper.dart';
import 'package:cutit_new/ui/home/home_page.dart';
import 'package:cutit_new/ui/login/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constant/app_theme.dart';
import 'constant/common_method.dart';
import 'constant/common_variable.dart';
import 'localization/application_localizations.dart';
// define channel of notification
AndroidNotificationChannel channel = AndroidNotificationChannel(
  'CUT-IT', // id
  'CUT-IT', // title
  'CUT-IT', // description
  importance: Importance.high,
  playSound: true,
  showBadge: true,
  enableLights: true,
  enableVibration: true,
);
// local notification instance
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
// handle background method notification
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}
// main method
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase intialize
  await Firebase.initializeApp();
  // set orientation
  await setPreferredOrientations();
  // call background method
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // add channel in local notification
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  // set permission to allow alert, badge, sound of notification
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(MyApp());
}
// set orientation
Future<void> setPreferredOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

class MyApp extends StatefulWidget {
  MyApp();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
    // chech user is logged or not
    checkValidation();
    // get firebase notification token and intialize notificaion.
    firebaseIntializeWithToken();
  }
  // firebase intialize with token
  void firebaseIntializeWithToken() async {
    Future.delayed(Duration(milliseconds: 100), () async {
      FirebaseMessaging.instance.getInitialMessage().then((message) async {
        if (message != null && message.data.toString().trim() != "") {

        }
      });
      FirebaseMessaging.instance
          .getToken(vapidKey: CommonVariable.VapidKey)
          .then((value) => {
                if (value != null)
                  {
                    CommonVariable.FirebaseToken = value.toString()
                  }
              })
          .catchError((onError) {});

      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        SharedPreferences _prefs = await SharedPreferences.getInstance();
        SharedPreferenceHelper _sharedPrefsHelper =
            SharedPreferenceHelper(_prefs);
        await _sharedPrefsHelper.isLoggedIn.then((value) {
          if (value != null && value) {
            if (message != null && message.data.toString().trim() != "") {

            }
          }
        });

        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                  android: AndroidNotificationDetails(
                    channel.id,
                    channel.name,
                    channel.description,
                    // TODO add a proper drawable resource to android, for now using
                    //      one that already exists in example app.
                    icon: 'launcher_image',
                    playSound: true,
                    enableVibration: true,
                    enableLights: true,
                    channelShowBadge: true,
                  ),
                  iOS: IOSNotificationDetails(
                      presentAlert: true,
                      // Present an alert when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
                      presentBadge: true,
                      // Present the badge number when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
                      presentSound: true)),
              payload: jsonEncode(message.data));
        }
      });

      FirebaseMessaging.onMessageOpenedApp
          .listen((RemoteMessage message) async {
        SharedPreferences _prefs = await SharedPreferences.getInstance();
        SharedPreferenceHelper _sharedPrefsHelper =
            SharedPreferenceHelper(_prefs);
        await _sharedPrefsHelper.isLoggedIn.then((value) {
          if (value != null && value) {
            if (message != null && message.data.toString().trim() != "") {
            }
          }
        });
      });
      final IOSInitializationSettings initializationSettingsIOS =
          IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification,
        defaultPresentSound: true,
        defaultPresentBadge: true,
        defaultPresentAlert: true,
      );
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('launcher_image');
      final InitializationSettings initializationSettings =
          InitializationSettings(
              android: initializationSettingsAndroid,
              iOS: initializationSettingsIOS);
      flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onSelectNotification: onSelectNotification);
    });
  }
  // move particular screen according to login status
  void checkValidation() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    SharedPreferenceHelper _sharedPrefsHelper = SharedPreferenceHelper(_prefs);
    await _sharedPrefsHelper.isLoggedIn.then((value) {
      if (value != null && value) {
        CommonVariable.isLogin = true;
        setState(() {});

      } else {
        CommonVariable.isLogin = false;
        setState(() {});
      }
    }).catchError((e) {
      CommonVariable.isLogin = false;
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    CommonMethod.setContext();
    precacheImage(AssetImage(CommonVariable.LOGIN_BACKGROUND), context);
    precacheImage(
        AssetImage(CommonVariable.SPLASH_WITH_LOGO_BACKGROUND), context);
    return MaterialApp(
      navigatorKey: CommonMethod.NAVIGATOR_KEY,
      debugShowCheckedModeBanner: false,
      theme: themeData,
      supportedLocales: [
        Locale('en'),
      ],
      localizationsDelegates: [
        ApplicationLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocaleLanguage in supportedLocales) {
          if (supportedLocaleLanguage.languageCode == locale!.languageCode &&
              supportedLocaleLanguage.countryCode == locale.countryCode) {
            return supportedLocaleLanguage;
          }
        }
        return supportedLocales.first;
      },
      home: CommonVariable.isLogin ? HomePage() : LoginPage(),
      onGenerateRoute: CustomRouter.generatedRoute,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }
  // get notification for ios data.
  Future onDidReceiveLocalNotification(
      dynamic id, dynamic title, dynamic body, dynamic payload) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    SharedPreferenceHelper _sharedPrefsHelper = SharedPreferenceHelper(_prefs);
    await _sharedPrefsHelper.isLoggedIn.then((value) {
      if (value != null && value) {
        if (payload != null && payload.toString().trim() != "") {

        }
      }
    });
  }
  // get notification for android data
  Future onSelectNotification(dynamic payload) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    SharedPreferenceHelper _sharedPrefsHelper = SharedPreferenceHelper(_prefs);
    await _sharedPrefsHelper.isLoggedIn.then((value) {
      if (value != null && value) {
        if (payload != null && payload.toString().trim() != "") {
        }
      }
    });
  }
}
