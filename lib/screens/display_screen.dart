import 'package:flutter/material.dart';

class DisplayScreen extends StatelessWidget {
  DisplayScreen({
    this.data
  });
  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Text(this.data, style: TextStyle(color: Colors.white),),
    );
  }
}

