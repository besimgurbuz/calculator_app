import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DisplayScreen extends StatelessWidget {
  DisplayScreen({this.data});
  final List<String> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      alignment: AlignmentDirectional.bottomEnd,
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        reverse: true,
        children: [
          Text(
            this.data.join(''),
            style: TextStyle(color: Colors.white, fontSize: 40),
          )
        ],
      ),
    );
  }
}
