import 'dart:async';
import 'package:coursati/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'package:coursati/Services/Controller/FileHandle.dart';
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'Classes/GlobalVariables.dart';
import 'Screens/main_page.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';

import 'Widgets/ErrorServer.dart';
// core Flutter primitives
import 'package:flutter/foundation.dart';
// core FlutterFire dependency
import 'package:firebase_core/firebase_core.dart';
// generated by

import 'firebase_options.dart';
// FlutterFire's Firebase Cloud Messaging plugin
import 'package:firebase_messaging/firebase_messaging.dart';

// TODO: Add stream controller

import 'package:rxdart/rxdart.dart';

// used to pass messages from event handler to the UI
final _messageStreamController = BehaviorSubject<RemoteMessage>();

// TODO: Define the background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
    print('Message data: ${message.data}');
    print('Message notification: ${message.notification?.title}');
    print('Message notification: ${message.notification?.body}');
  }
}

// Future getToken() async {
//   return await Dio().post("http://192.168.1.11:8000/api/auth/token",
//       data: {"email": "nader@email.com", "password": "password"});
// }

Future<void> main() async {
  //????????????????????????????????/
  //* FireBase Notification handling
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runZonedGuarded(() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   checkServer().then((value) {
//       if (value == 1) {
    FileHandle().readConfig().then((value) {
      if (value != null) {
        FileHandle().extractConfigData(value);
      } else {
        FileHandle().writeConfig(ConfigSave);
      }
      runApp(MainApp());
    });

    //  }else{ runApp(ServerError(error: value));}});
  }, (_, s) {});
  // // TODO: Request permission
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String _lastMessage = "";

  @override
  void initState() {
    super.initState();
    requestPermssionFireBase();
    getToken();
  }
  // _MainAppState() {
  //   _messageStreamController.listen((message) {
  //     setState(() {
  //       if (message.notification != null) {
  //         _lastMessage = 'Received a notification message:'
  //             '\nTitle=${message.notification?.title},'
  //             '\nBody=${message.notification?.body},'
  //             '\nData=${message.data}';
  //       } else {
  //         _lastMessage = 'Received a data message: ${message.data}';
  //       }
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    languageSelector = (languageType == 0) ? [true, false] : [false, true];

    return MaterialApp(
      title: (languageType == 0) ? "كورساتي" : "Coursati",
      debugShowCheckedModeBanner: false,
      // home: const MainPage(),
      home: const MainPage(),

      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: local,
      locale: local[languageType],
      theme: ThemeData(
        colorScheme: const ColorScheme(
            //*This is the background of the app
            background: Colors.white,
            brightness: Brightness.light,
            error: Colors.red,
            onBackground: Colors.amber,
            onError: Colors.cyan,
            //*This Color is for Text And Alike
            onPrimary: Color(0xff555555),
            onSecondary: Colors.amber,
            //* This Color is for disabled buttons and stuff
            onSurface: Color(0xff999999),
            //*This Color is For buttons and stuff like this
            primary: Color(0xff1776e0),
            //*This Colors is For Splash
            secondary: Color(0xff1776e0),
            surface: Colors.white),
        textTheme: const TextTheme(
          titleLarge: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
        ),
        fontFamily: "Tajawal",
      ),
      darkTheme: ThemeData(
        colorScheme: const ColorScheme(
            //*This is the background of the app
            background: Color(0xff424242),
            brightness: Brightness.dark,
            error: Colors.red,
            onBackground: Colors.amber,
            onError: Colors.cyan,
            //*This Color is for Text And Alike
            onPrimary: Color.fromARGB(255, 104, 104, 104),
            onSecondary: Colors.amber,
            //* This Color is for disabled buttons and stuff
            onSurface: Color(0xff999999),
            //*This Color is For buttons and stuff like this
            primary: Color(0xff1776e0),
            //*This Colors is For Splash
            secondary: Color(0xff1776e0),
            surface: Color(0xff424242)),
      ),
      themeMode: themeSelector[(isDark) ? 1 : 0],
    );
  }

  void requestPermssionFireBase() async {
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print("all good");
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print("granted provisonal permissons");
      }
    } else {
      if (kDebugMode) {
        print("Denied");
      }
    }
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        deviceID = token.toString();
        if (kDebugMode) {
          print(deviceID);
        }
      });
    });
  }
}

Future<int> checkServer() async {
  try {
    //*** This is the default server check */
    // response = await http.get(Uri.parse(server));
    //!! temp server check

    var response = await http.get(Uri.parse(onlineServer));
    if (response.statusCode == 200) {
      return 1;
    } else {
      return 2;
    }
  } catch (e) {
    return 0;
  }
}
