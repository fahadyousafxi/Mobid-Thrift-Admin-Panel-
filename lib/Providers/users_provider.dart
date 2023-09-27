import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../Models/users_model.dart';

class UsersProvider with ChangeNotifier {
  ///********************** Seller Center Users *********************

  List<UsersModel> shopKeepersDataList = [];

  void getShopKeepersData() async {
    List<UsersModel> newList = [];
    QuerySnapshot shopKeepersData =
        await FirebaseFirestore.instance.collection("SellerCenterUsers").get();

    for (var element in shopKeepersData.docs) {
      UsersModel soldProductsModel = UsersModel(
        name: element.get("Name"),
        email: element.get("Email"),
        userUid: element.get("Uid"),
        address: element.get("Address"),
        phoneNumber: element.get("Phone_Number"),
        profileImage: element.get("Profile_Image"),
        verification: element.get("Verification"),
      );
      newList.add(soldProductsModel);
    }
    shopKeepersDataList = newList;
    notifyListeners();
  }

  List<UsersModel> get getShopKeepersDataList {
    return shopKeepersDataList;
  }

  ///********************** User Users *********************

  List<UsersModel> usersDataList = [];

  void getUsersData() async {
    List<UsersModel> newList = [];
    QuerySnapshot usersData =
        await FirebaseFirestore.instance.collection("users").get();

    for (var element in usersData.docs) {
      UsersModel soldProductsModel = UsersModel(
        name: element.get("Name"),
        email: element.get("Email"),
        userUid: element.get("Uid"),
        address: element.get("Address"),
        phoneNumber: element.get("Phone_Number"),
        profileImage: element.get("Profile_Image"),
      );
      newList.add(soldProductsModel);
    }
    usersDataList = newList;
    notifyListeners();
  }

  List<UsersModel> get getUsersDataList {
    return usersDataList;
  }
}
