import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_delivery/coponents/MyButton.dart';
import 'package:pro_delivery/coponents/MyInputField.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

import 'package:pro_delivery/coponents/darkMode.dart';

class search extends StatefulWidget {
  search({Key? key}) : super(key: key);

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  DateTime _selecteDate = DateTime.now();
  DateTime _selecteDate2 = DateTime.now();
  final _Storage = GetStorage();

    var _color = false;

  @override
  void initState() {
    super.initState();
    _color = _Storage.read("isDarkMode");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
          textDirection: ui.TextDirection.rtl,
          child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: SingleChildScrollView(
                  child: Column(children: [
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: MyInput(
                        title: "كود الطرد",
                        hint: "",
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: MyInput(
                        title: "رقم المستلم",
                        hint: "",
                      ),
                    ),
                  ],
                ),

/////// ------------ DropdownSearch ------------ ////////

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
                                  : Themes.light_white,
                              border: Border.all(
                                  color: Themes.dark_white, width: 1.0),
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
                                dropdownSearchTextAlign: TextAlign.start,

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
                                dropdownBuilder: _customDropDownAddress,
                                popupItemBuilder: _style1,
                                items: [
                                  "طرابلس",
                                  "بنغازي",
                                  "يفرن",
                                  "نالوت",
                                  "مصراتة",
                                  "سبها"
                                ],
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

                Row(
                  children: [
                    Expanded(
                      child: MyInput(
                         title: "من تاريخ",
                        hint: DateFormat.yMd().format(_selecteDate),
                        widget: IconButton(
                            icon: Icon(
                              Icons.calendar_today_rounded,
                              color: Get.isDarkMode
                                  ? Themes.dark_white
                                  : Themes.light.primaryColor,
                            ),
                            onPressed: () {

                              _getDateFromUser();
                             
                            }),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child:MyInput(
                        title: "الى تاريخ",
                        hint: DateFormat.yMd().format(_selecteDate),
                        widget: IconButton(
                            icon: Icon(
                              Icons.calendar_today_rounded,
                              color: Get.isDarkMode
                                  ? Themes.dark_white
                                  : Themes.light.primaryColor,
                            ),
                            onPressed: () {
                                _getDateFromUser();
                            }
                      ),
                    ),

                    )

                  ],
                ),
                 SizedBox(
                    height: 30,
                  ),

                  myButton(label: "بحث", color:Themes.light.primaryColor , onTap: () => null),

                  SizedBox(
                    height: 30,
                  ),
              ])))),
    );
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

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2121));

    if (_pickerDate != null) {
      setState(() {
        _selecteDate = _pickerDate;
      });
    } else {
      print("it's null or something is wrong");
    }
  }

}


