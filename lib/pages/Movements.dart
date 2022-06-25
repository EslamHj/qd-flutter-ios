import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_delivery/coponents/darkMode.dart';
import 'package:http/http.dart' as http;
import 'package:pro_delivery/coponents/Api.dart';
import 'dart:convert';

class movements extends StatefulWidget {
  movements({Key? key}) : super(key: key);

  @override
  State<movements> createState() => _movementsState();
}

class _movementsState extends State<movements> {
  final _Storage = GetStorage();
  final scrollController = ScrollController();
  bool hasMore = true;

  var _color = true;
  bool net = false;
  List orderJson = [];
  bool visible_ = false;
  String code = "";
  String token = "";
  String name = "";
  var role = "";
  bool visible_role = false;
  int page = 1;
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.offset &&
          hasMore == true) {
        Under_procedure();
      }
    });

    _color = _Storage.read("isDarkMode");
    code = _Storage.read("code").toString();
    name = _Storage.read("name").toString();
    token = _Storage.read("token").toString();
    role = _Storage.read("role").toString();
    if (role == "2") {
      visible_role = true;
    }

    Under_procedure();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: _color ? Themes.dark_primary : Themes.light_primary,
        body: net == true
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Visibility(
                      visible: visible_,
                      child: Container(
                        // margin: EdgeInsets.only(top: 25),
                        child: Center(
                            child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Themes.light.primaryColor),
                        )),
                      )),
                  // Visibility(
                  //   visible: !visible_,
                  //   child: Center(
                  //     child: Image.asset(
                  //       'assets/net.png',
                  //       width: 200,
                  //     ),
                  //   ),
                  // ),
                  Visibility(
                    visible: !visible_,
                    child: Center(
                      child: Text(
                        "خطأ في الاتصال بالانترنت",
                        style: GoogleFonts.cairo(
                            textStyle: TextStyle(
                                fontSize: 16,
                                color: Themes.light.primaryColor,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !visible_,
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            Under_procedure();
                            // net = false;
                            visible_ = true;
                          });
                        },
                        icon: Icon(
                          Icons.refresh,
                          size: 40,
                          color: Themes.light.primaryColor,
                        )),
                  )
                ],
              )
            : Column(
                children: [
                  Visibility(
                    visible: visible_role,
                    child: _cardCash(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Visibility(
                        visible: visible_,
                        child: Container(
                          margin: EdgeInsets.only(top: 25),
                          child: Center(
                              child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Themes.light.primaryColor),
                          )),
                        )),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      color: Themes.light.primaryColor,
                      onRefresh: Under_procedure,
                      child: ListView.builder(
                          controller: scrollController,
                          itemCount: orderJson.length + 1,
                          itemBuilder: (context, i) {
                            if (i < orderJson.length) {
                              return GestureDetector(
                                  onTap: () {
                                    Details_Movements(i);
                                  },
                                  child: _cardOrder(context, i));
                            } else {
                              return Visibility(
                                visible: hasMore,
                                child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 10, bottom: 20),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Themes.light.primaryColor),
                                      ),
                                    )),
                              );
                            }
                          }),
                    ),
                  ),
                ],
              ));
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
                        width: 120,
                        child: Text(
                          orderJson[index]['barCode'].toString(),
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
                      Container(
                        width: 130,
                        child: Text(
                          orderJson[index]['note'].toString() == 'null'
                              ? ''
                              : orderJson[index]['note'].toString(),
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
                    ]),
                    Column(children: [
                      Row(children: [
                        Text(
                          orderJson[index]['packagePrice'].toString(),
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
                          orderJson[index]['cityName'].toString(),
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
                          orderJson[index]['recieverPhone1'].toString(),
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
                          orderJson[index]['recieverPhone2'].toString() ==
                                  'null'
                              ? ''
                              : orderJson[index]['recieverPhone2'].toString(),
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
                        orderJson[index]['status'].toString(),
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

  _cardCash(context) {
    double _width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Directionality(
            textDirection: TextDirection.ltr,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              margin: EdgeInsets.fromLTRB(20, 25, 20, 0),
              width: _width - 40,
              height: 70,
              decoration: BoxDecoration(
                  color: Themes.light.primaryColor,
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                  //  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          code.toString(),
                          style: GoogleFonts.cairo(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Text(
                          name.toString(),
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

  ///////////////////////////api Under_procedure ///////////////////////////////////////////////

  Future<void> Under_procedure() async {
    try {
      // visible_ = true;
      const limit = 25;
      var urlOrder = Uri.parse(api().url +
          api().Under_procedure +
          "?Page=$page" +
          "&PageSize=$limit");
      var response = await http.get(
        urlOrder,
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      var responsebody = jsonDecode(response.body);

      if (responsebody['data']['total'] < 7) {
        hasMore = false;
      }
      setState(() {
        // orderJson = responsebody['data']['results']
        if (orderJson.length == responsebody['data']['total']) {
          hasMore = false;
          visible_ = false;
        } else {
          orderJson.addAll(responsebody['data']['results']);
          page++;
        }
      });

      if (response.statusCode == 200) {
        visible_ = false;
        net = false;
      }
    } on SocketException {
      setState(() {
        visible_ = false;
        net = true;
      });
    } catch (ex) {}
  }

  Details_Movements(index) {
    if (_Storage.read("role").toString() == "2") {
      Navigator.pushNamed(context, 'details_Suppliers',
          arguments: orderJson[index]['id']);
    } else {
      Navigator.pushNamed(context, 'details_movements',
          arguments: orderJson[index]['id']);
    }
  }
}
