import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobidthrift_admin_panel/Providers/seller_verification_provider.dart';
import 'package:mobidthrift_admin_panel/utils/utils.dart';
import 'package:provider/provider.dart';

class SellerVerificationScreen extends StatefulWidget {
  const SellerVerificationScreen({Key? key}) : super(key: key);

  @override
  State<SellerVerificationScreen> createState() =>
      _SellerVerificationScreenState();
}

class _SellerVerificationScreenState extends State<SellerVerificationScreen> {

  SellerVerificationProvider sellerProvider = SellerVerificationProvider();
  final  _fireStore = FirebaseFirestore.instance.collection('SellerCenterUsers');

  // final _fireStoreSnapshot = FirebaseFirestore.instance
  //     .collection('SellerCenterUsers').get();

  @override
  void initState() {

    SellerVerificationProvider productsProvider = Provider.of(context, listen: false);
    productsProvider.fitchSellerVerification();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sellerProvider = Provider.of(context);
    sellerProvider.fitchSellerVerification();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Seller Verified',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: sellerProvider.getSellerVerificationList.isEmpty ? Center(child: CircularProgressIndicator(),)
          : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
                itemCount: sellerProvider.getSellerVerificationList.length,
                itemBuilder: (BuildContext context, int index) {

                  var data = sellerProvider.getSellerVerificationList[index];

                  return Container(
                    margin: EdgeInsets.only(top: 10, bottom: 20),
                    // width: 22,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: Colors.black, )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(children: [
                              SizedBox(
                                height: 80,
                                width: 100,
                                  child: Image.network(data.sellerShopImage.toString())),
                              SizedBox(height: 3,),
                              Text('Shop')
                            ],),

                            Column(children: [
                              SizedBox(height: 80,
                                  width: 100,child: Image.network(data.sellerCNICImage1.toString())),
                              SizedBox(height: 3,),
                              Text('CNIC Pic 1')
                            ],),

                            Column(children: [
                              SizedBox(height: 80,
                                  width: 100,child: Image.network(data.sellerCNICImage2.toString())),
                              SizedBox(height: 3,),
                              Text('CNIC Pic 2')
                            ],),


                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('Name:  '),
                                      Text(data.sellerName.toString()),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,

                                    children: [
                                      Text('Email:  '),
                                      Text(data.sellerEmail.toString()),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          SizedBox(width: 10,),
                                          data.verification == true ? Row(
                                            children: [
                                              Icon(Icons.check_circle, color: Colors.green,),
                                              Text('Verified'),
                                            ],
                                          ) : ElevatedButton(onPressed: (){
                                            _fireStore.doc(data.uId.toString()).update(
                                                {
                                                  'Verification': true,
                                                }).then((value) {
                                                  print('objectobjectobjectobjectobjectobject');
                                                  setState(() {

                                                  });
                                            }).onError((error, stackTrace) {
                                              Utils.flutterToast(error.toString());
                                            });
                                          }, child: Text('Verify'))
                                        ],
                                      ),

                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
          ),
      // FutureBuilder<QuerySnapshot<Map<String,dynamic>>>(
      //     future: _fireStoreSnapshot,
      //     builder:
      //         (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      //       if (snapshot.connectionState == ConnectionState.waiting)
      //         return Center(
      //             child: CircularProgressIndicator(
      //           color: Colors.white,
      //         ));
      //
      //       if (snapshot.hasError) return Center(child: Text('Some Error'));
      //
      //       if (snapshot.data!.docs.where((element) => element['Verification']) == true) {
      //         print(
      //             'gooooooooooood           gooooooooooood        gooooooooooood');
      //         return ListView.builder(
      //           itemCount: snapshot.data!.docs.length,
      //           itemBuilder: (BuildContext context, int index) {
      //             return Container(
      //               color: Colors.red,
      //               width: 222,
      //               height: 170,
      //               child: Column(
      //                 children: [
      //
      //                 ],
      //               ),
      //             );
      //           },
      //         );
      //       }
      //       // if (snapshot.data!['Verification'] == false) {
      //       //   print(
      //       //       'gooooooooooood           gooooooooooood        gooooooooooood');
      //       // }
      //
      //
      //
      //       // if(snapshot.data!['Name'] == 'fahad'){
      //       //
      //       //   print('gooooooooooood');
      //       //
      //       //   Navigator.pushReplacement(
      //       //       context,
      //       //       MaterialPageRoute(
      //       //           builder: (context) => Orders()));
      //       //
      //       // }
      //
      //       return SizedBox(
      //         child: Center(
      //           child: Text(snapshot.data!.docs.['Verification'].toString()),
      //         ),
      //       );
      //     }),
    );
  }
}
