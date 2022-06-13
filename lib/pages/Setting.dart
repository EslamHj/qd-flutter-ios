import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_delivery/coponents/darkMode.dart';
import 'package:pro_delivery/pages/Login.dart';

class setting extends StatefulWidget {
  setting({Key? key}) : super(key: key);

  @override
  State<setting> createState() => _settingState();
}

class _settingState extends State<setting> {
  var _value = false;
  String local = "false";
  final _Storage = GetStorage();

  @override
  void initState() {
    super.initState();
    _value = _Storage.read("isDarkMode");
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: _value ? Themes.dark_primary : Themes.light_primary,
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 25, 20, 5),
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color:
                    _value == true ? Themes.dark_primary : Themes.light_white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color:
                        _value == true ? Themes.dark_grey : Themes.light_white,
                    width: 1),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                                  _value = value;

                                  _Storage.write("isDarkMode", _value);
                                });
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
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => login()),
                );
                _Storage.remove("token");
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(20, 25, 20, 5),
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  color:
                      _value == true ? Themes.dark_primary : Themes.light_white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: _value == true
                          ? Themes.dark_grey
                          : Themes.light_white,
                      width: 1),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                              "تسجيل الخروج",
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
                              child: Icon(
                                Icons.exit_to_app,
                                color: Themes.light.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
