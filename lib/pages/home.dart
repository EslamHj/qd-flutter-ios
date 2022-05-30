import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
          body: Directionality(
          
         textDirection: TextDirection.rtl,
         child: Column(children: [
            Container(
                alignment: Alignment.bottomRight,
               margin: EdgeInsets.only(top: 30), 
               padding: EdgeInsets.only(right: 15),
               child: Text ("توصيل الطلب الى" , style: TextStyle(color: Colors.grey),),),
            Row(
              children: [
                Container( 
                   padding: EdgeInsets.only(right: 15),
                  child: Text ("موقع الزبون" , style: TextStyle(fontWeight: FontWeight.bold),),),
                IconButton(onPressed: (){}, icon: Icon(Icons.arrow_drop_down , color: Colors.red,))
              ],
            ),
            Container(
                child: Row(children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius:BorderRadius.circular(20) ),
                      child: Row(children: [
                          Icon(Icons.search),
                          // TextField(
                          //   decoration: InputDecoration(hintText: "بحث"),
                          // ),
                       
                      ]),
                     
                    ),
                      
                  ),
                    
                ]),
            )
          ]),
        )),

    );
  }
}