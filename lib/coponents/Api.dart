class api {

  var url = "https://demo.qdlibya.com/";
  var URLFrontend = "https://qdl-master.herokuapp.com/" ;
  var urlIcon ="assets/Qdly.png";


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
   /// تحت الإجراء
  var Under_procedure  = "api/mobile/GetOrders";
  var Under_procedure_Id  = "api/mobile/GetOrder/" ;
  /// البحث
    var StatusesAndBranches = "api/mobile/GetStatusesAndBranches";

    //// تعديل المندوبين
     var EditOrder = "api/mobile/EditOrder/";
     var SupplierOrder = "api/mobile/GetSupplierOrder/";

     //// المحفظة 
     var Wallet = "api/mobile/GetWalletActivities";

     ///////انشاء حساب 
     var Register = "api/mobile/Register?uri=";
      ////  تغير كلمة المرور
     
     var ChangePasswordEmail = "api/webusers/ChangePasswordEmail/";

}
