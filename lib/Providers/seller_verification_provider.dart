import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../Models/seller_model.dart';

class SellerVerificationProvider with ChangeNotifier{
  SellerModel? sellerModel;

  List<SellerModel> searchProductsList = [];

  productModels(QueryDocumentSnapshot element){
    sellerModel = SellerModel(
      verification: element.get("Verification"),
      sellerName: element.get("Name"),
      sellerEmail : element.get("Email"),
      sellerShopImage: element.get("Shop_Image1"),
      sellerCNICImage1: element.get("CNIC_Image1"),
      sellerCNICImage2: element.get("CNIC_Image2"),
        uId: element.get("Uid")
      // bidDateTimeLeft: element.get("bidDateTimeLeft"),
    );
    searchProductsList.add(sellerModel!);
  }


  ///********************** Cell Phones Products *********************///

  List<SellerModel> sellerVerificationList = [];
  fitchSellerVerification() async {
    List<SellerModel> newList = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("SellerCenterUsers").get();

    for (var element in snapshot.docs) {

      productModels(element);
      // productModel = ProductModel(
      //   productImage1: element.get("productImage1"),
      //   productName: element.get("productName"),
      //   productDescription: element.get("productDescription"),
      //   productCurrentBid: element.get("productCurrentBid"),
      //   // bidDateTimeLeft: element.get("bidDateTimeLeft"),
      // );
      newList.add(sellerModel!);
    }
    sellerVerificationList = newList;
    notifyListeners();
  }
  List<SellerModel> get getSellerVerificationList {
    return sellerVerificationList;
  }
}