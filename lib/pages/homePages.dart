import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_delivery/coponents/Api.dart';
import 'package:pro_delivery/coponents/Notifications.dart';
import 'package:pro_delivery/coponents/darkMode.dart';
import 'package:pro_delivery/pages/AddOrder.dart';
import 'package:pro_delivery/pages/Branches.dart';
import 'package:pro_delivery/pages/Delivery_Prices.dart';
import 'package:pro_delivery/pages/Details_Movements.dart';
import 'package:pro_delivery/pages/Order.dart';
import 'package:pro_delivery/pages/Search.dart';
import 'package:pro_delivery/pages/Setting.dart';
import 'package:pro_delivery/pages/TabsOrder.dart';
import 'package:pro_delivery/pages/Wallet.dart';
import 'package:rxdart/rxdart.dart';

import 'package:signalr_netcore/signalr_client.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class homePagess extends StatefulWidget {
  homePagess({Key? key}) : super(key: key);

  @override
  State<homePagess> createState() => _homePagessState();
}

class _homePagessState extends State<homePagess> {
  int currentTab = 0;
  final List<Widget> Pages = [
    addOrder(),
    order(),
    wallet(),
    setting(),
    deliveryPrices(),
    search(),
    branches(),
    tabsorder(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currenScreen = tabsorder();

  final _Storage = GetStorage();
  var _color = true;
  List branche = [];
  List dlyPrices = [];
  Map test = {"id": "2"};
  bool visible_ = false;
  var body = "";
  var token = "";
 var i =0 ;
  String barcode = "";
  String status = "";
  List<Object>? code = [""];

  @override
  void initState() {
    super.initState();
    _color = _Storage.read("isDarkMode");
    token = _Storage.read("token");
    initSignalR();

    NotificationApi.init();
    // listenNotification();
  }

  // void listenNotification() =>
  //     NotificationApi.onNotifications.stream.listen(onClickNotifications);
  // void onClickNotifications(String? payload) =>   Navigator.pushNamed(context, 'details_movements',
  //         arguments:  "" );
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: _appBar(),
            body: PageStorage(
              child: currenScreen,
              bucket: bucket,
            ),
            floatingActionButton: currentTab == 4 || currentTab == 5
                ? null
                : FloatingActionButton(
                    backgroundColor: Themes.light.primaryColor,
                    child: Icon(Icons.add,
                        color: _color == true ? Colors.white : Colors.white),
                    onPressed: () {
                      // Workmanager().registerOneOffTask("1","taskName", constraints: Constraints(networkType: NetworkType.connected));

                      setState(() {
                        Navigator.pushNamed(context, 'addOrder');
                      });
                    },
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.startFloat,
            bottomNavigationBar: BottomAppBar(
              // color: _color ? Themes.dark_primary2 : Themes.light_white ,
              color: Themes.light_white,
              shape: CircularNotchedRectangle(),
              notchMargin: 0,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SingleChildScrollView(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MaterialButton(
                            minWidth: 30,
                            onPressed: () {
                              setState(() {
                                _Storage.write("currenScreen", "0");
                                currenScreen = tabsorder();
                                currentTab = 0;
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.dashboard,
                                  color: currentTab == 0
                                      ? Themes.light.primaryColor
                                      : Themes.light_grey,
                                ),
                                Text(
                                  "الطلبيات",
                                  style: GoogleFonts.cairo(
                                      textStyle: TextStyle(
                                    fontSize: _width < 321 ? 10 : 12,
                                    fontWeight: currentTab == 0
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: Themes.light_grey,
                                  )),
                                )
                              ],
                            ),
                          ),
                          MaterialButton(
                            minWidth: 30,
                            onPressed: () {
                              setState(() {
                                currenScreen = wallet();
                                currentTab = 1;
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.account_balance_wallet,
                                  color: currentTab == 1
                                      ? Themes.light.primaryColor
                                      : Colors.grey,
                                ),
                                Text(
                                  "المحفظة",
                                  style: GoogleFonts.cairo(
                                      textStyle: TextStyle(
                                    fontSize: _width < 321 ? 10 : 12,
                                    fontWeight: currentTab == 1
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: Themes.light_grey,
                                  )),
                                )
                              ],
                            ),
                          ),
                          MaterialButton(
                            minWidth: 30,
                            onPressed: () {
                              setState(() {
                                currenScreen = branches();
                                currentTab = 2;
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.delivery_dining_sharp,
                                  color: currentTab == 2
                                      ? Themes.light.primaryColor
                                      : Colors.grey,
                                ),
                                Text(
                                  "اسعار التوصيل",
                                  style: GoogleFonts.cairo(
                                      textStyle: TextStyle(
                                    fontSize: _width < 321 ? 10 : 12,
                                    fontWeight: currentTab == 2
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: Themes.light_grey,
                                  )),
                                )
                              ],
                            ),
                          ),
                          MaterialButton(
                            minWidth: 30,
                            onPressed: () {
                              setState(() {
                                currenScreen = setting();
                                currentTab = 3;
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.settings,
                                  color: currentTab == 3
                                      ? Themes.light.primaryColor
                                      : Colors.grey,
                                ),
                                Text(
                                  "الإعدادات",
                                  style: GoogleFonts.cairo(
                                      textStyle: TextStyle(
                                    fontSize: _width < 321 ? 10 : 12,
                                    fontWeight: currentTab == 3
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: Themes.light_grey,
                                  )),
                                )
                              ],
                            ),
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            )));
  }

  _appBar() {
    return AppBar(
      backgroundColor: Themes.light.primaryColor,
      elevation: currentTab == 0 ? 0 : null,
      leading: Container(
          margin: EdgeInsets.all(5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              api().urlIcon,
              height: 40,
              width: 40,
              // fit: BoxFit.cover,
            ),
          )),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.search_outlined,
            size: 25,
          ),
          onPressed: () {
            setState(() {
              Navigator.pushNamed(context, 'search');
            });
          },
        ),
        SizedBox(
          width: 20,
        ),
        Icon(
          Icons.notifications,
          size: 25,
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }

  // invoke_() {
  //   if (hubConnection.state == HubConnectionState.Connected) {
  //     hubConnection.invoke("ReceiveNotification", args: code);
  //   }
  // }

  void initSignalR() {
    try {
      print(token);
      HubConnection hubConnection;

      hubConnection = HubConnectionBuilder()
          .withUrl("https://www.demo.qdlibya.com/notificationsHub",
              options: HttpConnectionOptions(
                  accessTokenFactory: () async => await token))
          .build();

      hubConnection.on("ReceiveNotification", _mavements);

      hubConnection.start();
      // if (hubConnection.state == HubConnectionState.Connecting) {
      //   print("Connecting");
      // }
    } catch (ex) {
      print(ex);
    }
  }

  void _mavements(List<Object>? args) {
    setState(() {
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails('your channel id', 'your channel name',
              importance: Importance.max,
              priority: Priority.high,
              showWhen: false);
      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
        
         i++ ;

      flutterLocalNotificationsPlugin
          .show(i, "QdL"  ,args![1].toString() + " رقم الشحنه " + args[0].toString(), platformChannelSpecifics, payload: 'item x');
      // NotificationApi.showNotification(
      //   title: args![0].toString(),
      //   // body: 'ggggggggg',
      //   payload: 'sarah.abs',
      // );
    });
  }

  void callbackDispatcher() {
    Workmanager().executeTask((taskName, inputData) async {
      //  initSignalR();
      print("okkkkkkkk");
      return Future.value(true);
    });
  }

// void main() {
//   Workmanager().initialize(callbackDispatcher);
// }
}
