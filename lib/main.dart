import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobidthrift_admin_panel/Providers/seller_verification_provider.dart';
import 'package:mobidthrift_admin_panel/Screens/home_screen.dart';
import 'package:provider/provider.dart';

import 'Providers/reports_provider.dart';
import 'Providers/users_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
      ),
    );
  }
}
