import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndialog/ndialog.dart';
import '../Widgets/drawer_widget.dart';
import '../utils/utils.dart';

class UploadAd extends StatefulWidget {
  const UploadAd({Key? key}) : super(key: key);

  @override
  State<UploadAd> createState() => _UploadAdState();
}

class _UploadAdState extends State<UploadAd> {

  final  _fireStore = FirebaseFirestore.instance.collection('BannerAd');

  File? pickedImage;
  bool showLocalImage = false;
  pickImageFrom(ImageSource fromGalleryOrCamera) async {
    XFile? file = await ImagePicker()
        .pickImage(source: fromGalleryOrCamera, imageQuality: 80);
    if (file == null) {
      return;
    }

    pickedImage = File(file.path);
    showLocalImage = true;
    setState(() {});
    ProgressDialog progressDialog =  ProgressDialog(
      context,
      title:  Text('Uploading !!!'),
      message:  Text('Please wait'),
    );
    progressDialog.show();
    try{
      var fileName = "asdfasdfasdfasdf" + '.jpg';
      UploadTask uploadTask = FirebaseStorage.instance.ref().child('Banner_Ad').child(fileName).putFile(pickedImage!);
      TaskSnapshot snapshot = await uploadTask;
      String bannerAdUrl = await snapshot.ref.getDownloadURL();
      print(bannerAdUrl);
      _fireStore.doc("asdfasdfasdfasdf").update({
        'Banner_Ad' : bannerAdUrl,
      });
      progressDialog.dismiss();
      Utils.flutterToast(' Image Added Successfully ');
    } catch( e ){
      progressDialog.dismiss();
      print(e.toString());
      Utils.flutterToast(e.toString());
    }

  }

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Upload Your Ad',style: TextStyle(color: Colors.white),),
      ),
      drawer: DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Container(
              //   height: 33,
              //   width: 1100,
              //   color: MediaQuery.of(context).size.width  >= 700 ? Colors.red : Colors.black,
              // ),
              SizedBox(
                width: MediaQuery.of(context).size.width  >= 700 ? MediaQuery.of(context).size.width / 3 : MediaQuery.of(context).size.width / 1.5,
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(hintText: 'Enter A Title')
                ),
              ),
              SizedBox(height: 15,),
              SizedBox(
                  // width: double.infinity,
                  height: MediaQuery.of(context).size.height / 2 >= 1000 ? MediaQuery.of(context).size.height / 4 : MediaQuery.of(context).size.height / 2.5,
                  child: Center(
                    child: InkWell(
                      onTap: (){
                        pickImageFrom(ImageSource.gallery);
                      },
                      child: AspectRatio(
                      aspectRatio: 10/6,
                      child: Container(
                        color: Colors.grey.shade300,
                        child: showLocalImage == false ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_a_photo_outlined, size: 44,),
                              SizedBox(height: 22,),
                              Text("Add Your Image"),
                            ],
                          ),
                        ): SizedBox(
                          height: MediaQuery.of(context).size.height / 2 == 1000 ? MediaQuery.of(context).size.height / 4 : MediaQuery.of(context).size.height / 2,
                          child: Center(
                          child: AspectRatio(
                            aspectRatio: 10/6,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(22),
                              onTap: () {
                                // pickImageFrom(ImageSource.gallery);
                              },
                              child: Center(child: const Text("Image Added Successfully")),
                              // child: Image(image:
                              // NetworkImage( 'https://alumni.engineering.utoronto.ca/files/2022/05/Avatar-Placeholder-400x400-1.jpg'),)
                            ),
                          ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              ElevatedButton(onPressed: (){

                if(showLocalImage == true && _controller.text.toString() != null) {

                  _fireStore.doc("asdfasdfasdfasdf").update({
                    'Title' : _controller.text.toString(),
                  });
                  Utils.flutterToast('Banner Ad is Uploaded');
                } else {
                  Utils.flutterToast('Please fill the field and add Image');
                }

              }, child: Text("Upload"))

            ],
          ),
        ),
      ),
    );
  }
  Future bottomSheet(context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('With Camera'),
                  onTap: () {
                    pickImageFrom(ImageSource.camera);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.storage),
                  title: const Text('From Gallery'),
                  onTap: () {
                    pickImageFrom(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }
}
