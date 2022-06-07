import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_delivery/coponents/Api.dart';
import 'package:pro_delivery/coponents/MyButton.dart';
import 'package:pro_delivery/coponents/MyInputField.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:pro_delivery/pages/homePages.dart';
import 'dart:ui' as ui;
import '../coponents/darkMode.dart';
import 'package:http/http.dart' as http;

class details_order extends StatefulWidget {
  details_order({Key? key}) : super(key: key);

  @override
  State<details_order> createState() => _details_orderState();
}

class _details_orderState extends State<details_order> {
  final _Storage = GetStorage();
  var _color = false;
  var detailsOrder = {};
  var idOrder = "";
  List<dynamic> branche = [];
  List<dynamic> dlyPrices = [];

  var customerPhone1 = TextEditingController();
  var storeName = TextEditingController();
  var recieverPhone1 = TextEditingController();
  var recieverPhone2 = TextEditingController();
  var address = TextEditingController();
  var packagePrice = TextEditingController();
  var packageNumber = TextEditingController();
  var note = TextEditingController();
  String brancheName = "";
  String cityName = "";
  String cityID = "";
  String fromBranchID = "b43936e6-4f2c-4f21-a308-9ca99c56faeb";
  var token = "";
  String fromBranchName = "";

  bool visible_lodding = false;
  bool visible_body = false;
  bool visible_branch_lodding = false;
  bool visible_branch = false;
  bool visible_city_lodding = false;
  bool visible_city = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    idOrder = ModalRoute.of(context)!.settings.arguments as String;

