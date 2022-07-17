import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pro_delivery/coponents/Notifications.dart';
import 'package:pro_delivery/coponents/darkMode.dart';
import 'package:pro_delivery/pages/AddOrder.dart';
import 'package:pro_delivery/pages/Delivery_Prices.dart';
import 'package:pro_delivery/pages/Details_Movements.dart';
import 'package:pro_delivery/pages/Details_Order.dart';
import 'package:pro_delivery/pages/Login.dart';
import 'package:pro_delivery/pages/Search.dart';
import 'package:pro_delivery/pages/SearchIndex.dart';
import 'package:pro_delivery/pages/Suppliers/Details_Suppliers.dart';
import 'package:pro_delivery/pages/Suppliers/homeSuppliers.dart';
import 'package:pro_delivery/pages/homePages.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:workmanager/workmanager.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
initSignalR() {
  try {
    HubConnection hubConnection;

    hubConnection = HubConnectionBuilder()
        .withUrl("https://www.demo.qdlibya.com/notificationsHub")
        .build();

    hubConnection.on("ReceiveNotification", _mavements);

    hubConnection.start();
    if (hubConnection.state == HubConnectionState.Connecting) {
      print("Connecting");
    }
  } catch (ex) {
    print(ex);
  }
}

void _mavements(List<Object>? args) {
  NotificationApi.showNotification(
    title: args![0].toString(),
    // body: 'ggggggggg',
    payload: 'sarah.abs',
  );
}

 void callbackDispatcher() {
    Workmanager().executeTask((taskName, inputData) async {
      initSignalR();
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('Eslam', '66',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: true);
      const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
      // await flutterLocalNotificationsPlugin.show(
      //     0,
      //     dataComingFromTheServer['data']['first_name'],
      //     dataComingFromTheServer['data']['email'],
          // platformChannelSpecifics,
          // payload: 'item x');
      return Future.value(true);
    });
  }

// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     if (task == 'uniqueKey') {
//       ///do the task in Backend for how and when to send notification
//       var response = await http.get(Uri.parse("https://reqres.in/api/users/2"));
//       Map dataComingFromTheServer = json.decode(response.body);

//       final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//       const AndroidNotificationDetails androidPlatformChannelSpecifics =
//       AndroidNotificationDetails('your channel id', 'your channel name',
//           importance: Importance.max,
//           priority: Priority.high,
//           showWhen: false);
//       const NotificationDetails platformChannelSpecifics =
//       NotificationDetails(android: androidPlatformChannelSpecifics);
//       await flutterLocalNotificationsPlugin.show(
//           0,
//           dataComingFromTheServer['data']['first_name'],
//           dataComingFromTheServer['data']['email'],
//           platformChannelSpecifics,
//           payload: 'item x');
//     }
//     return Future.value(true);
//   });
// }

void main() async {


    WidgetsFlutterBinding.ensureInitialized();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings(
      '@mipmap/ic_launcher');
  final IOSInitializationSettings initializationSettingsIOS =
  IOSInitializationSettings();
  final MacOSInitializationSettings initializationSettingsMacOS =
  MacOSInitializationSettings();
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsMacOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: selectNotification);

  


  Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode:
      true);

  Workmanager().registerPeriodicTask(
    "1",
    "uniqueKey",
    frequency: Duration(minutes: 1),
  );
   Workmanager().registerPeriodicTask(
    "2",
    "go",
    frequency: Duration(minutes: 30),
  );


  /////////////////////

  WidgetsFlutterBinding.ensureInitialized();
  // Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  await GetStorage.init();

  runApp(MyApp());
}

Future selectNotification(String ? payload) async {
  if (payload != null) {
    debugPrint('notification payload: $payload');
  }
}


class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _Storage = GetStorage();

  Widget login_tokon() {
    var token = _Storage.read("token");

    if (token == null || JwtDecoder.isExpired(token)) {
      return login();
    } else {
      var role = _Storage.read("role").toString();

      if (role == "2") {
        return homeSuppliers();
      } else {
        return homePagess();
      }
    }
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      if (_Storage.read("isDarkMode") != null) {
        _Storage.read("isDarkMode") == false
            ? Get.changeTheme(Themes.light)
            : null;
      } else {
        _Storage.write("isDarkMode", false);
        Get.changeTheme(Themes.light);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      // darkTheme:  Themes.dark ,
      routes: {
        "searchIndex": (context) => searchIndex(),
        "addOrder": (context) => addOrder(),
        "deliveryPrices": (context) => deliveryPrices(),
        "details_order": (context) => details_order(),
        "details_movements": (context) => details_movements(),
        "details_Suppliers": (context) => details_Suppliers(),
        "search": (context) => search(),
      },
      home: login_tokon(),
    );
  }
}
