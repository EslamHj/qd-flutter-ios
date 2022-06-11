import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pro_delivery/coponents/darkMode.dart';
import 'package:pro_delivery/pages/Movements.dart';
import 'package:pro_delivery/pages/Order.dart';
import 'package:pro_delivery/pages/Setting.dart';
import 'package:google_fonts/google_fonts.dart';

class tabsorder extends StatefulWidget {
  tabsorder({Key? key}) : super(key: key);

  @override
  State<tabsorder> createState() => _tabsorderState();
}

class _tabsorderState extends State<tabsorder> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex:  0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // title: const Text('TabBar Widget'),
          backgroundColor: Themes.light.primaryColor,
           elevation: 0,
          toolbarHeight: 0,
          bottom: TabBar(
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: Themes.light_white, width: 2),
              // insets: EdgeInsets.symmetric(horizontal: 20),
            ),
            tabs: <Widget>[
              Tab(
                child: Text(
                  'قيد الإنتظار',
                  style: GoogleFonts.cairo(
                      textStyle: TextStyle(fontWeight: FontWeight.bold)),
                ),
                // icon: Icon(Icons.cloud_outlined),
                // text: 'قيد الإنتظار',
              ),
              Tab(
                child: Text(
                  'تحت الإجراء',
                  style: GoogleFonts.cairo(
                      textStyle: TextStyle(fontWeight: FontWeight.bold)),
                ),

                // icon: Icon(Icons.beach_access_sharp),
                // text: 'تحت الإجراء',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            order(),
            movements(),

            // Center(
            //   child: Text("It's cloudy here"),
            // ),
            // Center(
            //   child: Text("It's rainy here"),
            // ),
          ],
          
        ),
        
      ),
    );
  }
}
