import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:mobidthrift_admin_panel/Providers/seller_verification_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import 'Providers/reports_provider.dart';
import 'Providers/users_provider.dart';
import 'Screens/home_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  PendingDynamicLinkData? initialLink =
      await FirebaseDynamicLinks.instance.getInitialLink();

  // FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
  //   initialLink = dynamicLinkData;
  //   log('the dynamic link $dynamicLinkData');
  // }).onError((error) {
  //   log('Error in dynamic link $error');
  // });

  runApp(MyApp(initialLink: initialLink));
}

class MyApp extends StatefulWidget {
  final PendingDynamicLinkData? initialLink;

  const MyApp({super.key, required this.initialLink});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  String? path;

  @override
  initState() {
    if (widget.initialLink != null) {
      path = widget.initialLink!.link!.path;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('${path}: Its the path');
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SellerVerificationProvider>(
          create: (context) => SellerVerificationProvider(),
        ),
        ChangeNotifierProvider<UsersProvider>(
          create: (context) => UsersProvider(),
        ),
        ChangeNotifierProvider<ReportsProvider>(
          create: (context) => ReportsProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
        // home: MyHomePage(path: path
        //     // 'https://mobidthriftsellercenter.page.link/collectionName/2345234234234'
        //     ),
      ),
    );
  }
}

/// Testing of sharing

class MyHomePage extends StatefulWidget {
  String? path;
  MyHomePage({super.key, required this.path});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    initDynamicLinks();
    WidgetsBinding.instance.addPostFrameCallback((c) => openTheProduct());

    // initUniLinks();
  }

  StreamSubscription? _dynamicLinkStreamSubscription;
  String? _link;

  String? collectionName;
  String? documentID;
  @override
  void dispose() {
    _dynamicLinkStreamSubscription?.cancel();
    super.dispose();
  }

  Future<void> initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink.listen(
      (PendingDynamicLinkData dynamicLinkData) {
        _handleLinkData(dynamicLinkData);
      },
      onError: (error) {
        print('Error handling dynamic link: $error');
      },
    );

    final PendingDynamicLinkData? initialLinkData =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (initialLinkData != null) {
      _handleLinkData(initialLinkData!);
    }
  }

  void _handleLinkData(PendingDynamicLinkData data) {
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      setState(() {
        _link = deepLink.path;
      });
      Uri uri = Uri.parse(_link!);
      String collection = uri.pathSegments[0];
      String documentId = uri.pathSegments[1];
      collectionName = collection; //widget.path;
      documentID = documentId;

      // Navigating to the appropriate page based on the dynamic link
      // if (_link!.contains('/collection')) {
      if (collectionName != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TestingShareScreen(
                collectionName: collectionName!, documentId: documentID!),
          ),
        );
      }
    }
  }

  openTheProduct() {
    if (widget.path != null) {
      log('path is not null');
      Uri uri = Uri.parse(widget.path!);
      String collection = uri.pathSegments[0];
      String documentId = uri.pathSegments[1];
      collectionName = collection; //widget.path;
      documentID = documentId; //widget.path;

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TestingShareScreen(
                  collectionName: collectionName!, documentId: documentID!)));
    } else {
      log('Sorry path is null');
    }
  }

  // Future<void> initUniLinks() async {
  //   // Check if the app was opened from a deep link
  //   try {
  //     String? initialLink = await getInitialLink();
  //
  //     if (initialLink != null) {
  //       Uri uri = Uri.parse(initialLink);
  //       String collection = uri.pathSegments[0];
  //       String documentId = uri.pathSegments[1];
  //
  //       if (collection == 'Accessories') {
  //         // Navigate to the TestingShareScreen passing the collection and documentId
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => TestingShareScreen(
  //               collectionName: collection,
  //               documentId: documentId,
  //             ),
  //           ),
  //         );
  //       }
  //     }
  //   } on PlatformException {
  //     // Handle any exceptions while getting the initial link
  //   }
  //
  //   // ...
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deep Link Example ${widget.path}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                print('name: $collectionName  Id: $documentID');
                final dynamicLinkParameters = DynamicLinkParameters(
                    link: Uri.parse(
                        'https://mobidthriftsellercenter.com/$collectionName/$documentID'),
                    uriPrefix: 'https://mobidthriftsellercenter.page.link',
                    androidParameters: AndroidParameters(
                      packageName: 'com.example.mobidthrift_admin_panel',
                    ),
                    iosParameters: IOSParameters(
                      bundleId: 'com.example.mobidthrift_admin_panel',
                    ));

                Uri link = await FirebaseDynamicLinks.instance
                    .buildLink(dynamicLinkParameters);
                // Use the deepLink variable wherever you want to provide the link to the user
                print(link.toString());
                Share.share(link.toString());
              },
              child: Text('Generate Deep Link'),
            ),
            ElevatedButton(
              onPressed: () async {
                print('name: $collectionName  Id: $documentID');
                final dynamicLinkParameters = DynamicLinkParameters(
                    link: Uri.parse(
                        'https://mobidthriftsellercenter.com/collectionName1/documentID1'),
                    uriPrefix: 'https://mobidthriftsellercenter.page.link',
                    androidParameters: AndroidParameters(
                      packageName: 'com.example.mobidthrift_admin_panel',
                    ),
                    iosParameters: IOSParameters(
                      bundleId: 'com.example.mobidthrift_admin_panel',
                    ));

                Uri link = await FirebaseDynamicLinks.instance
                    .buildLink(dynamicLinkParameters);
                // Use the deepLink variable wherever you want to provide the link to the user
                print(link.toString());
                Share.share(link.toString());
              },
              child: Text('Generate Deep Link'),
            ),
            ElevatedButton(
              onPressed: () async {
                print('name: $collectionName  Id: $documentID');
                final dynamicLinkParameters = DynamicLinkParameters(
                    link: Uri.parse(
                        'https://mobidthriftsellercenter.com/collection/documentID'),
                    uriPrefix: 'https://mobidthriftsellercenter.page.link',
                    androidParameters: AndroidParameters(
                      packageName: 'com.example.mobidthrift_admin_panel',
                    ),
                    iosParameters: IOSParameters(
                      bundleId: 'com.example.mobidthrift_admin_panel',
                    ));

                Uri link = await FirebaseDynamicLinks.instance
                    .buildLink(dynamicLinkParameters);
                // Use the deepLink variable wherever you want to provide the link to the user
                print(link.toString());
                Share.share(link.toString());
              },
              child: Text('Generate Deep Link'),
            ),
          ],
        ),
      ),
    );
  }
}

class TestingShareScreen extends StatelessWidget {
  final String collectionName;
  final String documentId;

  TestingShareScreen({required this.collectionName, required this.documentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testing Share Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Collection Name: $collectionName'),
            Text('Document ID: $documentId'),
          ],
        ),
      ),
    );
  }
}
