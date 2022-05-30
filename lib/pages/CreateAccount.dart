import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_delivery/coponents/darkMode.dart';
import 'package:pro_delivery/pages/Terms.dart';

class createAccount extends StatefulWidget {
  createAccount({Key? key}) : super(key: key);

  @override
  State<createAccount> createState() => _createAccountState();
}

class _createAccountState extends State<createAccount> {
  var _value = false;
  final _Storage = GetStorage();
  var _color = true;
  @override
  void initState() {
    super.initState();
    _color = _Storage.read("isDarkMode");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Container(
              height: 270,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(90)),
                  color: Themes.light.primaryColor,
                  gradient: LinearGradient(colors: [
                    (Color.fromARGB(255, 85, 51, 117)),
                    (Color.fromARGB(255, 118, 82, 153))
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //  Container(
                  //    child: Image.asset("assets/qd.png"),
                  //    height: 90,
                  //    width: 90,
                  //  ),
                  Container(
                    margin: EdgeInsets.only(right: 20, top: 20),
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "إنشاء حساب",
                      style: GoogleFonts.cairo(
                          textStyle: TextStyle(
                              fontSize: 20, color: Themes.light_white)),
                    ),
                  )
                ],
              )),
            ),

            /////////////// الإسم  ///////////////////
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
              child: TextField(
                style: TextStyle(
                  color: Themes.light.primaryColor,
                ),
                cursorColor: Themes.light.primaryColor,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: Themes.light.primaryColor,
                  ),
                  hintText: "الإسم",
                  hintStyle: GoogleFonts.cairo(
                      textStyle: TextStyle(
                          color: Themes.light.primaryColor,
                          fontWeight: FontWeight.w500)),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),

            /////////////// البريد  ///////////////////
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
                style: TextStyle(
                  color: Themes.light.primaryColor,
                ),
                obscureText: true,
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
              ),
            ),

            /////////////// الارقام  ///////////////////

            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 20, top: 30),
                    padding: EdgeInsets.only(left: 20, right: 15),
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
                    child: TextField(
                      style: TextStyle(
                        color: Themes.light.primaryColor,
                      ),
                      cursorColor: Themes.light.primaryColor,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(right: -15),
                        icon: Icon(
                          Icons.phone_android,
                          color: Themes.light.primaryColor,
                        ),
                        hintText: "رقم الهاتف",
                        hintStyle: GoogleFonts.cairo(
                            textStyle: TextStyle(
                                color: Themes.light.primaryColor,
                                fontWeight: FontWeight.w500)),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20, top: 30),
                    padding: EdgeInsets.only(left: 20, right: 15),
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
                    child: TextField(
                      style: TextStyle(
                        color: Themes.light.primaryColor,
                      ),
                      cursorColor: Themes.light.primaryColor,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(right: -15),
                        icon: Icon(
                          Icons.phone_android,
                          color: Themes.light.primaryColor,
                        ),
                        hintText: "رقم الهاتف 2",
                        hintStyle: GoogleFonts.cairo(
                            textStyle: TextStyle(
                                color: Themes.light.primaryColor,
                                fontWeight: FontWeight.w500)),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            /////////////// العنوان  ///////////////////
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
                //       color: Color(0xffEEEEEE)
                //       )
                // ]
              ),
              alignment: Alignment.center,
              child: TextField(
                style: TextStyle(
                  color: Themes.light.primaryColor,
                ),
                cursorColor: Themes.light.primaryColor,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.location_on,
                    color: Themes.light.primaryColor,
                  ),
                  hintText: "العنوان",
                  hintStyle: GoogleFonts.cairo(
                      textStyle: TextStyle(
                          color: Themes.light.primaryColor,
                          fontWeight: FontWeight.w500)),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),

            /////////////// كلمة المرور  ///////////////////
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
                style: TextStyle(
                  color: Themes.light.primaryColor,
                ),
                obscureText: true,
                cursorColor: Themes.light.primaryColor,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.vpn_key,
                    color: Themes.light.primaryColor,
                  ),
                  hintText: "كلمة المرور",
                  hintStyle: GoogleFonts.cairo(
                      textStyle: TextStyle(
                          color: Themes.light.primaryColor,
                          fontWeight: FontWeight.w500)),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),

            /////////////// تأكيد كلمة المرور  ///////////////////
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
                style: TextStyle(
                  color: Themes.light.primaryColor,
                ),
                obscureText: true,
                cursorColor: Themes.light.primaryColor,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.vpn_key,
                    color: Themes.light.primaryColor,
                  ),
                  hintText: "تأكيد كلمة المرور",
                  hintStyle: GoogleFonts.cairo(
                      textStyle: TextStyle(
                          color: Themes.light.primaryColor,
                          fontWeight: FontWeight.w500)),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),

            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 0, right: 10, top: 15),
                  // padding: EdgeInsets.only(left: 20, right: 20),
                  child: new Checkbox(
                      value: _value,
                      activeColor: Themes.light.primaryColor,
                      onChanged: (val) {
                        setState(() {
                          if (val == true) {
                            _value = true;
                          } else {
                            _value = false;
                          }
                        });
                      }),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => terms()),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 0, right: 0, top: 15),
                    // alignment: Alignment.bottomRight,
                    child: Text(
                      "أوافق علي شروط الخدمة",
                      style: GoogleFonts.cairo(
                          textStyle: TextStyle(
                              fontSize: 14, color: _color  ? Themes.light_white : Themes.light_black)),
                    ),
                  ),
                )
              ],
            ),

            GestureDetector(
              onTap: () {},
              child: Container(
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 40),
                  height: 54,
                  alignment: Alignment.center,
                  //  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      (Color.fromARGB(255, 96, 55, 134)),
                      (Color.fromARGB(255, 149, 102, 192))
                    ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                    borderRadius: BorderRadius.circular(50),
                    // boxShadow: [
                    //   BoxShadow(
                    //       offset: Offset(0, 10),
                    //       blurRadius: 50,
                    //       color: Color(0xffEEEEEE))
                    // ]
                  ),
                  child: Text("تسجيل",
                      style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                          color: Themes.light_white,
                          fontWeight: FontWeight.bold,
                        ),
                      ))),
            ),
          ],
        ),
      )),
    );
  }
}
