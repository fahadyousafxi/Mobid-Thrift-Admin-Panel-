import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobidthrift_admin_panel/Models/reports_model.dart';

class ReportsProvider with ChangeNotifier {
  ///********************** Seller Center Users *********************

  List<ReportsModel> reportsDataList = [];

  void getReportsData() async {
    List<ReportsModel> newList = [];
    QuerySnapshot reportsData =
        await FirebaseFirestore.instance.collection("Reports").get();

    for (var element in reportsData.docs) {
      ReportsModel soldProductsModel = ReportsModel(
        userName: element.get("User_Nik_Name"),
        userUid: element.get("Reporter_Uid"),
        sellerUid: element.get("Seller_Uid"),
        reportTiming: element.get("Report_Timing_String"),
        report: element.get("User_Report"),
      );
      newList.add(soldProductsModel);
    }
    reportsDataList = newList;
    notifyListeners();
  }

  List<ReportsModel> get getReportsDataList {
    return reportsDataList;
  }
}
