import 'package:flutter/material.dart';

class TestingShareScreen extends StatelessWidget {
  final String? collectionName;
  final String? documentId;
  const TestingShareScreen(
      {required this.collectionName, required this.documentId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('data'),
      ),
    );
  }
}
