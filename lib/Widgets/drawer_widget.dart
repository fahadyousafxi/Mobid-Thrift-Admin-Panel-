import 'package:flutter/material.dart';
import 'package:mobidthrift_admin_panel/Screens/reports.dart';
import 'package:mobidthrift_admin_panel/Screens/seller_verification_screen.dart';
import 'package:mobidthrift_admin_panel/Screens/upload_ad.dart';

import '../Screens/home_screen.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              DrawerHeader(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(22)),
                  child: Center(child: const Text('Admin Panel')),
                ),
              ),
              ListTile(
                title: Text(
                  'Home',
                ),
                leading: Icon(Icons.home),
                textColor: Colors.white,
                iconColor: Colors.white,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
              ),
              ListTile(
                title: Text(
                  'Upload Ad',
                ),
                leading: Icon(Icons.add_a_photo_outlined),
                textColor: Colors.white,
                iconColor: Colors.white,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UploadAd()));
                },
              ),
              ListTile(
                title: Text(
                  'Seller Verification',
                ),
                leading: Icon(Icons.verified_user),
                textColor: Colors.white,
                iconColor: Colors.white,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SellerVerificationScreen()));
                },
              ),
              ListTile(
                title: Text(
                  'Reports',
                ),
                leading: Icon(Icons.report_gmailerrorred),
                textColor: Colors.white,
                iconColor: Colors.white,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ReportsScreen()));
                },
              ),
            ],
          ),
        ));
  }
}
