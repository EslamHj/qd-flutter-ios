// import 'dart:convert';

// import 'package:http/http.dart' as http;

// class apifunction {
//   var url = "https://testapi.qdlibya.com/";



//   Future<http.Response>  getApi(String pathApi , String token)async{

//    http.Response response;

//    Map <String ,String> _header =  {"Authorization": "Bearer $token"};

//     response = await http.get( Uri.parse(this.url + pathApi), headers: _header);

//    return response ;

// }

//   Future <http.Response> order() async {
   
//       var urlBranches = Uri.parse(url +"api/WebOrders/GetByCustomerCode/00765");
//       http.Response response = await http.get(urlBranches
//           // headers: {
//           //   "Authorization": "Bearer $token",
//           // },
//           );
// //  responsebody['data'];
    
//         return  response ;
//   }
// }
