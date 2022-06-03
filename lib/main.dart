import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pro_delivery/coponents/darkMode.dart';
import 'package:pro_delivery/pages/AddOrder.dart';
import 'package:pro_delivery/pages/Delivery_Prices.dart';
import 'package:pro_delivery/pages/Details_Movements.dart';
import 'package:pro_delivery/pages/Details_Order.dart';
import 'package:pro_delivery/pages/Login.dart';
import 'package:pro_delivery/pages/Order.dart';
import 'package:pro_delivery/pages/Search.dart';
import 'package:pro_delivery/pages/home.dart';
import 'package:pro_delivery/pages/homePages.dart';
import 'coponents/darkmode_service.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  // runApp( DevicePreview(builder: (context) => MyApp()));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _Storage = GetStorage();

  @override
  void initState() {
    super.initState();

    setState(() {
      if (_Storage.read("isDarkMode") != null) {
        _Storage.read("isDarkMode") == false
            ? Get.changeTheme(Themes.light)
            : Get.changeTheme(Themes.dark);
      } else {
        darkService().saveThemeMode(false);
        Get.changeTheme(Themes.light);
      }
    });
  }

// @override
//   void initState() {
//     super.initState();
//     darkService().readedarkMode().then((data) {
//       setState(() {
//         data == "false"
//             ? Get.changeTheme(Themes.light)
//             : Get.changeTheme(Themes.dark);
//       });
//     });
//   }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
// builder:DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,

      theme: Themes.light,
      darkTheme: Themes.dark,
      // themeMode: dark_value == "false" ?ThemeMode.light : ThemeMode.dark,

      routes: {
        "addOrder": (context) => addOrder(),
        "deliveryPrices": (context) => deliveryPrices(),
        "details_order": (context) => details_order(),
        "details_movements": (context) => details_movements(),
      },
      home: homePagess(),
    );
  }
}
