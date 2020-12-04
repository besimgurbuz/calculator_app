import 'package:calculator_app/models/Button.dart';
import 'package:flutter/material.dart';

class ButtonsScreen extends StatelessWidget {
  final List<Button> buttons = [
    Button('0', 'AC', 1),
    Button('1', '+/-', 1),
    Button('2', '%', 1),
    Button('3', '/', 1),
    Button('4', '7', 0),
    Button('5', '8', 0),
    Button('6', '9', 0),
    Button.fromIcon('7', Icons.clear, 1),
    Button('8', '4', 0),
    Button('9', '5', 0),
    Button('10', '6', 0),
    Button.fromIcon('11', Icons.horizontal_rule, 1),
    Button('12', '1', 0),
    Button('13', '2', 0),
    Button('14', '3', 0),
    Button.fromIcon('15', Icons.add, 1),
    Button('16', '0', 0),
    Button('16', ',', 0),
    Button('16', '=', 1),
  ];

  Function pressAction(String btn) {
    return () => print(btn);
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 150,
      child: GridView.count(
        padding: EdgeInsets.all(0),
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: buttons.map((element) {
          return Container(
            height: 100,
            width: element.text == '0' ? MediaQuery.of(context).size.width / 2 : MediaQuery.of(context).size.width / 4,
            child: RawMaterialButton(
              fillColor: element.action == 1 ? Color.fromRGBO(250, 142, 18, 1) : Color.fromRGBO(213, 214, 216, 1),
              splashColor: Color(0x000),
              elevation: 2.0,
              shape: CircleBorder(),
              onPressed: pressAction(element.key),
              child: element.icon == null ? Text(
                element.text,
                style: TextStyle(
                  fontSize: 30,
                ),
              ) : Icon(
                element.icon,
                size: 35,
              ),
            )
          );
        }).toList(),
      ),
    );
  }
}
