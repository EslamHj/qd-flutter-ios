import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pro_delivery/coponents/MyInputField.dart';
import 'package:pro_delivery/pages/Suppliers/homeSuppliers.dart';
import 'package:pro_delivery/pages/homePages.dart';
import 'dart:ui' as ui;
import '../../coponents/darkMode.dart';
import 'package:http/http.dart' as http;
import 'package:pro_delivery/coponents/Api.dart';
import 'dart:convert';

class details_Suppliers extends StatefulWidget {
  details_Suppliers({Key? key}) : super(key: key);

  @override
  State<details_Suppliers> createState() => _details_SuppliersState();
}

class _details_SuppliersState extends State<details_Suppliers> {
  final _Storage = GetStorage();
  var _color = false;
  var detailsOrder = {};
  String IdOrder = "";
  var statuses = [];
  var statusesID = "";
  var statusesName = "";
  String fromBranchName = "";
  var token = "";

  bool visible_lodding = true;
  bool visible_body = false;

  var supplierName = TextEditingController();
  var barCode = TextEditingController();
  var status = TextEditingController();
  var customerPhone1 = TextEditingController();
  var customerPhone2 = TextEditingController();
  var recieverPhone1 = TextEditingController();
  var recieverPhone2 = TextEditingController();
  var packagePrice = TextEditingController();
  var packageNumber = TextEditingController();
  var deliveryPrice = TextEditingController();
  var address = TextEditingController();
  var cityName = TextEditingController();
  var note = TextEditingController();
  var orderDescription = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    IdOrder = ModalRoute.of(context)!.settings.arguments as String;
    token = _Storage.read("token").toString();
    details_movements();
  }

  @override
  void initState() {
    super.initState();
    _color = _Storage.read("isDarkMode");
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

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
                     
                        readOnly: false,
                        controller: note,
                        widget: null,
                        color: _color,
                        title: "ملاحظة",
                        hint: ""),
                  ),

                  /////// ------------ DropdownSearch statuses ------------ ////////
                  Visibility(
                    visible: visible_body,
                    child: Container(
                      margin: EdgeInsets.only(top: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "الحالات",
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
                                  popupBackgroundColor: _color
                                      ? Themes.dark_primary
                                      : Themes.light_primary,

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
                                      statuses.map((e) => e['name'])),
                                  // label: "Country",
                                  onChanged: (value) {
                                    for (var i = 0; i < statuses.length; i++) {
                                      if (statuses[i]['name'] == value) {
                                        this.statusesID = statuses[i]['id'];
                                        this.statusesName = statuses[i]['name'];
                                      }
                                    }
                                    setState(() {});
                                  },

                                  //show selected item
                                  selectedItem: this.fromBranchName,
                                ),
                              ),
                            ]),
                          )
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 35,
                  ),

                  Visibility(
                    visible: visible_body,
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
                    height: 35,
                  ),

                     Visibility(
                    visible: visible_body,
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Themes.light.primaryColor, width: 0.3),
                            borderRadius: BorderRadius.circular(5)),
                        child: SizedBox(width: _width)),
                  ),

                  Visibility(
                    visible: visible_body,
                    child: Row(
                      children: [
                        Expanded(
                          child: MyInput(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[a-z A-Z á-ú Á-Ú 0-9]")),
                            ],
                            readOnly: true,
                            controller: barCode,
                            color: _color,
                            title: "كود الطرد",
                            hint: "",
                          ),
                        ),
                        // SizedBox(
                        //   width: 12,
                        // ),
                        // Expanded(
                        //   child: MyInput(
                        //     inputFormatters: [
                        //       FilteringTextInputFormatter.allow(
                        //           RegExp("[a-z A-Z á-ú Á-Ú 0-9]")),
                        //     ],
                        //     readOnly: true,
                        //     controller: status,
                        //     color: _color,
                        //     title: "حالة الطرد",
                        //     hint: "",
                        //   ),
                        // ),
                      ],
                    ),
                  ),

                  Visibility(
                    visible: visible_body,
                    child: Row(
                      children: [
                        Expanded(
                          child: MyInput(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[a-z A-Z á-ú Á-Ú 0-9]")),
                            ],
                            readOnly: true,
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
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[a-z A-Z á-ú Á-Ú 0-9]")),
                            ],
                            readOnly: true,
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
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[a-z A-Z á-ú Á-Ú 0-9]")),
                            ],
                            readOnly: true,
                            color: _color,
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
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[a-z A-Z á-ú Á-Ú 0-9]")),
                            ],
                            readOnly: true,
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
                          flex: 2,
                          child: MyInput(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[a-z A-Z á-ú Á-Ú 0-9]")),
                            ],
                            readOnly: true,
                            controller: packagePrice,
                            color: _color,
                            title: "سعر الطرد",
                            hint: "",
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          flex: 2,
                          child: MyInput(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[a-z A-Z á-ú Á-Ú 0-9]")),
                            ],
                            readOnly: true,
                            controller: deliveryPrice,
                            color: _color,
                            title: "سعر التوصيل",
                            hint: "",
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          flex: 1,
                          child: MyInput(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[a-z A-Z á-ú Á-Ú 0-9]")),
                            ],
                            readOnly: true,
                            controller: packageNumber,
                            color: _color,
                            title: "العدد",
                            hint: "",
                          ),
                        ),
                      ],
                    ),
                  ),

                  Visibility(
                    visible: visible_body,
                    child: MyInput(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp("[a-z A-Z á-ú Á-Ú 0-9]")),
                      ],
                      readOnly: true,
                      controller: address,
                      color: _color,
                      title: "عنوان المستلم",
                      hint: "",
                    ),
                  ),

                  Visibility(
                    visible: visible_body,
                    child: MyInput(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp("[a-z A-Z á-ú Á-Ú 0-9]")),
                      ],
                      readOnly: true,
                      controller: cityName,
                      color: _color,
                      title: "المدينة",
                      hint: "",
                    ),
                  ),

                  Visibility(
                      visible: visible_body,
                      child: MyInput(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[a-z A-Z á-ú Á-Ú 0-9]")),
                          ],
                          readOnly: true,
                          color: _color,
                          controller: orderDescription,
                          title: "الوصف",
                          hint: "")),

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
                    color: _color ? Themes.dark_white : Themes.light_black))));
  }

  Widget _style1(BuildContext context, String? item, bool isSelected) {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
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

  _appBar() {
    return AppBar(
      backgroundColor: Themes.light.primaryColor,
      actions: <Widget>[
        Container(
            margin: EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                api().urlIcon,
                height: 50,
                width: 47,
                fit: BoxFit.cover,
              ),
            )),
      ],
    );
  }

  ///////////////////////////api details_movements ///////////////////////////////////////////////

  Future<void> details_movements() async {
    try {
      var urlOrder = Uri.parse(api().url + api().SupplierOrder + IdOrder);
      var response = await http.get(
        urlOrder,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      var responsebody = jsonDecode(response.body);
      setState(() {
        detailsOrder = responsebody['data']['order'];
         statuses = responsebody['data']['statuses'];
      });

      if (response.statusCode == 200) {
        supplierName.text = detailsOrder['supplierName'].toString();
        barCode.text = detailsOrder['barCode'].toString();
        status.text = detailsOrder['status'].toString();
        customerPhone1.text =
            detailsOrder['customerPhone1'].toString() == 'null'
                ? ''
                : detailsOrder['customerPhone1'].toString();
        customerPhone2.text =
            detailsOrder['customerPhone2'].toString() == 'null'
                ? ''
                : detailsOrder['customerPhone2'].toString();
        recieverPhone1.text = detailsOrder['recieverPhone1'].toString();
        recieverPhone2.text =
            detailsOrder['recieverPhone2'].toString() == 'null'
                ? ''
                : detailsOrder['recieverPhone2'].toString();
        packagePrice.text = detailsOrder['packagePrice'].toString();
        packageNumber.text = detailsOrder['packageNumber'].toString();
        deliveryPrice.text = detailsOrder['deliveryPrice'].toString();
        address.text = detailsOrder['address'].toString() == 'null'
            ? ''
            : detailsOrder['address'].toString();
        cityName.text = detailsOrder['cityName'].toString();
        note.text = detailsOrder['note'].toString() == 'null'
            ? ''
            : detailsOrder['note'].toString();
        orderDescription.text =
            detailsOrder['orderDescription'].toString() == 'null'
                ? ''
                : detailsOrder['orderDescription'].toString();
        visible_lodding = false;
        visible_body = true;
      }
    } on SocketException {
      setState(() {
        visible_lodding = false;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => homePagess()),
        );
      });
    } catch (ex) {
      visible_lodding = false;
      visible_body = true;
    }
  }

  ///////////////////////////api put ///////////////////////////////////////////////

  Future<void> Edit() async {
    try {
      visible_lodding = true;
      visible_body = false;

      var _body = {
        "note": note.text.toString(),
        "statusId": this.statusesID,


      };

      var urlAdd = Uri.parse(api().url + api().EditOrder + IdOrder);
      var response = await http.put(
        urlAdd,
        body: jsonEncode(_body),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
          "content-type": "application/json"
        },
      );
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => homeSuppliers()),
        );
        visible_lodding = false;
        visible_body = true;
      }
    } on SocketException {
      setState(() {
        visible_lodding = false;
      });

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Themes.showSnackBarColor,
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
      visible_body = true;
    }
  }
}
