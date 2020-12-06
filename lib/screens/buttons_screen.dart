import 'package:calculator_app/models/button.dart';
import 'package:calculator_app/models/custom_icons.dart';
import 'package:flutter/material.dart';

class ButtonsScreen extends StatelessWidget {
  final Function clickAction;
  final bool isDirty;
  ButtonsScreen(this.clickAction, {this.isDirty = false});

  final List<Button> buttons = [
    Button('0', 'AC', -1),
    Button('2', '%', 1),
    Button.fromIcon('3', CustomIcons.divide, 1, isCustom: true, text: '/'),
    Button.fromIcon('7', Icons.clear_rounded, 1, text: '*'),
    Button('4', '7', 0),
    Button('5', '8', 0),
    Button('6', '9', 0),
    Button.fromIcon('11', Icons.horizontal_rule_rounded, 1, text: '-'),
    Button('8', '4', 0),
    Button('9', '5', 0),
    Button('10', '6', 0),
    Button.fromIcon('15', Icons.add_rounded, 1, text: '+'),
    Button('12', '1', 0),
    Button('13', '2', 0),
    Button('14', '3', 0),
    Button('17', ',', 4),
    Button('16', '0', 0, isWide: true),
    Button('16', '(', 3, isWide: true),
    Button('16', ')', 3, isWide: true),
    Button.fromIcon('18', CustomIcons.equals, 2, isCustom: true, text: '='),
  ];

  Function pressAction(Button btn) {
    return () => this.clickAction(btn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 150,
      child: GridView.count(
        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
        crossAxisCount: 4,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        children: buttons.map((element) {
          return SizedBox(
              child: MaterialButton(
            color: element.action != 0
                ? Color.fromRGBO(250, 142, 18, 1)
                : Color.fromRGBO(213, 214, 216, 1),
            splashColor: element.action == 1
                ? Color.fromRGBO(211, 114, 4, 1)
                : Color.fromRGBO(158, 158, 158, 1),
            elevation: 2.0,
            shape: CircleBorder(),
            onPressed: pressAction(element),
            child: element.icon == null
                ? Text(
                    element.text == 'AC' && this.isDirty ? 'C' : element.text,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: element.action != 0
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  )
                : Icon(
                    element.icon,
                    size: element.isCustom ? 24 : 36,
                  ),
          ));
        }).toList(),
      ),
    );
  }
}
