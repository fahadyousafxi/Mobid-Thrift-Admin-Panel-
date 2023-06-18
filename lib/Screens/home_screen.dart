import 'package:flutter/material.dart';
import 'package:mobidthrift_admin_panel/Screens/all_users_screen.dart';
import 'package:mobidthrift_admin_panel/Screens/testing_share_screen.dart';
import 'package:mobidthrift_admin_panel/Widgets/drawer_widget.dart';
import 'package:provider/provider.dart';

import '../Providers/users_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UsersProvider usersProvider = UsersProvider();

  @override
  void initState() {
    UsersProvider userProvider = Provider.of(context, listen: false);
    userProvider.getShopKeepersData();
    userProvider.getUsersData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    usersProvider = Provider.of(context);
    usersProvider.getUsersData();
    usersProvider.getShopKeepersData();

    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Home Screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: DrawerWidget(),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TestingShareScreen(
                            collectionName: 'collectionName',
                            documentId: 'documentId')));
              },
              child: Text('Share Test'),
            ),
            SizedBox(
              height: 22,
            ),
            Text("Total Users"),
            SizedBox(
              height: 22,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllUsersScreen(
                                  dataList: usersProvider.getUsersDataList,
                                  users: 'Customers',
                                )));
                  },
                  child: Container(
                    height: 70,
                    width: size.width / 1 > 500 ? 240 : 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [
                          Colors.red,
                          Colors.blue,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Customers",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            usersProvider.getUsersDataList.length.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllUsersScreen(
                                  dataList:
                                      usersProvider.getShopKeepersDataList,
                                  users: 'Sellers',
                                )));
                  },
                  child: Container(
                    height: 70,
                    width: size.width / 1 > 500 ? 240 : 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [
                          Colors.red,
                          Colors.blue,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Sellers",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            usersProvider.getShopKeepersDataList.length
                                .toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
