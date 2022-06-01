import 'package:dropdown_search/dropdown_search.dart' ;
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

  var _selecteDate = DateTime.now();
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
                              /////////////////////// من تاريخ ///////////////////////////


                      Expanded(
                      child:   Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "من تاريخ",
            style:GoogleFonts.cairo( textStyle:  TextStyle(
              fontSize:  14,
              fontWeight: FontWeight.w600,
              color: Get.isDarkMode ?Themes.dark_white : Themes.light.primaryColor


            )
            ),
          ),


          Container(
            height: 42,
           
            margin: EdgeInsets.only(top: 8.0),
            padding: EdgeInsets.only(right: 14),
             decoration: BoxDecoration(
                color: Get.isDarkMode ?  Themes.dark_primary : Themes.light_white,
               border: Border.all(
                 color: Themes.dark_white,
                 width: 1
               ),
               borderRadius: BorderRadius.circular(5)
             ),
             child: Row(
               children:[
                  Expanded(
                 child: TextFormField(
                    readOnly: true,
                   autofocus: false,
                   cursorColor: Get.isDarkMode ?Themes.dark_white : Themes.light.primaryColor,
                   style:  GoogleFonts.cairo( textStyle:TextStyle( fontSize: 14 ,  fontWeight: FontWeight.w400,height: 1.4 ,
                    color: Get.isDarkMode ? Themes.dark_white :Themes.light_black)),
                   decoration: InputDecoration(
                     icon: GestureDetector(
                      onTap: () {
                         _getDateFromUser(context);
                      },
                       child: Icon( Icons.calendar_today_rounded,
                                color: Get.isDarkMode
                                    ? Themes.dark_white
                                    : Themes.light.primaryColor,),
                     ),
                     hintText: DateFormat('yyyy-MM-dd').format(_selecteDate),
                     hintStyle:TextStyle(fontSize: 14 , fontWeight: FontWeight.w400 ,  color: Get.isDarkMode ? Themes.dark_white :Themes.light_black),
                     focusedBorder: UnderlineInputBorder(
                       borderSide: BorderSide(
                         color: Colors.white,
                         width: 0,
                       )
                     ),
                     enabledBorder: UnderlineInputBorder(
                       borderSide: BorderSide(
                         color: Colors.white,
                         width: 0,
                       )
                     ),  
                   ),
                 )
               ),

               ] 
             ),
          )
        ],),
    )
                    ),

                    
                  
                    SizedBox(
                      width: 12,
                    ),

                              /////////////////////// الى تاريخ ///////////////////////////

                    Expanded(
                      child:   Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "الى تاريخ",
            style:GoogleFonts.cairo( textStyle:  TextStyle(
              fontSize:  14,
              fontWeight: FontWeight.w600,
              color: Get.isDarkMode ?Themes.dark_white : Themes.light.primaryColor


            )
            ),
          ),


          Container(
            height: 42,
           
            margin: EdgeInsets.only(top: 8.0),
            padding: EdgeInsets.only(right: 14),
             decoration: BoxDecoration(
                color: Get.isDarkMode ?  Themes.dark_primary : Themes.light_white,
               border: Border.all(
                 color: Themes.dark_white,
                 width: 1
               ),
               borderRadius: BorderRadius.circular(5)
             ),
             child: Row(
               children:[
                  Expanded(
                 child: TextFormField(
                    readOnly: true,
                   autofocus: false,
                   cursorColor: Get.isDarkMode ?Themes.dark_white : Themes.light.primaryColor,
                   style:  GoogleFonts.cairo( textStyle:TextStyle( fontSize: 14 ,  fontWeight: FontWeight.w400,height: 1.4 ,
                    color: Get.isDarkMode ? Themes.dark_white :Themes.light_black)),
                   decoration: InputDecoration(
                     icon: GestureDetector(
                      onTap: () {
                         _getDateFromUser(context);
                      },
                       child: Icon( Icons.calendar_today_rounded,
                                color: Get.isDarkMode
                                    ? Themes.dark_white
                                    : Themes.light.primaryColor,),
                     ),
                     hintText: DateFormat('yyyy-MM-dd').format(_selecteDate),
                     hintStyle:TextStyle(fontSize: 14 , fontWeight: FontWeight.w400 ,  color: Get.isDarkMode ? Themes.dark_white :Themes.light_black),
                     focusedBorder: UnderlineInputBorder(
                       borderSide: BorderSide(
                         color: Colors.white,
                         width: 0,
                       )
                     ),
                     enabledBorder: UnderlineInputBorder(
                       borderSide: BorderSide(
                         color: Colors.white,
                         width: 0,
                       )
                     ),  
                   ),
                 )
               ),

               ] 
             ),
          )
        ],),
    )
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

Future<void> _getDateFromUser(BuildContext context) async {
DateTime? picked = await showDatePicker(
      context: context,
    builder: (BuildContext context, Widget ?child) {
      return Theme(
        data: ThemeData(
          primarySwatch: Colors.grey,
          splashColor: Color.fromARGB(255, 90, 66, 66),
          textTheme: TextTheme(
            subtitle1: TextStyle(color: Colors.white),
            button: TextStyle(color: Colors.black),
          ),
          colorScheme: ColorScheme.light(
              primary: Color(0xFF6F35A5),
              onSecondary: Colors.black,
              onPrimary: Colors.white,
              surface: Colors.black,
              onSurface: Colors.black,
              secondary: Colors.black),
              dialogBackgroundColor: Colors.white,
        ),
        child: child ??Text(""),
      );
    }
    initialDate: _selecteDate,
    firstDate: DateTime(1960, 8),
    lastDate: DateTime.now());
if (picked != null && picked != _selecteDate)
  setState(() {
    _selecteDate = picked;
     
  });}
}




