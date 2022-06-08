import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pro_delivery/coponents/Api.dart';
import 'package:pro_delivery/coponents/MyButton.dart';
import 'package:pro_delivery/coponents/MyInputField.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:pro_delivery/pages/Branches.dart';
import 'package:pro_delivery/pages/Delivery_Prices.dart';
import 'package:pro_delivery/pages/homePages.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;

import '../coponents/darkMode.dart';

class addOrder extends StatefulWidget {
  addOrder({Key? key}) : super(key: key);

  @override
  State<addOrder> createState() => _addOrderState();
}

class _addOrderState extends State<addOrder> {
  DateTime _selecteDate = DateTime.now();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _endTime = "00:00";
  int _selectedRemind = 5;
  List<int> remindlist = [5, 10, 15, 20];
  final _Storage = GetStorage();
  bool hintV = false;
  var _color = false;
  List<dynamic> branche = [];
  List<dynamic> dlyPrices = [];
  var cityID = "";
  var fromBranchID = "b43936e6-4f2c-4f21-a308-9ca99c56faeb";
  var fromBranchName = "";

  // var student = new Map();
  // var order = {
  //   "customerPhone1" : ""
  // };
  var customerPhone1 = TextEditingController();
  var customerPhone2 = TextEditingController();
  var storeName = TextEditingController();
  var recieverPhone1 = TextEditingController();
  var recieverPhone2 = TextEditingController();
  var address = TextEditingController();
  var packagePrice = TextEditingController();
  var packageNumber = TextEditingController();
  var note = TextEditingController();
  var orderDescription = TextEditingController();

  var token = "";

  bool visible_lodding = false;
  bool visible_body = true;
  bool visible_branch_lodding = true;
  bool visible_branch = false;
  bool visible_city_lodding = false;
  bool visible_city = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // branche = ModalRoute.of(context)!.settings.arguments as List ;
    // dlyPrices = ModalRoute.of(context)!.settings.arguments as List;

    // print(dlyPrices);

    print(_Storage.read("token"));
  }

  @override
  void initState() {
    super.initState();
    try {
    _color = _Storage.read("isDarkMode");
    token = _Storage.read("token");
        delivery_Prices();

    

    } catch(ex){

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: _color ? Themes.dark_primary : Themes.light_primary,
        appBar: _appBar(),
        body: Directionality(
            textDirection: ui.TextDirection.rtl,
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Visibility(
                      visible: visible_lodding,
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Center(
                            child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Themes.light.primaryColor),
                        )),
                      )),

                  SizedBox(
                    height: 5,
                  ),

                  Visibility(
                      visible: visible_body,
                      child: MyInput(
                          color: _color,
                          controller: storeName,
                          title: "اسم الصفحة",
                          hint: "")),
                  Visibility(
                    visible: visible_body,
                    child: Row(
                      children: [
                        Expanded(
                          child: MyInput(
                            color: _color,
                            controller: customerPhone1,
                            title: "رقم المرسل",
                            hint: "",
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: MyInput(
                            controller: customerPhone2,
                            color: _color,
                            title: "رقم المرسل 2",
                            hint: "",
                          ),
                        ),
                      ],
                    ),
                  ),

                  Visibility(
                    visible: visible_body,
                    child: Row(
                      children: [
                        Expanded(
                          child: MyInput(
                            color: _color,
                            controller: recieverPhone1,
                            title: "رقم المستلم",
                            hint: hintV == false ? "" : "يجب الملء",
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: MyInput(
                            color: _color,
                            controller: recieverPhone2,
                            title: "رقم المستلم 2",
                            hint: "",
                          ),
                        ),
                      ],
                    ),
                  ),

                  Visibility(
                    visible: visible_body,
                    child: Row(
                      children: [
                        Expanded(
                          child: MyInput(
                            color: _color,
                            controller: packagePrice,
                            title: "سعر الطرد",
                            hint: "",
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: MyInput(
                            color: _color,
                            controller: packageNumber,
                            title: "عدد العناصر",
                            hint: "",
                          ),
                        ),
                      ],
                    ),
                  ),

                  Visibility(
                    visible: visible_body,
                    child: MyInput(
                      color: _color,
                      controller: address,
                      title: "عنوان المستلم",
                      hint: "",
                    ),
                  ),

                     Visibility(
                      visible: visible_body,
                      child: MyInput(
                          color: _color,
                          controller: orderDescription,
                          title: "الوصف",
                          hint: "")),

                             Visibility(
                      visible: visible_body,
                      child: MyInput(
                          color: _color,
                          controller: note,
                          title: "ملاحظة",
                          hint: "")),

                  // MyInput(
                  //   title: "Date",
                  //   hint: DateFormat.yMd().format(_selecteDate),
                  //   widget: IconButton(
                  //       icon: Icon(
                  //         Icons.calendar_today_rounded,
                  //         color: Themes.light.primaryColor,
                  //       ),
                  //       onPressed: () {
                  //         _getDateFromUser();
                  //       }),
                  // ),

                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: MyInput(
                  //         title: "start Time",
                  //         hint: _startTime,
                  //         widget: IconButton(
                  //             icon: Icon(
                  //               Icons.access_time_rounded,
                  //               color: Themes.light.primaryColor,
                  //             ),
                  //             onPressed: () {
                  //               _getTimeFromUser(isStarTime: true);
                  //             }),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 12,
                  //     ),
                  //     Expanded(
                  //       child: MyInput(
                  //         title: "End Time",
                  //         hint: _endTime,
                  //         widget: IconButton(
                  //             icon: Icon(
                  //               Icons.access_time_rounded,
                  //               color: Themes.light.primaryColor,
                  //             ),
                  //             onPressed: () {
                  //               _getTimeFromUser(isStarTime: false);
                  //             }),
                  //       ),
                  //     ),
                  //   ],
                  // ),

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
                      margin: EdgeInsets.only(top: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "المكتب",
                            style: GoogleFonts.cairo(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: _color
                                      ? Themes.dark_white
                                      : Themes.light.primaryColor),
                            ),
                          ),
                          Container(
                            height: 52,
                            margin: EdgeInsets.only(top: 8.0),
                            padding: EdgeInsets.only(right: 14),
                            decoration: BoxDecoration(
                                color: _color
                                    ? Themes.dark_primary
                                    : Colors.grey[300],
                                border: Border.all(
                                    color: _color
                                        ? Themes.dark_white
                                        : Themes.light.primaryColor,
                                    width: 1.0),
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(children: [
                              Expanded(
                                child: DropdownSearch<String>(
                                  emptyBuilder: (context, searchEntry) =>
                                      Center(
                                          child: Text('لايوجد',
                                              style: TextStyle(
                                                  color: Themes
                                                      .light.primaryColor))),

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
                                    hintTextDirection: ui.TextDirection.rtl,
                                  ),
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
                                  dropdownSearchTextAlign: TextAlign.right,

                                  dropdownSearchBaseStyle:
                                      TextStyle(fontFamily: 'MeQuran2'),
                                  showSearchBox: true,
                                  mode: Mode.DIALOG,
                                  dropdownSearchDecoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
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
                                        this.fromBranchName =
                                            branche[i]['name'];
                                      }
                                    }
                                    setState(() {
                                      visible_city_lodding = true;
                                      visible_city = false;

                                      delivery_Prices();
                                    });
                                  },

                                  //show selected item
                                  selectedItem: "",
                                ),
                              ),
                            ]),
                          )
                        ],
                      ),
                    ),
                  ),

