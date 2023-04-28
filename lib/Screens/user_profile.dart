import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  String? name;
  String? email;
  String? address;
  String? phoneNumber;
  String? profile;
  bool? verified;
  UserProfile(
      {required this.name,
      required this.phoneNumber,
      required this.email,
      required this.address,
      required this.profile,
      this.verified,
      Key? key})
      : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(widget.profile.toString() == ''
                      ? 'https://static.vecteezy.com/system/resources/previews/007/033/146/original/profile-icon-login-head-icon-vector.jpg'
                      : widget.profile.toString()),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '${widget.name.toString()}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Email: ${widget.email.toString()}',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Phone: ${widget.phoneNumber.toString()}',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Address: ${widget.address.toString()}',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      widget.verified == null
                          ? SizedBox()
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Verified: ',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  width: 22,
                                ),
                                widget.verified == true
                                    ? Icon(
                                        Icons.done_rounded,
                                        color: Colors.green,
                                      )
                                    : Icon(
                                        Icons.cancel_outlined,
                                        color: Colors.red,
                                      )
                              ],
                            ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
