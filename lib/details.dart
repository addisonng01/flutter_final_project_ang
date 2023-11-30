import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final String item;

  DetailsScreen({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Screen'),
      ),
      body: Center(
        child: Text('Selected Item: $item'),
      ),
    );
  }
}