/////// ------------ DropdownSearch city ------------ ////////
                  Visibility(
                      visible: visible_city_lodding,
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Center(
                            child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Themes.light.primaryColor),
                        )),
                      )),
                  Visibility(
                    visible: visible_city,
                    child: Container(
                      margin: EdgeInsets.only(top: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "المدينة",
                            style: GoogleFonts.cairo(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: _color
                                      ? Themes.dark_white
                                      : Themes.light.primaryColor),
                            ),
                          ),
                          Container(
                            height: 52,
                            margin: EdgeInsets.only(top: 8.0),
                            padding: EdgeInsets.only(right: 14),
                            decoration: BoxDecoration(
                                color: _color
                                    ? Themes.dark_primary
                                    : Colors.grey[300],
                                border: Border.all(
                                    color: _color
                                        ? Themes.dark_white
                                        : Themes.light.primaryColor,
                                    width: 1.0),
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(children: [
                              Expanded(
                                child: DropdownSearch<String>(
                                  emptyBuilder: (context, searchEntry) =>
                                      Center(
                                          child: Text('لايوجد',
                                              style: TextStyle(
                                                  color: Themes
                                                      .light.primaryColor))),
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
                                    hintTextDirection: ui.TextDirection.rtl,
                                  ),
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
                                  dropdownSearchTextAlign: TextAlign.center,

                                  dropdownSearchBaseStyle:
                                      TextStyle(fontFamily: 'MeQuran2'),
                                  showSearchBox: true,
                                  mode: Mode.DIALOG,
                                  dropdownSearchDecoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
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
                                      dlyPrices.map((e) => e['name'])),
                                  // label: "Country",
                                  onChanged: (value) {
                                    for (var i = 0; i < dlyPrices.length; i++) {
                                      if (dlyPrices[i]['name'] == value) {
                                        this.cityID = dlyPrices[i]['id'];
                                      }
                                    }
                                  },

                                  //show selected item
                                  selectedItem: "",
                                ),
                              ),
                            ]),
                          )
                        ],
                      ),
                    ),
                  ),

               
                  SizedBox(
                    height: 30,
                  ),

                  Visibility(
                    visible: visible_body,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          hintV = true;
                          add();
                        });
                      },
                      child: Container(
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Themes.light.primaryColor,
                        ),
                        child: Text(
                          "حفظ",
                          style: GoogleFonts.cairo(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 30,
                  ),
                ],
              )),
            )));
  }

  Widget _customDropDownAddress(
      BuildContext context, _addressFilteredName, String itemDesignation) {
    return Container(
        child: Text(_addressFilteredName.toString(),
            style: GoogleFonts.cairo(
                textStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _color
                        ? Themes.dark_white
                        : Themes.light_black))));
  }

  Widget _style1(BuildContext context, String? item, bool isSelected) {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          item!,
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(
              textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: isSelected ? FontWeight.bold : null,
                  color: isSelected
                      ? Themes.light_grey
                      : _color == true
                          ? Themes.light_black
                          : Themes.light_black)),
        ),
      ),
    );
  }

  _appBar() {
    return AppBar(
      backgroundColor: Themes.light.primaryColor,
      actions: <Widget>[
        Container(
            margin: EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                'assets/qd.png',
                height: 50,
                width: 47,
                fit: BoxFit.cover,
              ),
            )),
      ],
    );
  }

  ///////////////////////////api deliveryPrices ///////////////////////////////////////////////

  Future<void> delivery_Prices() async {
    try {
      // visible_ = true;
      var urlDeliveryPrices =
          Uri.parse(api().url + api().GetCitiesAndBranches + fromBranchID);
      print(urlDeliveryPrices);

      var response = await http.get(
      
          urlDeliveryPrices,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      var responsebody = jsonDecode(response.body);
      print(responsebody);
      if (response.statusCode == 200) {
        setState(() {
          dlyPrices = responsebody['data']['cities'];
          branche = responsebody['data']['branches'];
          visible_branch = true;
          visible_branch_lodding = false;
          visible_city = true;
          visible_city_lodding = false;
          // visible_ = false;
        //   _color == false
        // ? Get.changeTheme(Themes.light)
        // : Get.changeTheme(Themes.dark);
        });
      }
    } on SocketException {
      setState(() {
        // visible_ = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Color.fromARGB(255, 118, 82, 153),
          content: Directionality(
            textDirection: ui.TextDirection.rtl,
            child: Text(
              "خطأ في الاتصال بالانترنت",
              style: GoogleFonts.cairo(
                  textStyle:
                      TextStyle(fontSize: 14, color: Themes.light_white)),
            ),
          )));
    } on FormatException {
      setState(() {
        // visible_ = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Color.fromARGB(255, 118, 82, 153),
          content: Directionality(
            textDirection: ui.TextDirection.rtl,
            child: Text(
              "يوجد خطأ في البيانات",
              style: GoogleFonts.cairo(
                  textStyle:
                      TextStyle(fontSize: 14, color: Themes.light_white)),
            ),
          )));
    } catch (ex) {
      print(ex);
    }
  }

  ///////////////////////////api add ///////////////////////////////////////////////

  Future<void> add() async {
    try {
      visible_lodding = true;
      visible_body = false;
      visible_city = false;
      visible_branch = false;
      var _body = {
        'customerPhone1': customerPhone1.text.toString(),
        'customerPhone2': customerPhone2.text.toString(),
        'storeName': storeName.text.toString(),
        'recieverPhone1': recieverPhone1.text.toString(),
        'recieverPhone2': recieverPhone2.text.toString(),
        'address': address.text.toString(),
        'cityID': this.cityID,
        'fromBranchID': this.fromBranchID,
        'fromBranchName': this.fromBranchName ,
        'packagePrice': packagePrice.text.toString(),
        'packageNumber': packageNumber.text.toString() == "" ? 1 : packageNumber.text.toString(),
        'note': note.text.toString(),
        'orderDescription' : orderDescription.text.toString()
      };

      print(_body);
      var urlAdd = Uri.parse(api().url + api().addOrder);
      var response = await http.post(
        urlAdd,
        body: jsonEncode(_body),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
          "content-type": "application/json"
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => homePagess()),
        );
        visible_lodding = false;
        visible_body = true;
      }
    } on SocketException {
      setState(() {
        // visible_ = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Color.fromARGB(255, 118, 82, 153),
          content: Directionality(
            textDirection: ui.TextDirection.rtl,
            child: Text(
              "خطأ في الاتصال بالانترنت",
              style: GoogleFonts.cairo(
                  textStyle:
                      TextStyle(fontSize: 14, color: Themes.light_white)),
            ),
          )));
    } catch (ex) {
      print(ex);
    }
  }
}
