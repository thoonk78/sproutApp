import 'package:flutter/material.dart';

class CustomFood {
  //put in different file
  String? name;
  double? calories;
  double? sugar;
  double? sodium;
  double? serving;
  CustomFood({this.name, this.calories, this.sugar, this.sodium, this.serving});
}

class CustomFoodModel extends ChangeNotifier {
  List<CustomFood> customFood = [];
  //   CustomFood(name: 'Chidi', actor: 'William Jackson Harper', numYearsInRole: 6),
  // CustomFood(name: 'Michael', actor: 'Ted Danson', numYearsInRole: 5),
  // CustomFood(name: 'Eleanor', actor: 'Kirsten Bell', numYearsInRole: 4),
  // Role(name: 'Tahini', actor: 'Jamil Jameela', numYearsInRole: 3),
}
