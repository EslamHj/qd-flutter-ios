import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_delivery/coponents/Api.dart';
import 'package:pro_delivery/coponents/darkMode.dart';
import 'package:pro_delivery/pages/CreateAccount.dart';
import 'package:pro_delivery/pages/Gmail.dart';
import 'package:pro_delivery/pages/Suppliers/homeSuppliers.dart';
import 'package:pro_delivery/pages/homePages.dart';
import 'package:http/http.dart' as http;

class sendEmail extends StatefulWidget {
  sendEmail({Key? key}) : super(key: key);

  @override
  State<sendEmail> createState() => _sendEmailState();
}

class _sendEmailState extends State<sendEmail> {
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
                      child: Text(
                        "تغيير كلمة المرور",
                        style: GoogleFonts.cairo(
                            textStyle: TextStyle(
                                fontSize: 20, color: Themes.light_white)),
                      ),
                    )
                  ],
                )),
              ),

              /////////////// Email  ///////////////////
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 70),
                padding: EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey[200],
                  // boxShadow: [
                  //   BoxShadow(
                  //       offset: Offset(0, 10),
                  //       blurRadius: 50,
                  //       color: Color(0xffEEEEEE)
                  //       )
                  // ]
                ),
                alignment: Alignment.center,
                child: TextFormField(
                  controller: emailController,
                  style: TextStyle(
                    color: Themes.light.primaryColor,
                  ),
                  cursorColor: Themes.light.primaryColor,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: Themes.light.primaryColor,
                    ),
                    hintText: "البريد الإلكتروني",
                    hintStyle: GoogleFonts.cairo(
                        textStyle: TextStyle(
                            color: Themes.light.primaryColor,
                            fontWeight: FontWeight.w500)),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  validator: (Value) {
                    if (Value!.isEmpty) {
                      return "yyy";
                    }
                  },
                ),
              ),

        
               Visibility(
                visible: visible_login,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      visible_ = true;
                    });

                    send();
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
                      child: Text("ارسال",
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

  ///////////////////////////api login ///////////////////////////////////////////////

  Future<void> send() async {
    try {
      visible_login = false;
      if (emailController.text.isNotEmpty) {
        var urlLogin = Uri.parse(api().url +
            api().ChangePasswordEmail + emailController.text +"?uri=" + api().URLFrontend + "changePassword" );
         

        var response = await http.get(
          urlLogin,
          headers: {
            "Authorization": "Bearer",
          },
        );
        var responsebody = jsonDecode(response.body);

        if (response.statusCode == 200) {
          setState(() {
               Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => gmail()));
            visible_ = false;
            visible_login = true;
          });
      
        } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Themes.showSnackBarColor,
              content: Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  responsebody["message"],
                  style: GoogleFonts.cairo(
                      textStyle:
                          TextStyle(fontSize: 14, color: Themes.light_white)),
                ),
              )));
          setState(() {
            visible_ = false;
            visible_login = true;
          });
        }
      } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Themes.showSnackBarColor,
            content: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                "يجب الملء",
                style: GoogleFonts.cairo(
                    textStyle:
                        TextStyle(fontSize: 14, color: Themes.light_white)),
              ),
            )));
        setState(() {
          visible_ = false;
          visible_login = true;
        });
      }
    } on FormatException {
      setState(() {
        visible_ = false;
        visible_login = true;
      });

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Themes.showSnackBarColor,
          content: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              "خطأ في البيانات",
              style: GoogleFonts.cairo(
                  textStyle:
                      TextStyle(fontSize: 14, color: Themes.light_white)),
            ),
          )));
    } on SocketException {
      setState(() {
        visible_ = false;
        visible_login = true;
      });
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Themes.showSnackBarColor,
          content: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              "خطأ في الاتصال بالانترنت",
              style: GoogleFonts.cairo(
                  textStyle:
                      TextStyle(fontSize: 14, color: Themes.light_white)),
            ),
          )));
    } catch (ex) {
      visible_ = false;
      visible_login = true;
    }
  }
}