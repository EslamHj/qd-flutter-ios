import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'darkMode.dart';


class MyInput extends StatelessWidget {

   final String title ;
   final String hint ;
   final TextEditingController ? controller ;
   final Widget ? widget;
  
  const MyInput({Key? key , 

  required this.title,
  required this.hint,
  this.controller,
  this.widget,
  
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
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
                    
                   readOnly: widget == null ? false : true,
                   autofocus: false,
                   cursorColor: Get.isDarkMode ?Themes.dark_white : Themes.light.primaryColor,
                   controller: controller,
                   style:  GoogleFonts.cairo( textStyle:TextStyle( fontSize: 14 ,  fontWeight: FontWeight.w400,height: 1.4 ,
                    color: Get.isDarkMode ? Themes.dark_white :Themes.light_black)),
                   decoration: InputDecoration(
                     hintText: hint,
                     hintStyle:TextStyle(fontSize: 14 , fontWeight: FontWeight.w400 , color: Colors.black),
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

               widget == null ? Container() : Container(child: widget,)
               ] 
             ),
          )
        ],),
    );
  }
}