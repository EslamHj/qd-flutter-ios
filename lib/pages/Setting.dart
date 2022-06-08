import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_delivery/coponents/darkMode.dart';
import 'package:pro_delivery/coponents/darkmode_service.dart';

class setting extends StatefulWidget {
  setting({Key? key}) : super(key: key);

  @override
  State<setting> createState() => _settingState();
}

class _settingState extends State<setting> {
  var _value = false;
  String local = "false";
  final _Storage = GetStorage();

  darkService d = darkService();
  @override
  void initState() {
    super.initState();
    _value = _Storage.read("isDarkMode");
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _value ? Themes.dark_primary : Themes.light_primary,
        body: Stack(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(20, 25, 20, 5),
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: _value == true ? Themes.dark_primary : Themes.light_white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: _value == true ? Themes.dark_grey : Themes.light_white,
                width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 150,
                      child: Text(
                        "الألوان الليلية",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.cairo(
                            textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: _value == true
                                    ? Themes.dark_white
                                    : Themes.light.primaryColor)),
                      ),
                    ),
                    Container(
                      height: 35,
                      child: Transform.scale(
                        scale: 1,
                        child: Switch(
                          value: _value,
                          activeColor: Themes.light.primaryColor,
                          onChanged: (bool value) {
                            setState(() {
                              // if (Get.isDarkMode) {
                              //   _value = true;
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //       SnackBar(
                              //           backgroundColor:
                              //               Color.fromARGB(255, 118, 82, 153),
                              //           content: Directionality(
                              //             textDirection: TextDirection.rtl,
                              //             child: Text(
                              //               "لايمكن تغير التطبيق الى الوضع العادي يجب تغير نظام الجهاز الى الوضع العاد اولا",
                              //               style: GoogleFonts.cairo(
                              //                   textStyle: TextStyle(
                              //                       fontSize: 14,
                              //                       color: Themes.light_white)),
                              //             ),
                              //           )));
                              // } else {
                                _value = value;
                                // _value == false
                                //     ? Get.changeTheme(Themes.light)
                                //     : Get.changeTheme(Themes.dark);
                                _Storage.write("isDarkMode", _value);
                                  
                              }
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    "إذا كنت تفضل الالوان الليلية فعل هذا الخيار",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Themes.light_grey)),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