    Details_Order();
    // delivery_Prices();
  }

  @override
  void initState() {
    super.initState();
    _color = _Storage.read("isDarkMode");

    token = _Storage.read("token");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: MyInput(
                  //         title: "كود الطرد",
                  //         hint: "",
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 12,
                  //     ),
                  //     Expanded(
                  //       child: MyInput(
                  //         title: "الفرع",
                  //         hint: "",
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  Visibility(
                    visible: visible_body,
                    child: Row(
                      children: [
                        Expanded(
                          child: MyInput(
                            controller: recieverPhone1,
                            title: "رقم المستلم",
                            hint: "",
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: MyInput(
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
                            title: "رقم المرسل 2",
                            hint: "",
                          ),
                        ),
                      ],
                    ),
                  ),

                  Visibility(
                      visible: visible_body,
                      child: MyInput(
                          controller: storeName,
                          title: "اسم الصفحة",
                          hint: "")),

                  Visibility(
                    visible: visible_body,
                    child: Row(
                      children: [
                        Expanded(
                          child: MyInput(
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
                      controller: address,
                      title: "عنوان المستلم",
                      hint: "",
                    ),
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
                                  color: Get.isDarkMode
                                      ? Themes.dark_white
                                      : Themes.light.primaryColor),
                            ),
                          ),
                          Container(
                            height: 52,
                            margin: EdgeInsets.only(top: 8.0),
                            padding: EdgeInsets.only(right: 14),
                            decoration: BoxDecoration(
                                color: Get.isDarkMode
                                    ? Themes.dark_primary
                                    : Colors.grey[300],
                                border: Border.all(
                                    color: Get.isDarkMode
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
                                      cityName = "";
                                      delivery_Prices();
                                    });
                                  },

                                  //show selected item
                                  selectedItem: this.brancheName,
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
                                  color: Get.isDarkMode
                                      ? Themes.dark_white
                                      : Themes.light.primaryColor),
                            ),
                          ),
                          Container(
                            height: 52,
                            margin: EdgeInsets.only(top: 8.0),
                            padding: EdgeInsets.only(right: 14),
                            decoration: BoxDecoration(
                                color: Get.isDarkMode
                                    ? Themes.dark_primary
                                    : Colors.grey[300],
                                border: Border.all(
                                    color: Get.isDarkMode
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
                                  selectedItem: this.cityName,
                                ),
                              ),
                            ]),
                          )
                        ],
                      ),
                    ),
                  ),

                  Visibility(
                      visible: visible_body,
                      child:
                          MyInput(controller: note, title: "ملاحظة", hint: "")),
                  SizedBox(
                    height: 30,
                  ),

                  Visibility(
                    visible: visible_body,
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                Edit();
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
                                "تعديل",
                                style: GoogleFonts.cairo(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                delete();
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
                                "حذف",
                                style: GoogleFonts.cairo(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        ),
                      ],
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
                    color: Get.isDarkMode
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
                          ? Themes.dark_white
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
          Uri.parse(api().url + api().deliveryPrices + fromBranchID);
      print(urlDeliveryPrices);
      var response = await http.get(
        urlDeliveryPrices,
        // headers: {
        //   "Authorization": "Bearer $token",
        // },
      );
      var responsebody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          dlyPrices = responsebody['data']['cites'];
          branche = responsebody['data']['branches'];
          visible_branch = true;
          visible_branch_lodding = false;
          visible_city = true;
          visible_city_lodding = false;
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

  ///////////////////////////api Details_Order ///////////////////////////////////////////////

  Future<void> Details_Order() async {
    try {
      visible_lodding = true;
      visible_city = false;
      visible_branch = false;

      var urlOrder = Uri.parse(api().url + api().order);
      var response = await http.get(
        urlOrder,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      var responsebody = jsonDecode(response.body);
      setState(() {
        detailsOrder = responsebody['data'][0];
      });

      if (response.statusCode == 200) {
        customerPhone1.text = detailsOrder['customerPhone1'].toString();
        storeName.text = detailsOrder['storeName'].toString();
        recieverPhone1.text = detailsOrder['recieverPhone1'].toString();
        recieverPhone2.text = detailsOrder['recieverPhone2'].toString();
        address.text = detailsOrder['address'].toString();
        packagePrice.text = detailsOrder['packagePrice'].toString();
        packageNumber.text = detailsOrder['packageNumber'].toString();
        note.text = detailsOrder['note'].toString();
        this.brancheName = detailsOrder['fromBranchName'].toString();
        this.cityName = detailsOrder['cityName'].toString();
        this.cityID = detailsOrder['cityID'].toString();
        this.fromBranchID = detailsOrder['fromBranchID'].toString();
        // this.fromBranchName = detailsOrder['fromBranchName'].toString();

        visible_lodding = false;
        visible_body = true;
        visible_branch_lodding = true;
      }
    } on SocketException {
      setState(() {
        visible_lodding = false;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => homePagess()),
        );
      });

      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     backgroundColor: Color.fromARGB(255, 118, 82, 153),
      //     content: Directionality(
      //       textDirection: TextDirection.rtl,
      //       child: Text(
      //         "خطأ في الاتصال بالانترنت",
      //         style: GoogleFonts.cairo(
      //             textStyle:
      //                 TextStyle(fontSize: 14, color: Themes.light_white)),
      //       ),
      //     )));
    } catch (ex) {
      visible_lodding = false;
    }
  }

  ///////////////////////////api put ///////////////////////////////////////////////

  Future<void> Edit() async {
    try {
      visible_lodding = true;
      visible_body = false;
      visible_city = false;
      visible_branch = false;

      var _body = {
        'id': this.idOrder,
        'customerPhone1': customerPhone1.text.toString(),
        'storeName': storeName.text.toString(),
        'recieverPhone1': recieverPhone1.text.toString(),
        'recieverPhone2': recieverPhone2.text.toString(),
        'address': address.text.toString(),
        'cityID': this.cityID,
        'customerCode': "00765", // من غير الكود هذا تختفي الطلبية
        'fromBranchID': this.fromBranchID,
        'packagePrice': packagePrice.text.toString(),
        'packageNumber': packageNumber.text.toString(),
        'note': note.text.toString(),
        'fromBranchName': this.fromBranchName,
        // 'recieverName': ""
      };

      print(_body);
      var urlAdd = Uri.parse(api().url + api().addOrder);
      var response = await http.put(
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
        visible_city = true;
        visible_branch = true;
      }
    } on SocketException {
      setState(() {
        visible_lodding = false;
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
      visible_lodding = false;
    }
  }

  ///////////////////////////api delete ///////////////////////////////////////////////

  Future<void> delete() async {
    try {
      visible_lodding = true;
      visible_body = false;
      visible_city = false;
      visible_branch = false;

      var urlAdd = Uri.parse(api().url + api().addOrder + "/" + idOrder);
      var response = await http.delete(
        urlAdd,
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
