import 'package:flutter/material.dart';

// class UserData {
//   String? name;
//   double? weight;
//   int? heightInFT;
//   int? heightInIN;
//   double? heightInCM;
//   double? goalWeight;
//   String? gender;
//   double? calorieLimit;
//   double? fatLimit;
//   double? sodiumLimit;
//   double? waterLimit;
//   double? sugarLimit;
//   int? age;
//   int? curCal;
//   int? curFat;
//   int? curSodium;
//   int? curWater;
//   int? curSugar;

//   UserData(
//       {this.name,
//       this.weight,
//       this.heightInFT,
//       this.heightInIN,
//       this.heightInCM,
//       this.goalWeight,
//       this.gender,
//       this.calorieLimit,
//       this.fatLimit,
//       this.sodiumLimit,
//       this.waterLimit,
//       this.sugarLimit,
//       this.age,
//       this.curCal,
//       this.curFat,
//       this.curSodium,
//       this.curWater,
//       this.curSugar});
// }

class UserDataModel extends ChangeNotifier {
  //put in different file
  String name = 'Defualt Name';
  double weight = 0;
  int heightInFT = 0;
  int heightInIN = 0;
  double heightInCM = 0;
  double goalWeight = 0;
  String gender = '';
  double calorieLimit = 1500;
  double fatLimit = 50;
  double sodiumLimit = 100;
  double waterLimit = 80;
  double sugarLimit = 0;
  int age = 0;
  double curCal = 0;
  double curFat = 0;
  double curSodium = 0;
  double curWater = 0;
  double curSugar = 0;

  UserDataModel();

  setSugar() {
    sugarLimit = calorieLimit * 10;
  }

  updateCalories(int addedCal) {
    curCal = curCal + addedCal;
  }

  updateFat(int addedFat) {
    curFat = curFat + addedFat;
  }

  updateSoduim(int addedSod) {
    curSodium = curSodium + addedSod;
  }

  updateSugar(int addedSugar) {
    curSugar = curSugar + addedSugar;
  }

  updateWater(int addedWater) {
    curWater = curWater + addedWater;
  }

  convertHeight() {
    heightInCM = heightInFT * 12;
    heightInCM += heightInIN;
    heightInCM *= 2.54;
  }

}

