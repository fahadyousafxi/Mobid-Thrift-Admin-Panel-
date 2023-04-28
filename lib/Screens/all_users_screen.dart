import 'package:flutter/material.dart';
import 'package:mobidthrift_admin_panel/Models/users_model.dart';
import 'package:mobidthrift_admin_panel/Screens/user_profile.dart';

class AllUsersScreen extends StatefulWidget {
  List<UsersModel>? dataList;
  String? users;

  AllUsersScreen({required this.dataList, required this.users, Key? key})
      : super(key: key);

  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            widget.users.toString(),
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width / 1 > 500 ? 40 : 15.0),
          child: ListView.builder(
            itemCount: widget.dataList!.length,
            itemBuilder: (BuildContext context, int index) {
              var data = widget.dataList![index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserProfile(
                                name: data.name,
                                phoneNumber: data.phoneNumber,
                                email: data.email,
                                address: data.address,
                                profile: data.profileImage,
                                verified: data.verification,
                              )));
                },
                child: Container(
                  margin: EdgeInsets.only(
                      top: 15,
                      bottom: index == widget.dataList!.length - 1 ? 30 : 0),
                  height: 110,
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
                    child: Row(
                      children: [
                        SizedBox(
                          width: 11,
                        ),
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(data.profileImage
                                      .toString() ==
                                  ''
                              ? 'https://static.vecteezy.com/system/resources/previews/007/033/146/original/profile-icon-login-head-icon-vector.jpg'
                              : data.profileImage.toString()),
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.name.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              data.email.toString(),
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              data.phoneNumber.toString(),
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        )
        // Column(
        //   children: [
        //
        //   ],
        // ),
        );
  }
}
