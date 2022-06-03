import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pro_delivery/coponents/MyButton.dart';
import 'package:pro_delivery/coponents/MyInputField.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:pro_delivery/pages/Branches.dart';
import 'package:pro_delivery/pages/homePages.dart';
import 'dart:ui' as ui;

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
  List branche = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    branche = ModalRoute.of(context)!.settings.arguments as List;
    print(branche);
  }

  @override
  void initState() {
    super.initState();
    _color = _Storage.read("isDarkMode");
  }
  // List city = [
  //   {'name': 'طرابلس', 'value': '1'},
  //   {'name': 'بنغازي', 'value': '2'},
  //   {'name': 'يفرن', 'value': '3'},
  //   {'name': 'نالوت', 'value': '4'}
  // ];

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
                  // Text(
                  //   "add task" ,
                  //   style: TextStyle(fontSize: 30 ,
                  //    fontWeight: FontWeight.bold,
                  //   //  color:  Get.isDarkMode ? Colors.red : Colors.black
                  //    ) ,
                  // ),

                  SizedBox(
                    height: 5,
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: MyInput(
                          title: "رقم المستلم",
                          hint: hintV == false ? "" : "يجب الملء",
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: MyInput(
                          title: "رقم المستلم 2",
                          hint: "",
                        ),
                      ),
                    ],
                  ),

                  MyInput(title: "اسم الصفحة", hint: ""),
                  Row(
                    children: [
                      Expanded(
                        child: MyInput(
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

                  Row(
                    children: [
                      Expanded(
                        child: MyInput(
                          title: "سعر الطرد",
                          hint: "",
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: MyInput(
                          title: "عدد العناصر",
                          hint: "",
                        ),
                      ),
                    ],
                  ),

                  MyInput(
                    title: "عنوان المستلم",
                    hint: "",
                  ),

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

                  Container(
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
                                items: [
                                  "زناتة",
                                  "مصراتة",
                                  "بنغازي",
                                  "مصراتة",
                                  "سبها"
                                ],
                                // label: "Country",
                                onChanged: print,

                                //show selected item
                                selectedItem: "زتاتة",
                              ),
                            ),
                          ]),
                        )
                      ],
                    ),
                  ),

/////// ------------ DropdownSearch city ------------ ////////

                  Container(
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
                                // autoFocusSearchBox: true,

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
                                items: [],
                                // label: "Country",
                                onChanged: print,

                                //show selected item
                                selectedItem: "طرابلس",
                              ),
                            ),
                          ]),
                        )
                      ],
                    ),
                  ),

                  MyInput(title: "ملاحظة", hint: ""),
                  SizedBox(
                    height: 30,
                  ),

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        hintV = true;
                        print("hhhh");
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

  // _getDateFromUser() async {
  //   DateTime? _pickerDate = await showDatePicker(
  //       context: context,
  //       initialDate: DateTime.now(),
  //       firstDate: DateTime(2015),
  //       lastDate: DateTime(2121));

  //   if (_pickerDate != null) {
  //     setState(() {
  //       _selecteDate = _pickerDate;
  //     });
  //   } else {
  //     print("it's null or something is wrong");
  //   }
  // }

  // _getTimeFromUser({required bool isStarTime}) async {
  //   var pickedTime = await _showTimePicker();
  //   String _formatedTime = pickedTime.format(context);
  //   if (pickedTime == null) {
  //   } else if (isStarTime == true) {
  //     setState(() {
  //       _startTime = _formatedTime;
  //     });
  //   } else if (isStarTime == false) {
  //     setState(() {
  //       _endTime = _formatedTime;
  //     });
  //   }
  // }

  // _showTimePicker() {
  //   return showTimePicker(
  //       initialEntryMode: TimePickerEntryMode.input,
  //       context: context,
  //       initialTime: TimeOfDay(
  //         hour: int.parse(_startTime.split(":")[0]),
  //         minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
  //       ));
  // }
}
