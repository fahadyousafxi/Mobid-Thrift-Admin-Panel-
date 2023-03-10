import 'package:flutter/material.dart';
import 'package:mobidthrift_admin_panel/Widgets/drawer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Home Screen',style: TextStyle(color: Colors.white),),
      ),
      drawer: DrawerWidget(),
      body: Center(
        child: Text("Welcome!! to Admin Panel"),
      ),
    );
  }
}
