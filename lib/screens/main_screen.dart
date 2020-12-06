import 'package:calculator_app/models/button.dart';
import 'package:calculator_app/screens/buttons_screen.dart';
import 'package:calculator_app/screens/display_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Button> _clickedData = [];
  List<String> _displayData = [];
  List<String> _parenthesesValidation = [];
  bool _isDirty = false;
  bool _isCurrentNumFloat = false;

  void clickActionHandler(Button clickedBtn) {
    setState(() {
      this._clickedData = displayClickedAction(clickedBtn);
      if (clickedBtn.action != 2) {
        this._displayData = this._clickedData.map((e) => e.text).toList();
      }
      this._isDirty = clickedBtn.action == 0 ||
          this._clickedData.length > 0 ||
          this._displayData.length > 0;
    });
  }

  List<Button> displayClickedAction(Button clickedBtn) {
    List<Button> holder = this._clickedData;
    switch (clickedBtn.action) {
      case 0: // number
        holder.add(clickedBtn);
        return holder;
      case 1: // math operand
        if (_clickedData.last != null && _clickedData.last.action != 1) {
          holder.add(clickedBtn);
          this._isCurrentNumFloat = false;
        }
        return holder;
      case 2: // calculate
        this._displayData = calculateResult();
        if (this._displayData.join('') == 'Infinity') {
          return [];
        }
        return this
            ._displayData
            .map((e) => e != ',' ? Button('0', e, 0) : Button('0', e, 4))
            .toList();
      case 3: // parentheses
        if (clickedBtn.text == '(' && this._parenthesesValidation.length == 0) {
          if (this._clickedData.length == 0 ||
              this._clickedData.last.action == 1) {
            this._parenthesesValidation.add(clickedBtn.text);
            holder.add(clickedBtn);
          }
        } else if (clickedBtn.text == ')' &&
            this._parenthesesValidation.last == '(') {
          this._parenthesesValidation.removeLast();
          holder.add(clickedBtn);
        }
        return holder;
      case 4: // comma
        if (this._clickedData.last.action == 0 && !this._isCurrentNumFloat) {
          holder.add(clickedBtn);
          this._isCurrentNumFloat = true;
        }
        return holder;
      case -1:
        holder.clear();
        this._parenthesesValidation.clear();
        this._isCurrentNumFloat = false;
        return holder;
    }
    return holder;
  }

  List<String> calculateResult() {
    RegExp parenthesesExp = RegExp(
        r"\(((?:\-)?[0-9]+(?:\,[0-9]+)?)([\*\/\%\+\-])([0-9]+(?:\,[0-9]+)?)\)");
    RegExp primaryOp = RegExp(
        r"((?:\-)?[0-9]+(?:\,?\.?[0-9]+)?)([\*\/\%])([0-9]+(?:\,?\.?[0-9]+)?)");
    RegExp secondaryOp = RegExp(
        r"((?:\-)?[0-9]+(?:\,?\.?[0-9]+)?)([\+\-])([0-9]+(?:\,?\.?[0-9]+)?)");
    String stringData = this._displayData.join();

    String result = stringData.replaceAllMapped(parenthesesExp, (Match match) {
      return calc(match.group(1), match.group(2), match.group(3));
    });

    do {
      result = result.replaceAllMapped(primaryOp, (match) {
        return calc(match.group(1), match.group(2), match.group(3));
      });

      result = result.replaceAllMapped(secondaryOp, (match) {
        return calc(match.group(1), match.group(2), match.group(3));
      });
    } while (primaryOp.hasMatch(result) || secondaryOp.hasMatch(result));

    if (result == 'Infinity') {
      return result.split('');
    }

    double doubleResult = double.parse(result);
    if (doubleResult % 1 > 0) {
      result = result.replaceAll('.', ',');
      this._isCurrentNumFloat = true;
    } else {
      int intResult = doubleResult.toInt();
      return "$intResult".split('');
    }
    return result.split('');
  }

  String calc(String s1, String op, String s2) {
    double n1 = double.parse(s1.replaceAll(',', '.'));
    double n2 = double.parse(s2.replaceAll(',', '.'));
    switch (op) {
      case '*':
        return "${n1 * n2}";
      case '/':
        if (n2 == 0) {
          Fluttertoast.showToast(
              msg: 'To infinity and beyond!',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          return "Infinity";
        }
        return "${n1 / n2}";
      case '%':
        if (n2 == 0) {
          Fluttertoast.showToast(
              msg: 'To infinity and beyond!',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);
          return "Infinity";
        }
        return "${n1 % n2}";
      case '+':
        return "${n1 + n2}";
      case '-':
        return "${n1 - n2}";
    }
    return "";
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
            DisplayScreen(
              data: this._displayData,
            ),
            ButtonsScreen(
              clickActionHandler,
              isDirty: _isDirty,
            )
          ],
        ));
  }
}
