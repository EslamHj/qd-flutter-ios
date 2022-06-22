import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_delivery/coponents/Api.dart';
import 'package:pro_delivery/coponents/darkMode.dart';
import 'package:pro_delivery/pages/CreateAccount.dart';
import 'package:pro_delivery/pages/Suppliers/homeSuppliers.dart';
import 'package:pro_delivery/pages/homePages.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher_string.dart';


class gmail extends StatefulWidget {
  gmail({Key? key}) : super(key: key);

  @override
  State<gmail> createState() => _gmailState();
}

class _gmailState extends State<gmail> {
  final _Storage = GetStorage();
  var _color = true;
  bool visible_ = false;
  bool hidePass = true;
  bool visible_login = true;

  var emailController = TextEditingController();
  var passController = TextEditingController();
  GlobalKey<FormState> formStateV = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _color = _Storage.read("isDarkMode");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _color ? Themes.dark_primary : Themes.light_primary,
      body: SingleChildScrollView(
          child: Directionality(
        textDirection: TextDirection.rtl,
        child: Form(
          key: formStateV,
          child: Column(
            children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(90)),
                  color: Themes.light.primaryColor,
                  // gradient: LinearGradient(
                  //     colors: [
                  //       (Color.fromARGB(255, 85, 51, 117)),
                  //       (Color.fromARGB(255, 118, 82, 153))
                  //     ],
                  //     begin: Alignment.topCenter,
                  //     end: Alignment.bottomCenter)
                ),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Image.asset(api().urlIcon),
                      height: 160,
                      width: 160,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      alignment: Alignment.bottomRight,
                      child:Text(
                  "الرجاء مراجعة الإيميل الخاص بك",
                  style: GoogleFonts.cairo(
                      textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Themes.light_white)),
                ),
                    )
                  ],
                )),
              ),
            
              Visibility(
                visible: visible_login,
                child: GestureDetector(
                  onTap: () {
                 
                   launchUrlString("https://mail.google.com/mail/u/0/#inbox");
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 40),
                      height: 54,
                      alignment: Alignment.center,
                      //  width: double.infinity,
                      decoration: BoxDecoration(
                        color: Themes.light.primaryColor,
                        // gradient: LinearGradient(
                        //     colors: [
                        //       (Color.fromARGB(255, 96, 55, 134)),
                        //       (Color.fromARGB(255, 149, 102, 192))
                        //     ],
                        //     begin: Alignment.centerLeft,
                        //     end: Alignment.centerRight),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text("Gmail",
                          style: GoogleFonts.cairo(
                            textStyle: TextStyle(
                              color: Themes.light_white,
                              fontWeight: FontWeight.bold,
                            ),
                          ))),
                ),
              ),
              Visibility(
                  visible: visible_,
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Center(
                        child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Themes.light.primaryColor),
                    )),
                  )),
            ],
          ),
        ),
      )),
    );
  }

}
