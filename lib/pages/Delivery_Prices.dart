import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_delivery/coponents/Api.dart';
import 'package:pro_delivery/coponents/darkMode.dart';
import 'package:http/http.dart' as http;

class deliveryPrices extends StatefulWidget {
  deliveryPrices({Key? key, id}) : super(key: key);

  @override
  State<deliveryPrices> createState() => _deliveryPricesState();
}

class _deliveryPricesState extends State<deliveryPrices> {
  final _Storage = GetStorage();
  final scrollController = ScrollController();

  Map<String, dynamic> dlyPrices_Map = {};
  List dlyPrices = [];
  bool visible_ = false;
  bool visible_2 = false;
  bool net = false;
  int page = 1;
  bool hasMore = true;
  var idBranche = "";
  String token = "";
  bool _color = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.offset &&
          hasMore == true) {
        delivery_Prices();
      }
    });
    _color = _Storage.read("isDarkMode");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    idBranche = ModalRoute.of(context)!.settings.arguments as String;
    token = _Storage.read("token");
    delivery_Prices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: _color ? Themes.dark_primary : Themes.light_primary,
        appBar: _appBar(),
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
                  Visibility(
                    visible: !visible_,
                    child: Center(
                      child: Image.asset(
                        'assets/net.png',
                        width: 200,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !visible_,
                    child: Text(
                      "خطأ في الاتصال بالانترنت",
                      style: GoogleFonts.cairo(
                          textStyle: TextStyle(
                              fontSize: 16,
                              color: Themes.light.primaryColor,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Visibility(
                    visible: !visible_,
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            delivery_Prices();
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Visibility(
                      visible: visible_,
                      child: Center(
                          child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Themes.light.primaryColor),
                      ))),
                  Visibility(
                    visible: visible_2,
                    child: Expanded(
                      child: RefreshIndicator(
                        color: Themes.light.primaryColor,
                        onRefresh: delivery_Prices,
                        child: ListView.builder(
                            controller: scrollController,
                            itemCount: dlyPrices.length + 1,
                            itemBuilder: (context, i) {
                              if (i < dlyPrices.length) {
                                return _cardPrice(context, i);
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
                  ),
                  SizedBox(
                    height: 13,
                  ),
                ],
              ));
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
                 api().urlIcon,
                height: 50,
                width: 47,
                fit: BoxFit.cover,
              ),
            )),
      ],
    );
  }

  _cardPrice(context, index) {
    double _width = MediaQuery.of(context).size.width;

    final _Storage = GetStorage();
    var _color = _Storage.read("isDarkMode");

    return Stack(
      children: [
        Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            // margin: EdgeInsets.fromLTRB(20, 25, 20, 5),
            height: 100,
            margin: EdgeInsets.fromLTRB(20, 0, 20, 12),
            width: _width - 40,
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
                      Container(
                        width: _width / 2,
                        child: Text(
                          dlyPrices[index]['name'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.cairo(
                              textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: _color == true
                                      ? Themes.dark_white
                                      : Themes.light.primaryColor)),
                        ),
                      ),
                      Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Text(
                            // "10",
                            dlyPrices[index]['price'].toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: _color == true
                                    ? Themes.dark_white
                                    : Themes.light.primaryColor),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Text(
                            "د.ل",
                            style: GoogleFonts.cairo(
                                textStyle: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Themes.light_grey)),
                          ),
                        ),
                      ]),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: _width,
                    child: Text(
                      dlyPrices[index]['days'].toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.cairo(
                          textStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Themes.light_grey)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  ///////////////////////////api deliveryPrices ///////////////////////////////////////////////

  Future<void> delivery_Prices() async {
    try {
      visible_ = true;
      const limit = 25;

      var urlDeliveryPrices = Uri.parse(api().url +
          api().deliveryPrices +
          idBranche +
          "&Page=$page&PageSize=$limit");
      var response = await http.get(
        urlDeliveryPrices,
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      var responsebody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          if (dlyPrices.length == responsebody['data']['total']) {
            hasMore = false;
            visible_ = false;
          } else {
            dlyPrices.addAll(responsebody['data']['results']);
            visible_ = false;
            visible_2 = true;
            net = false;
            page++;
          }
        });
      }
    } on SocketException {
      setState(() {
        visible_ = false;
        net = true;
      });
    } on FormatException {
      setState(() {
        visible_ = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Color.fromARGB(255, 118, 82, 153),
          content: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              "يوجد خطأ في البيانات",
              style: GoogleFonts.cairo(
                  textStyle:
                      TextStyle(fontSize: 14, color: Themes.light_white)),
            ),
          )));
    } catch (ex) {
      visible_ = false;
    }
  }
}
