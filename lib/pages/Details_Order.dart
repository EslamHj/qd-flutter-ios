import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_delivery/coponents/MyButton.dart';
import 'package:pro_delivery/coponents/MyInputField.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'dart:ui' as ui;
import '../coponents/darkMode.dart';

class details_order extends StatefulWidget {
  details_order({Key? key}) : super(key: key);

  @override
  State<details_order> createState() => _details_orderState();
}

class _details_orderState extends State<details_order> {
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
        appBar: _appBar(),
        body: Directionality(
            textDirection: ui.TextDirection.rtl,
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: SingleChildScrollView(
                  child: Column(
                children: [
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
                          title: "الفرع",
                          hint: "",
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: MyInput(
                          title: "رقم المستلم",
                          hint: "",
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
                  MyInput(title: "ملاحظة", hint: ""),
                  SizedBox(
                    height: 30,
                  ),

                    Row(
                    children: [
                      Expanded(
                        child:  myButton(label: "تعديل", color: Themes.light.primaryColor , onTap: () => null),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child:  myButton(label: "حذف", color: Color.fromARGB(255, 179, 50, 41) , onTap: () => null),
                      ),
                    ],
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
}
