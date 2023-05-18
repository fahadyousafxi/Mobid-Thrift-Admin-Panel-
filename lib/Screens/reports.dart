import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobidthrift_admin_panel/Screens/seller_profile.dart';
import 'package:mobidthrift_admin_panel/Widgets/drawer_widget.dart';
import 'package:provider/provider.dart';

import '../Providers/reports_provider.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  ReportsProvider reportsProvider = ReportsProvider();

  final _firebaseFireStore = FirebaseFirestore.instance;

  @override
  void initState() {
    ReportsProvider reportProvider = Provider.of(context, listen: false);
    reportProvider.getReportsData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    reportsProvider = Provider.of(context);

    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Reports',
            style: TextStyle(color: Colors.white),
          ),
        ),
        drawer: DrawerWidget(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Center(
              child: ListView.builder(
            itemCount: reportsProvider.getReportsDataList.length,
            itemBuilder: (BuildContext context, int index) {
              var data = reportsProvider.getReportsDataList[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: InkWell(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => AllUsersScreen(
                    //               dataList:
                    //                   reportsProvider.getShopKeepersDataList,
                    //               users: 'Sellers',
                    //             )));
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    width: size.width / 1 > 500 ? 240 : 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [
                          Colors.red.shade200,
                          Colors.blue.shade200,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Name:  ' + data.userName.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Report:  ' + data.report.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          StreamBuilder<DocumentSnapshot>(
                              stream: _firebaseFireStore
                                  .collection('SellerCenterUsers')
                                  .doc(data.sellerUid)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting)
                                  return Center(
                                      child: CircularProgressIndicator(
                                    color: Colors.blue,
                                  ));

                                if (snapshot.hasError)
                                  return Center(child: Text('Some Error'));

                                return Column(children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => SellerProfile(
                                                          locationLatitude:
                                                              snapshot.data!['location_address']
                                                                  ['latitude'],
                                                          locationLongitude:
                                                              snapshot.data![
                                                                      'location_address']
                                                                  ['longitude'],
                                                          name: snapshot
                                                              .data!['Name'],
                                                          profileImage:
                                                              snapshot.data![
                                                                  'Profile_Image'],
                                                          email: snapshot
                                                              .data!['Email'],
                                                          contactNo: snapshot
                                                              .data!['Phone_Number'],
                                                          reviews: double.parse(snapshot.data!['Total_Review_Rating'].toString()),
                                                          totalNoOfReviews: snapshot.data!['Total_Number_of_Reviews'],
                                                          uId: snapshot.data!['Uid'])));
                                            },
                                            child: Text('View Seller'))

                                        // InkWell(
                                        //   onTap: () {
                                        //     Navigator.push(
                                        //         context,
                                        //         MaterialPageRoute(
                                        //             builder: (context) => SellerProfile(
                                        //                 locationLatitude: snapshot
                                        //                     .data!['location_address']
                                        //                 ['latitude'],
                                        //                 locationLongitude: snapshot
                                        //                     .data!['location_address']
                                        //                 ['longitude'],
                                        //                 name: snapshot
                                        //                     .data!['Name'],
                                        //                 profileImage: snapshot
                                        //                     .data![
                                        //                 'Profile_Image'],
                                        //                 email: snapshot
                                        //                     .data!['Email'],
                                        //                 contactNo: snapshot
                                        //                     .data![
                                        //                 'Phone_Number'],
                                        //                 reviews: double.parse(snapshot.data!['Total_Review_Rating'].toString()),
                                        //                 totalNoOfReviews: snapshot.data!['Total_Number_of_Reviews'],
                                        //                 uId: snapshot.data!['Uid'])));
                                        //   },
                                        //   child: snapshot.data![
                                        //   'Profile_Image']
                                        //       .toString() ==
                                        //       ''
                                        //       ? CircleAvatar(
                                        //     radius: 33,
                                        //     backgroundImage: AssetImage(
                                        //         'assets/images/img.png'),
                                        //   )
                                        //       : CircleAvatar(
                                        //     radius: 33,
                                        //     backgroundImage:
                                        //     NetworkImage(snapshot
                                        //         .data![
                                        //     'Profile_Image']
                                        //         .toString()),
                                        //   ),
                                        // ),
                                        // SizedBox(
                                        //   width: 15,
                                        // ),
                                        // Column(
                                        //   crossAxisAlignment:
                                        //   CrossAxisAlignment.start,
                                        //   mainAxisAlignment:
                                        //   MainAxisAlignment.center,
                                        //   children: [
                                        //     SizedBox(
                                        //       height: 21,
                                        //     ),
                                        //     Container(
                                        //         height: 85,
                                        //         child: Column(
                                        //           crossAxisAlignment:
                                        //           CrossAxisAlignment
                                        //               .start,
                                        //           children: [
                                        //             InkWell(
                                        //                 onTap: () {
                                        //                   Navigator.push(
                                        //                       context,
                                        //                       MaterialPageRoute(
                                        //                           builder: (context) =>
                                        //                               SellerProfile(
                                        //                                 locationLatitude:
                                        //                                 snapshot.data!['location_address']['latitude'],
                                        //                                 locationLongitude:
                                        //                                 snapshot.data!['location_address']['longitude'],
                                        //                                 name:
                                        //                                 snapshot.data!['Name'],
                                        //                                 profileImage:
                                        //                                 snapshot.data!['Profile_Image'],
                                        //                                 email:
                                        //                                 snapshot.data!['Email'],
                                        //                                 contactNo:
                                        //                                 snapshot.data!['Phone_Number'],
                                        //                                 reviews:
                                        //                                 snapshot.data!['Total_Review_Rating'],
                                        //                                 totalNoOfReviews:
                                        //                                 snapshot.data!['Total_Number_of_Reviews'],
                                        //                                 uId:
                                        //                                 snapshot.data!['Uid'],
                                        //                               )));
                                        //                 },
                                        //                 child: Text(
                                        //                     "${snapshot.data!['Name']}")),
                                        //             Row(
                                        //               children: [
                                        //                 Text('Review '),
                                        //                 Row(
                                        //                   children:
                                        //                   List.generate(
                                        //                       5,
                                        //                           (index) =>
                                        //                           Icon(
                                        //                             Icons.star,
                                        //                             color:
                                        //                             Colors.orange,
                                        //                             size:
                                        //                             20,
                                        //                           )),
                                        //                 ),
                                        //                 Text(' (${snapshot.data!['Total_Review_Rating']}.00'
                                        //                     .toString()
                                        //                     .substring(
                                        //                     0,
                                        //                     5) +
                                        //                     ')' ??
                                        //                     '')
                                        //               ],
                                        //             ),
                                        //           ],
                                        //         ))
                                        //   ],
                                        // )
                                      ],
                                    ),
                                  ),
                                ]);
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          )),
        ));
  }
}
