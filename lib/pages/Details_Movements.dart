import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_delivery/coponents/MyButton.dart';
import 'package:pro_delivery/coponents/MyInputField.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:pro_delivery/pages/homePages.dart';
import 'dart:ui' as ui;
import '../coponents/darkMode.dart';
import 'package:http/http.dart' as http;
import 'package:pro_delivery/coponents/Api.dart';
import 'dart:convert';

class details_movements extends StatefulWidget {
  details_movements({Key? key}) : super(key: key);

  @override
  State<details_movements> createState() => _details_movementsState();
}

class _details_movementsState extends State<details_movements> {
  final _Storage = GetStorage();
  var _color = false;
  var detailsOrder = {};
  String IdOrder = "";
  var activities = [];
  List<dynamic> branche = [];
  List<dynamic> dlyPrices = [];

  String fromBranchName = "";
  String cityID = "";
  String fromBranchID = "";
  var token = "";
  String branchName = "";

  bool visible_lodding = false;
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
    token = _Storage.read("token");
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
                      controller: supplierName,
                      color: _color,
                      title: "اسم المندوب",
                      hint: "",
                    ),
                  ),

                  Visibility(
                    visible: visible_body,
                    child: Row(
                      children: [
                        Expanded(
                          child: MyInput(
                            controller: barCode,
                            color: _color,
                            title: "كود الطرد",
                            hint: "",
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: MyInput(
                            controller: status,
                            color: _color,
                            title: "حالة الطرد",
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
                            hint: "",
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
                          flex: 2,
                          child: MyInput(
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
                      controller: address,
                      color: _color,
                      title: "عنوان المستلم",
                      hint: "",
                    ),
                  ),

                  Visibility(
                    visible: visible_body,
                    child: MyInput(
                      controller: cityName,
                      color: _color,
                      title: "المدينة",
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
                        controller: note,
                        color: _color,
                        title: "ملاحظة",
                        hint: ""),
                  ),
                  SizedBox(
                    height: 15,
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

                  SizedBox(
                    height: 15,
                  ),

                  ////////////////////// الحالات////////////////////

                  Visibility(
                    visible: visible_body,
                    child: Container(
                      height: 300,
                      width: double.infinity,
                      child: ListView.builder(
                          itemCount: activities.length,
                          itemBuilder: (context, i) {
                            return Container(
                              height: 45,
                              margin: EdgeInsets.only(top: 8.0),
                              padding: EdgeInsets.symmetric(horizontal: 14),
                              decoration: BoxDecoration(
                                color: Themes.light.primaryColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            // alignment: Alignment.topRight,
                                            margin: EdgeInsets.only(bottom: 4),
                                            child: Text(
                                                activities[i]['status']
                                                    .toString(),
                                                style: GoogleFonts.cairo(
                                                    textStyle: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Get.isDarkMode
                                                            ? Themes.dark_white
                                                            : Themes
                                                                .light_white))),
                                          ),
                                          // Container(
                                          //   alignment: Alignment.topRight,
                                          //   child: Text("ملاحظه",
                                          //       style: GoogleFonts.cairo(
                                          //           textStyle: TextStyle(
                                          //               fontSize: 10,
                                          //               fontWeight: FontWeight.w600,
                                          //               color: Get.isDarkMode
                                          //                   ? Themes.dark_white
                                          //                   : Themes.light_white))),
                                          // ),
                                        ]),
                                    Text(
                                        activities[i]['activityDate']
                                            .toString(),
                                        style: GoogleFonts.cairo(
                                            textStyle: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: Get.isDarkMode
                                                    ? Themes.dark_white
                                                    : Themes.light_white)))
                                  ]),
                            );
                          }),
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

  ///////////////////////////api details_movements ///////////////////////////////////////////////

  Future<void> details_movements() async {
    try {
      visible_lodding = true;
      var urlOrder = Uri.parse(api().url + api().Under_procedure_Id + IdOrder);
      var response = await http.get(
        urlOrder,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      var responsebody = jsonDecode(response.body);
      setState(() {
        detailsOrder = responsebody['data']['order'];
        activities = responsebody['data']['activities'];
      });

      if (response.statusCode == 200) {
        supplierName.text = detailsOrder['supplierName'].toString();
        barCode.text = detailsOrder['barCode'].toString();
        status.text = detailsOrder['status'].toString();
        customerPhone1.text = detailsOrder['customerPhone1'].toString();
        customerPhone2.text = detailsOrder['customerPhone2'].toString();
        recieverPhone1.text = detailsOrder['recieverPhone1'].toString();
        recieverPhone2.text = detailsOrder['recieverPhone2'].toString();
        packagePrice.text = detailsOrder['packagePrice'].toString();
        packageNumber.text = detailsOrder['packageNumber'].toString();
        deliveryPrice.text = detailsOrder['deliveryPrice'].toString();
        address.text = detailsOrder['address'].toString();
        cityName.text = detailsOrder['cityName'].toString();
        note.text = detailsOrder['note'].toString();
        orderDescription.text = detailsOrder['orderDescription'].toString();
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
}
