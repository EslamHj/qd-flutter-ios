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

class login extends StatefulWidget {
  login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
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
                    //  Container(
                    //    child: Image.asset("assets/Q-login.png"),
                    //    height: 120,
                    //    width: 120,
                    //  ),

                    Container(
                      margin: EdgeInsets.only(right: 20, top: 20),
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "تسجيل الدخول",
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

              /////////////// Password  ///////////////////
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                padding: EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey[200],
                  // boxShadow: [
                  //   BoxShadow(
                  //       offset: Offset(0, 10),
                  //       blurRadius: 50,
                  //       color: Color(0xffEEEEEE))
                  // ]
                ),
                alignment: Alignment.center,
                child: TextField(
                  controller: passController,
                  style: TextStyle(
                    color: Themes.light.primaryColor,
                  ),
                  obscureText: hidePass,
                  cursorColor: Themes.light.primaryColor,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.password,
                      color: Themes.light.primaryColor,
                    ),
                    hintText: "كلمة المرور",
                    hintStyle: GoogleFonts.cairo(
                        textStyle: TextStyle(
                            color: Themes.light.primaryColor,
                            fontWeight: FontWeight.w500)),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePass = !hidePass;
                        });
                      },
                      color: Themes.light.primaryColor,
                      icon: Icon(
                          hidePass ? Icons.visibility_off : Icons.visibility),
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 20, right: 20),
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  child: Text(
                    "هل نسيت كلمة السر ؟",
                    style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                      color: _color == true
                          ? Themes.dark_white
                          : Themes.light_black,
                    )),
                  ),
                  onTap: () {},
                ),
              ),

              Visibility(
                visible: visible_login,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      visible_ = true;
                    });

                    login();
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
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
                      child: Text("دخول",
                          style: GoogleFonts.cairo(
                            textStyle: TextStyle(
                              color: Themes.light_white,
                              fontWeight: FontWeight.bold,
                            ),
                          ))),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "هل تريد إنشاء حساب؟",
                      style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                          color:
                              _color ? Themes.dark_white : Themes.light_black,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => createAccount()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Text(
                          "إنشاء حساب",
                          style: GoogleFonts.cairo(
                            textStyle: TextStyle(
                              color: Themes.light.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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

  Future<void> login() async {
    try {
      visible_login = false;
      if (emailController.text.isNotEmpty && passController.text.isNotEmpty) {
        var urlLogin = Uri.parse(api().url +
            api().login +
            "userName=" +
            emailController.text +
            "&passward=" +
            passController.text);

        var response = await http.get(
          urlLogin,
          headers: {
            "Authorization": "Bearer",
          },
        );
        var responsebody = jsonDecode(response.body);

        if (response.statusCode == 200) {
          setState(() {
            visible_ = false;
            visible_login = true;
          });
          _Storage.write("name", responsebody["data"]["name"]);
          _Storage.write("code", responsebody["data"]["code"]);
          _Storage.write("token", responsebody["data"]["token"]);
          _Storage.write("phone1", responsebody["data"]["phone1"]);
          _Storage.write("phone2", responsebody["data"]["phone2"]);
          _Storage.write("role", responsebody["data"]["role"]);
          _Storage.write("storeName", "");
          _Storage.write("fromBranchID", "00");
          _Storage.write("fromBranchName", "");

          if (_Storage.read("role").toString() == "2") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => homeSuppliers()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => homePagess()),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Color.fromARGB(255, 118, 82, 153),
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Color.fromARGB(255, 118, 82, 153),
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

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Color.fromARGB(255, 118, 82, 153),
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

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Color.fromARGB(255, 118, 82, 153),
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
