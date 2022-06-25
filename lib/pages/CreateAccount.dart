import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_delivery/coponents/Api.dart';
import 'package:pro_delivery/coponents/darkMode.dart';
import 'package:pro_delivery/pages/Gmail.dart';
import 'package:pro_delivery/pages/Terms.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class createAccount extends StatefulWidget {
  createAccount({Key? key}) : super(key: key);

  @override
  State<createAccount> createState() => _createAccountState();
}

class _createAccountState extends State<createAccount> {
  var _value = false;
  final _Storage = GetStorage();
  var _color = true;
  List<dynamic> branche = [];
  var fromBranchID = "";
  var fromBranchName = "";
  bool visible_branch_lodding = true;
  bool visible_branch = false;
  bool visible_login = true;
  bool visible_ = false;
  var token = "";

  var name = TextEditingController();
  var StoreName = TextEditingController();
  var email = TextEditingController();
  var phone1 = TextEditingController();
  var phone2 = TextEditingController();
  var address = TextEditingController();
  var password = TextEditingController();
  var passwordHash = TextEditingController();

  @override
  void initState() {
    super.initState();
    _color = _Storage.read("isDarkMode");
    // token = _Storage.read("token");
    Branches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _color ? Themes.dark_primary : Themes.light_primary,
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
                // gradient: LinearGradient(colors: [
                //   (Color.fromARGB(255, 85, 51, 117)),
                //   (Color.fromARGB(255, 118, 82, 153))
                // ], begin: Alignment.topCenter, end: Alignment.bottomCenter)
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
                      "إنشاء حساب",
                      style: GoogleFonts.cairo(
                          textStyle: TextStyle(
                              fontSize: 20, color: Themes.light_white)),
                    ),
                  )
                ],
              )),
            ),

            /////// ------------ DropdownSearch branch ------------ ////////

            Visibility(
                visible: visible_branch_lodding,
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Center(
                      child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Themes.light.primaryColor),
                  )),
                )),

            Visibility(
              visible: visible_branch,
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 70),
                padding: EdgeInsets.only(left: 20, right: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey[200],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 52,
                      // margin: EdgeInsets.only(top: 4.0),
                      padding: EdgeInsets.only(right: 20),
                      // decoration: BoxDecoration(
                      //     color:
                      //         _color ? Themes.dark_primary : Colors.grey[300],
                      //     border: Border.all(
                      //         color: _color
                      //             ? Themes.dark_white
                      //             : Themes.light.primaryColor,
                      //         width: 1.0),
                      //     borderRadius: BorderRadius.circular(5)),
                      child: Row(children: [
                        Expanded(
                          child: DropdownSearch<String>(
                            popupBackgroundColor: _color
                                ? Themes.dark_primary
                                : Themes.light_primary,

                            emptyBuilder: (context, searchEntry) => Center(
                                child: Text('لايوجد',
                                    style: TextStyle(
                                        color: Themes.light.primaryColor))),

                            // autoFocusSearchBox: true,

                            searchBoxDecoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Themes.light.primaryColor,
                                  width: 2,
                                )),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Themes.light.primaryColor,
                                  width: 2,
                                )),
                                hintTextDirection: TextDirection.rtl,
                                hintText: "ابحث عن المكتب"),

                            searchBoxStyle: GoogleFonts.cairo(
                                textStyle: TextStyle(

                                    // decorationColor: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: _color
                                        ? Themes.dark_white
                                        : Themes.light_black)),

                            dropdownSearchTextAlignVertical:
                                TextAlignVertical.bottom,
                            dropdownSearchTextAlign: TextAlign.left,

                            dropdownSearchBaseStyle:
                                TextStyle(fontFamily: 'MeQuran2'),
                            showSearchBox: true,
                            mode: Mode.DIALOG,
                            dropdownSearchDecoration: InputDecoration(
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: _color
                                      ? Themes.dark_white
                                      : Themes.light_black),
                              // hintText: "المكتب",
                              // prefix: Icon(

                              //   Icons.search,
                              //   color: Colors.black45,
                              // ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.white,
                                width: 0,
                              )),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.white,
                                width: 0,
                              )),
                            ),

                            // mode: Mode.DIALOG,
                            //to show search box
                            // showSearchBox: true,
                            showSelectedItem: true,
                            //list of dropdown items
                            //  dropdownBuilder: _style,
                            dropdownBuilder: _customDropDownAddress,
                            popupItemBuilder: _style1,
                            items: List<String>.from(
                                branche.map((e) => e['name'])),
                            // label: "Country",
                            onChanged: (value) {
                              for (var i = 0; i < branche.length; i++) {
                                if (branche[i]['name'] == value) {
                                  this.fromBranchID = branche[i]['id'];
                                  // this.fromBranchName = branche[i]['name'];
                                }
                              }
                            },

                            //show selected item
                            selectedItem: this.fromBranchName,
                            // hint: "لال",
                          ),
                        ),
                      ]),
                    )
                  ],
                ),
              ),
            ),

            /////////////// الإسم  ///////////////////
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 30),
              padding: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
              ),
              alignment: Alignment.center,
              child: TextField(
                controller: name,
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

            /////////////// اسم المتجر  ///////////////////
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 30),
              padding: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
              ),
              alignment: Alignment.center,
              child: TextField(
                controller: StoreName,
                style: TextStyle(
                  color: Themes.light.primaryColor,
                ),
                cursorColor: Themes.light.primaryColor,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.store,
                    color: Themes.light.primaryColor,
                  ),
                  hintText: "اسم الصفحة",
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
                controller: email,
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
                      controller: phone1,
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
                      controller: phone2,
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
                controller: address,
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
                controller: password,
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
                controller: passwordHash,
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

                  child: Theme(
                    data: ThemeData(
                      unselectedWidgetColor: _color
                          ? Themes.dark_white
                          : Themes.light.primaryColor, // Your color
                    ),
                    child: Checkbox(
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
                ),
                Container(
                    margin: EdgeInsets.only(left: 0, right: 0, top: 15),
                    // alignment: Alignment.bottomRight,

                    child: Row(
                      children: [
                        Text(
                          "أوافق علي",
                          style: GoogleFonts.cairo(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  color: _color
                                      ? Themes.light_white
                                      : Themes.light_black)),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => terms()),
                            );
                          },
                          child: Text(
                            "شروط الخدمة",
                            style: GoogleFonts.cairo(
                                textStyle: TextStyle(
                              fontSize: 14,
                              color: _color
                                  ? Themes.light_grey
                                  : Themes.light.primaryColor,
                              decoration: TextDecoration.underline,
                            )),
                          ),
                        ),
                      ],
                    )),
              ],
            ),

            Visibility(
                visible: visible_,
                child: Container(
                  margin: EdgeInsets.only(top: 20, bottom: 30),
                  child: Center(
                      child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Themes.light.primaryColor),
                  )),
                )),

            Visibility(
              visible: visible_login,
              child: GestureDetector(
                onTap: () {
                  Register();
                },
                child: Container(
                    margin: EdgeInsets.only(
                        left: 20, right: 20, top: 30, bottom: 40),
                    height: 54,
                    alignment: Alignment.center,
                    //  width: double.infinity,
                    decoration: BoxDecoration(
                      color: Themes.light.primaryColor,
                      // gradient: LinearGradient(colors: [
                      //   (Color.fromARGB(255, 96, 55, 134)),
                      //   (Color.fromARGB(255, 149, 102, 192))
                      // ], begin: Alignment.centerLeft, end: Alignment.centerRight),
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
            ),
          ],
        ),
      )),
    );
  }

  Widget _customDropDownAddress(
      BuildContext context, _addressFilteredName, String itemDesignation) {
    return Container(
        child: Text(_addressFilteredName.toString(),
            // textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
                textStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _color
                        ? Themes.light.primaryColor
                        : Themes.light.primaryColor))));
  }

  Widget _style1(BuildContext context, String? item, bool isSelected) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: !isSelected
              ? null
              : BoxDecoration(
                  border: Border.all(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(5),
                  color: Themes.light.primaryColor,
                ),
          child: Text(
            item!,
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
                textStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: isSelected ? FontWeight.bold : null,
                    color: isSelected
                        ? Themes.light_white
                        : _color == true
                            ? Themes.dark_white
                            : Themes.light_black)),
          ),
        ),
      ),
    );
  }

  ///////////////////////////api Branches ///////////////////////////////////////////////

  Future<void> Branches() async {
    try {
      visible_branch_lodding = true;
      // visible_lodding_net = true;
      var urlBranches = Uri.parse(api().url + api().Branches);
      var response = await http.get(
        urlBranches,
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      var responsebody = jsonDecode(response.body);
      setState(() {
        branche = responsebody['data'];
      });

      if (response.statusCode == 200) {
        this.fromBranchID = branche[0]['id'];
        this.fromBranchName = branche[0]['name'];

        visible_branch_lodding = false;
        visible_branch = true;
        // visible_lodding_net = false;
        // visible_body = true;
        // net = false;
      }
    } on SocketException {
      setState(() {
        // visible_lodding = false;
        // visible_lodding_net = false;

        // net = true;
      });
    } catch (ex) {
      // visible_lodding = false;
      // visible_lodding_net = false;
    }
  }

  Future<void> Register() async {
    try {
      if (name.text == "") {
        ScaffoldMessenger.of(context).clearSnackBars();

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Themes.showSnackBarColor,
            content: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                "الرجاء إدخال الإسم",
                style: GoogleFonts.cairo(
                    textStyle:
                        TextStyle(fontSize: 14, color: Themes.light_white)),
              ),
            )));
      } else if (StoreName.text == "") {
        ScaffoldMessenger.of(context).clearSnackBars();

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Themes.showSnackBarColor,
            content: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                "الرجاء إدخال اسم الصفحة",
                style: GoogleFonts.cairo(
                    textStyle:
                        TextStyle(fontSize: 14, color: Themes.light_white)),
              ),
            )));
      } else if (email.text == "") {
        ScaffoldMessenger.of(context).clearSnackBars();

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Themes.showSnackBarColor,
            content: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                "الرجاء إدخال البريد الإلكتروني",
                style: GoogleFonts.cairo(
                    textStyle:
                        TextStyle(fontSize: 14, color: Themes.light_white)),
              ),
            )));
      } else if (!EmailValidator.validate(email.text)) {
        ScaffoldMessenger.of(context).clearSnackBars();

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Themes.showSnackBarColor,
            content: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                "البريد الإلكتروني غير صحيح",
                style: GoogleFonts.cairo(
                    textStyle:
                        TextStyle(fontSize: 14, color: Themes.light_white)),
              ),
            )));
      } else if (phone1.text == "") {
        ScaffoldMessenger.of(context).clearSnackBars();

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Themes.showSnackBarColor,
            content: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                "الرجاء إدخال رقم الهاتف",
                style: GoogleFonts.cairo(
                    textStyle:
                        TextStyle(fontSize: 14, color: Themes.light_white)),
              ),
            )));
      } else if (address.text == "") {
        ScaffoldMessenger.of(context).clearSnackBars();

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Themes.showSnackBarColor,
            content: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                "الرجاء إدخال العنوان",
                style: GoogleFonts.cairo(
                    textStyle:
                        TextStyle(fontSize: 14, color: Themes.light_white)),
              ),
            )));
      } else if (password.text == "") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Themes.showSnackBarColor,
            content: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                "الرجاء إدخال كلمة المرور",
                style: GoogleFonts.cairo(
                    textStyle:
                        TextStyle(fontSize: 14, color: Themes.light_white)),
              ),
            )));
      } else if (passwordHash.text == "") {
        ScaffoldMessenger.of(context).clearSnackBars();

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Themes.showSnackBarColor,
            content: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                "الرجاء تأكيد كلمة المرور",
                style: GoogleFonts.cairo(
                    textStyle:
                        TextStyle(fontSize: 14, color: Themes.light_white)),
              ),
            )));
      } else if (passwordHash.text != password.text) {
        ScaffoldMessenger.of(context).clearSnackBars();

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Themes.showSnackBarColor,
            content: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                "كلمة المرور غير متطابقة",
                style: GoogleFonts.cairo(
                    textStyle:
                        TextStyle(fontSize: 14, color: Themes.light_white)),
              ),
            )));
      } else if (_value == false) {
        ScaffoldMessenger.of(context).clearSnackBars();

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Themes.showSnackBarColor,
            content: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                "الرجاء الموافقة على شروط الخدمة",
                style: GoogleFonts.cairo(
                    textStyle:
                        TextStyle(fontSize: 14, color: Themes.light_white)),
              ),
            )));
      } else {
        try {
          setState(() {
            visible_login = false;
            visible_ = true;
          });

          var _body = {
            "StoreName": StoreName.text.toString(),
            "BranchID": this.fromBranchID,
            "name": name.text,
            "email": email.text,
            "phone1": phone1.text,
            "phone2": phone2.text,
            "address": address.text,
            "passwordHash": passwordHash.text
          };
          var urlLogin = Uri.parse(
              api().url + api().Register + api().URLFrontend + "EmailConfirm");

          var response = await http.post(
            urlLogin,
            body: jsonEncode(_body),
            headers: {
              "Authorization": "Bearer",
              "Accept": "application/json",
              "content-type": "application/json"
            },
          );
          var responsebody = jsonDecode(response.body);

          if (response.statusCode == 200) {
            setState(() {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => gmail()));
              visible_login = true;
              visible_ = false;
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
              visible_login = true;
              visible_ = false;
            });
          }
        } on SocketException {
          setState(() {
            visible_login = true;
            visible_ = false;
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
          visible_login = true;
          visible_ = false;
        }
      }
    } on SocketException {
    } catch (ex) {}
  }
}
