import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class SellerCompleteProfile extends StatefulWidget {
  String? profileImage;
  String? shopImage;
  String? cNICFrontImage;
  String? cNICBackImage;
  String? name;
  String? email;
  String? address;
  String? phoneNumber;
  String? uid;
  bool? verified;
  SellerCompleteProfile(
      {required this.address,
      required this.cNICBackImage,
      required this.cNICFrontImage,
      required this.profileImage,
      required this.email,
      required this.name,
      required this.phoneNumber,
      required this.shopImage,
      required this.verified,
      required this.uid,
      Key? key})
      : super(key: key);

  @override
  State<SellerCompleteProfile> createState() => _SellerCompleteProfileState();
}

class _SellerCompleteProfileState extends State<SellerCompleteProfile> {
  final _fireStore = FirebaseFirestore.instance.collection('SellerCenterUsers');

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.name.toString(),
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SizedBox(
        height: size.height / 1,
        width: size.width / 1,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  const SizedBox(height: 15),
                  widget.profileImage == ''
                      ? const CircleAvatar(
                          radius: 44,
                          backgroundImage: AssetImage('assets/images/img.png'))
                      : CircleAvatar(
                          radius: 44,
                          backgroundImage: NetworkImage(widget.profileImage!),
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${widget.name}",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Phone:    ${widget.phoneNumber}'),
                            Text('Email:    ${widget.email}'),
                            Text('Address:    ${widget.address}'),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            widget.verified == true
                                ? Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      ),
                                      Text('Verified'),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      Icon(
                                        Icons.cancel_outlined,
                                        color: Colors.red,
                                      ),
                                      Text('Not Verified'),
                                    ],
                                  )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            widget.verified == true
                                ? InkWell(
                                    onTap: () {
                                      _fireStore
                                          .doc(widget.uid.toString())
                                          .update({
                                        'Verification': false,
                                      }).then((value) {
                                        Utils.flutterToast(
                                            'Account is Freezed');

                                        Navigator.pop(context);
                                      }).onError((error, stackTrace) {
                                        Utils.flutterToast(error.toString());
                                      });
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                          child: Text(
                                        'Freeze Account',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      )),
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      _fireStore
                                          .doc(widget.uid.toString())
                                          .update({
                                        'Verification': true,
                                      }).then((value) {
                                        Utils.flutterToast(
                                            'Account is Verified');
                                        Navigator.pop(context);
                                      }).onError((error, stackTrace) {
                                        Utils.flutterToast(error.toString());
                                      });
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                          child: Text(
                                        'Verify',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      )),
                                    ),
                                  ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Text(
                          'Shop Image',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Image.network(widget.shopImage.toString()),
                        const SizedBox(height: 30),
                        Text(
                          'CNIC Front Image',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Image.network(widget.cNICFrontImage.toString()),
                        const SizedBox(height: 30),
                        Text(
                          'CNIC Back Image',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Image.network(widget.cNICBackImage.toString()),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                height: 44,
              )
            ],
          ),
        ),
      ),
    );
  }
}
