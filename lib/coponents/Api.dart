class api {
  var url = "http://demo.qdlibya.com/";
  var login = "api/mobile/Login?";
  // /// شاشة  اسعار التوصيل /////
  var Branches = "api/mobile/GetMainBranches";
  var deliveryPrices = "api/mobile/GetCitiesByBranch?BranchId=";
  ///// شاشة قيد الإنتظار (الطلبيات) /////////
  var order = "api/mobile/GetWebOrders" ;
  /////  اضافة طرد /////////
  var addOrder = "api/mobile/CreateWebOrder" ;
  var GetCitiesAndBranches = "api/mobile/GetCitiesAndBranches/" ;

  ///  شاشة قيد الإنتظار  
    var Details_Order = "api/mobile/GetWebOrder" ;
   var EditWebOrder = "api/mobile/EditWebOrder/";
   var DeleteWebOrder = "api/mobile/DeleteWebOrder/";
}
