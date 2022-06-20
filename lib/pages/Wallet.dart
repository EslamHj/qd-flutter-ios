import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pro_delivery/coponents/Api.dart';
import 'package:pro_delivery/coponents/darkMode.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;

class wallet extends StatefulWidget {
  wallet({Key? key}) : super(key: key);

  @override
  State<wallet> createState() => _walletState();
}

class _walletState extends State<wallet> {
  final _Storage = GetStorage();
  final scrollController = ScrollController();
  bool hasMore = true;
  bool cardV= false;
  var _color = true;
  bool net = false;
  List walletJson = [];
  Map card = {};
  bool visible_ = false;
  String code = "";
  String token = "";
  String name = "";
  int page = 1;

  @override
  void initState() {
    super.initState();
    _color = _Storage.read("isDarkMode");
    token = _Storage.read("token").toString();

    Wallet();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.offset &&
          hasMore == true) {
        Wallet();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: _color ? Themes.dark_primary : Themes.light_primary,
        body: SafeArea(
            child: Column(
          children: [
           
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Visibility(
                visible: cardV,
                child: _cardCash(context),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                color: Themes.light.primaryColor,
                onRefresh: Wallet,
                child: ListView.builder(
                      shrinkWrap: true,
                    controller: scrollController,
                    itemCount: walletJson.length + 1,
                    itemBuilder: (context, i) {
                      if (i < walletJson.length) {
                        return GestureDetector(
                            onTap: () {}, child: _cardOrder(context, i));
                      } else {
                        return Visibility(
                          visible: hasMore,
                          child: Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 20),
                              child: Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Themes.light.primaryColor),
                                ),
                              )),
                        );
                      }
                    }),
              ),
            ),
          ],
        )));
  }

  _cardCash(context) {
    double _width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Directionality(
            textDirection: ui.TextDirection.ltr,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
              width: _width - 40,
              height: 170,
              decoration: BoxDecoration(
                  color: Themes.light.primaryColor,
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                  //  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "رصيدك الحالي هو ",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "د.ل ",
                          style: GoogleFonts.cairo(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          card['walletBalance'].toString(),
                          style: GoogleFonts.cairo(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          card['userCode'].toString(),
                          style: GoogleFonts.cairo(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Text(
                          card['userName'].toString(),
                          style: GoogleFonts.cairo(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    )
                  ]),
            ))
      ],
    );
  }

  _cardOrder(context, index) {
    double _width = MediaQuery.of(context).size.width;

    final _Storage = GetStorage();
    var _color = _Storage.read("isDarkMode");
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 12),
          height: 130,
          width: double.infinity,
          decoration: BoxDecoration(
            color: _color == true ? Themes.dark_primary : Themes.light_white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: _color == true ? Themes.dark_grey : Themes.light_white,
                width: 1),
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
                        width: 130,
                        child: Text(
                          DateFormat("yyyy-MM-dd'T'HH:mm")
                              .parse(walletJson[index]['date'])
                              .toString()
                              .replaceAll(RegExp(':00.000'), ''),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.cairo(
                            textStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: _color == true
                                    ? Themes.dark_white
                                    : Themes.light_grey),
                          ),
                        ),
                      ),
                      Container(
                        width: 120,
                        child: Text(
                          walletJson[index]['order']['barCode'].toString() ==
                                  'null'
                              ? ''
                              : walletJson[index]['order']['barCode']
                                  .toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: _color == true
                                  ? Themes.dark_white
                                  : Themes.light.primaryColor),
                        ),
                      ),
                    ]),
                    Column(children: [
                      Row(children: [
                        Text(
                          walletJson[index]['value'].toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: _color == true
                                  ? Themes.dark_white
                                  : Themes.light.primaryColor),
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
                        width: 100,
                        child: Text(
                          walletJson[index]['order']['cityName'].toString() ==
                                  'null'
                              ? ''
                              : walletJson[index]['order']['cityName']
                                  .toString(),
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
                    Column(children: [
                      Container(
                        width: _width / 4,
                        child: Text(
                          walletJson[index]['order']['recieverPhone1']
                                      .toString() ==
                                  'null'
                              ? ''
                              : walletJson[index]['order']['recieverPhone1']
                                  .toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: _color == true
                                  ? Themes.dark_white
                                  : Themes.light.primaryColor),
                        ),
                      ),
                      Container(
                        width: _width / 4,
                        child: Text(
                          walletJson[index]['order']['recieverPhone2']
                                      .toString() ==
                                  'null'
                              ? ''
                              : walletJson[index]['order']['recieverPhone2']
                                  .toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Themes.light_grey),
                        ),
                      ),
                    ]),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: _width / 2 - 30,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Themes.light.primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        walletJson[index]['type'].toString() == "1"
                            ? "اضافة"
                            : "خصم",
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

  ///////////////////////////api Wallet ///////////////////////////////////////////////

  Future<void> Wallet() async {
    try {
      // visible_ = true;
      const limit = 1;
      var urlWallet = Uri.parse(
          api().url + api().Wallet + "?Page=$page" + "&PageSize=$limit");
      var response = await http.get(
        urlWallet,
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      var responsebody = jsonDecode(response.body);
      card = responsebody['data'];
      if (responsebody['data']['items']['total'] < 7) {
        hasMore = false;
      }
      setState(() {
        // orderJson = responsebody['data']['results']
        if (walletJson.length == responsebody['data']['items']['total']) {
          hasMore = false;
          visible_ = false;
        } else {
          walletJson.addAll(responsebody['data']['items']['results']);
          page++;
        }
      });

      if (response.statusCode == 200) {
        visible_ = false;
        cardV =true ;
        // net = false;
      }
    } on SocketException {
      setState(() {
        // visible_ = false;
        // net = true;
      });
    } catch (ex) {}
  }
}
