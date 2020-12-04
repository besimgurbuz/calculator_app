import 'package:calculator_app/screens/buttons_screen.dart';
import 'package:calculator_app/screens/display_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _displayData = '10000';

  void setDisplay() {
    setState(() {
      this._displayData += '1';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DisplayScreen(data: this._displayData,),
          ButtonsScreen()
        ],
      )
    );
  }
}
