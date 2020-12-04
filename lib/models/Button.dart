import 'package:flutter/material.dart';

class Button {
  String key;
  String text;
  int action;
  IconData icon;

  Button(this.key, this.text, this.action);
  Button.fromIcon(this.key, this.icon, this.action);
}