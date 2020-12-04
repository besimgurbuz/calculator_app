import 'package:flutter/material.dart';

class Button {
  String key;
  String text;
  int action;
  IconData icon;
  bool isCustom;
  bool isWide;

  Button(this.key, this.text, this.action, {this.isWide = false});
  Button.fromIcon(this.key, this.icon, this.action, {this.isWide = false, this.isCustom = false});
}