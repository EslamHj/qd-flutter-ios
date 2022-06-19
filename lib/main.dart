import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pro_delivery/coponents/darkMode.dart';
import 'package:pro_delivery/pages/AddOrder.dart';
import 'package:pro_delivery/pages/Delivery_Prices.dart';
import 'package:pro_delivery/pages/Details_Movements.dart';
import 'package:pro_delivery/pages/Details_Order.dart';
import 'package:pro_delivery/pages/Login.dart';
import 'package:pro_delivery/pages/SearchIndex.dart';
import 'package:pro_delivery/pages/Suppliers/Details_Suppliers.dart';
import 'package:pro_delivery/pages/Suppliers/homeSuppliers.dart';
import 'package:pro_delivery/pages/homePages.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  runApp(MyApp());
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
      
      var role =_Storage.read("role").toString()  ;

      if (role == "2"){
          return homeSuppliers();
      }
      else {
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
      },
      home: login_tokon(),
    );
  }
}
