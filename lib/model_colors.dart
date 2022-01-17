import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangeColor extends ChangeNotifier {
  Color color;
  ChangeColor(this.color) {}
  var counter = 0;
  var colors = [Colors.blue, Colors.red, Colors.green];

  void changeColor() {
    this.color = colors[counter];
    notifyListeners();
    counter++;
    if (counter == 3) counter = 0;
  }
}
