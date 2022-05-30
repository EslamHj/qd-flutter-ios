import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_delivery/coponents/darkMode.dart';
import 'package:get/get.dart';

class terms extends StatefulWidget {
  terms({Key? key}) : super(key: key);

  @override
  State<terms> createState() => _termsState();
}

class _termsState extends State<terms> {
  // final _Storage = GetStorage();
  // var _color = true;
  // @override
  // void initState() {
  //   super.initState();
  //   _color = _Storage.read("isDarkMode");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(right: 15, left: 15, top: 30, bottom: 20),
                child: Text(
                  "إتفاقية الخدمة :",
                  style: GoogleFonts.cairo(
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Get.isDarkMode
                              ? Themes.light_grey
                              : Themes.light.primaryColor)),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 15, left: 15, top: 10),
                child: Text(
                  "1- نعلمكم بعدم مسؤوليتنا عن ضياع او تلف البضاعة في حالة وقوع سطو مسلح لاقدر الله داخل مكاتبنا او في الطريق حيث اننا حريصون بعدم المسير ليلا بالشاحنات الا في الظروف الاستثنائية.",
                  style: GoogleFonts.cairo(
                      textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Get.isDarkMode
                              ? Themes.dark_white
                              : Themes.light_black)),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 15, left: 15, top: 10),
                child: Text(
                  "2- نخلي المسؤولية عن اي بضاعة لم يبلغ صاحبها عن قابليتها للكسر او اذا كانت غير مغلفة تغليفا جيدا.",
                  style: GoogleFonts.cairo(
                      textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Get.isDarkMode
                              ? Themes.dark_white
                              : Themes.light_black)),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 15, left: 15, top: 10),
                child: Text(
                  "3- يمنع منعا باتا شحن الاسلحة والذخائر والالعاب النارية والسجائر وماشبهها والمواد القابلة للإشتعال من وقود وغاز الطهي.",
                  style: GoogleFonts.cairo(
                      textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Get.isDarkMode
                              ? Themes.dark_white
                              : Themes.light_black)),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 15, left: 15, top: 10),
                child: Text(
                  "4- يرجى من الزبون المرسل للبضاعة تحري الدقة في اسم المستلم ووجة البضاعة ورقم الهاتف .",
                  style: GoogleFonts.cairo(
                      textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Get.isDarkMode
                              ? Themes.dark_white
                              : Themes.light_black)),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 15, left: 15, top: 10),
                child: Text(
                  "5- على مرسل البضاعة اخبار المستلم بسعر الشحن ورقم الطرد مباشرة وفي حالة المراجعة يجب احضار ايصال الشحن.",
                  style: GoogleFonts.cairo(
                      textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Get.isDarkMode
                              ? Themes.dark_white
                              : Themes.light_black)),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 15, left: 15, top: 10),
                child: Text(
                  "6- نظرا للظروف الراهنة للبلاد نلتمس منكم العذر بسبب اغلاق الطريق او اعطال الشاحنات المفاجئ اثناء الرحلة.",
                  style: GoogleFonts.cairo(
                      textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Get.isDarkMode
                              ? Themes.dark_white
                              : Themes.light_black)),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 15, left: 15, top: 10),
                child: Text(
                  "7- نعلمكم بعدم مسؤوليتنا عن فقدان او تلف اي بضاعة بعد مضي 3 اشهر من تاريخ وصولها للمكتب.",
                  style: GoogleFonts.cairo(
                      textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Get.isDarkMode
                              ? Themes.dark_white
                              : Themes.light_black)),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 15, left: 15, top: 10),
                child: Text(
                  "8- يحق لشركة كويك دليفري مع ضمان سلامة الشحنة الحق في المعاينة وتفتيش جميع الشحنات.",
                  style: GoogleFonts.cairo(
                      textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Get.isDarkMode
                              ? Themes.dark_white
                              : Themes.light_black)),
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(right: 15, left: 15, top: 10, bottom: 30),
                child: Text(
                  "9- يتعهد المرسل بعدم استخدام خدماتنا بما يتعارض مع القانون والاخلاق او للأعمال الحتيالية.",
                  style: GoogleFonts.cairo(
                      textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Get.isDarkMode
                              ? Themes.dark_white
                              : Themes.light_black)),
                ),
              ),
            ],
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
