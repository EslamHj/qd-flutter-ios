import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_delivery/coponents/darkMode.dart';
import 'package:pro_delivery/coponents/darkmode_service.dart';
import 'package:get/get.dart';

class order extends StatefulWidget {
  order({Key? key}) : super(key: key);

  @override
  State<order> createState() => _orderState();
}

class _orderState extends State<order> {

  
    final _Storage = GetStorage();
     var  _color = true ;
    @override
  void initState()  {
    super.initState();
    _color =  _Storage.read("isDarkMode");
   
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: 
       GestureDetector(
          onTap: () {
             Navigator.pushNamed(context, 'details_order');

          },
      child:  _cardOrder(context)
      ),
     
    );
  }
}

_cardOrder(context) {
        double _width = MediaQuery.of(context).size.width;

  final _Storage = GetStorage();
  var _color = _Storage.read("isDarkMode");
  return Stack(
    children: [
      Container(
        margin: EdgeInsets.fromLTRB(20, 25, 20, 0),
        height: 130,
        width: double.infinity,
        decoration: BoxDecoration(
            color:_color == true ? Themes.dark_primary : Themes.light_white, borderRadius: BorderRadius.circular(20),
             border: Border.all(
                color:_color == true ? Themes.dark_grey  :  Themes.light_white,
                 width: 1
               ),
            ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(children: [
                    Container(
                      width: 120,
                      child: Text(
                        "00044788",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                              color:_color == true ? Themes.dark_white : Themes.light.primaryColor),
                      ),
                    ),
                    Container(
                      width: 130,
                      child: Text(
                        "الساحل للحلويات والخضروات",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.cairo(
                          textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color:_color == true ? Themes.dark_white : Themes.light.primaryColor),
                        ),
                      ),
                    ),
                  ]),
                  Column(children: [
                    Row(children: [
                      Text(
                        "50000.00",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                              color:_color == true ? Themes.dark_white  : Themes.light.primaryColor),
                      ),
                      Text(
                        "د.ل",
                        style: GoogleFonts.cairo(
                            textStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Themes.light_grey)),
                      ),
                    ]),
                    Container(
                      width: 70,
                      child: Text(
                        "بنغازي مصراتة",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.cairo(
                            textStyle: TextStyle(
                                color: Themes.light_grey,
                                fontWeight: FontWeight.bold)),
                      ),
                    )
                  ]),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: _width/4,
                    child: Text(
                      "0926067840",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Themes.light_grey),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: _width/2-30,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Themes.light.primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "قيد الإنتظار",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cairo(
                          textStyle: TextStyle(
                        color: Themes.light_white,
                      )),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )
    ],
  );
}
