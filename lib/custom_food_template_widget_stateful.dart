////////////////////////////////////////////////////whole file changed
import 'dart:convert';
import 'user_data_model.dart';
import 'package:flutter/material.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';
import 'FoodPage.dart';
//import 'custom_food_model.dart';

class CustomFoodTemplate extends StatefulWidget {

  CustomFoodTemplate({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<CustomFoodTemplate> createState() => _CustomFoodTemplate();
}

class _CustomFoodTemplate extends State<CustomFoodTemplate> {
  final TextEditingController nameTEC = TextEditingController();
  late final TextEditingController caloriesTEC = TextEditingController();
  final TextEditingController sugarTEC = TextEditingController();
  final TextEditingController sodiumTEC = TextEditingController();
  final TextEditingController fatTEC = TextEditingController();

  void _handleNameChange(String? name) {
    // model.customFood.add(name);
    // print('Now name is ${model.customFood[0].name}');
  }

  void goBack() {
    Navigator.pop(
        context,
        MaterialPageRoute(
            builder: (context) =>  FoodsPage(
                  title: 'Foods Page',
                )));
  }

  void addImage() {}
  Future<void> _addFood() {
    print('Submitted');
    var db = FirebaseFirestore.instance;
    var foodData = {
      'Name': nameTEC.text,
      'Calories': caloriesTEC.text,
      'Suger': sugarTEC.text,
      'Sodium': sodiumTEC.text,
      'Fat': fatTEC.text
    };
    return db.collection('Food').doc(nameTEC.text).set(foodData);
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle preferredTextStyle = TextStyle(fontSize: 24.0);
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.all(15),
      child: Column(children: [
        Align(
            alignment: Alignment.centerRight,
            child:
                IconButton(onPressed: goBack, icon: const Icon(Icons.close))),
        Padding(
            padding: const EdgeInsets.only(top: 40.0, bottom: 25.0),
            child: TextField(
                controller: nameTEC,
                onChanged: _handleNameChange,
                //initialValue: 'chicken',
                style: preferredTextStyle,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Name of Food'))),
        Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: TextField(
                controller: caloriesTEC,
                onChanged: _handleNameChange,
                style: preferredTextStyle,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Amount of Calories'))),
        Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: TextField(
                controller: sugarTEC,
                onChanged: _handleNameChange,
                style: preferredTextStyle,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Amount of Sugar'))),
        Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: TextField(
                controller: sodiumTEC,
                onChanged: _handleNameChange,
                style: preferredTextStyle,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Amount of Sodium'))),
        Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: TextField(
                controller: fatTEC,
                onChanged: _handleNameChange,
                style: preferredTextStyle,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Amount of Fat'))),
        Padding(
            padding: const EdgeInsets.all(25.0),
            child: ElevatedButton(
                onPressed: addImage, child: const Text('ICON ADD IMAGE'))),
        Align(
            alignment: Alignment.bottomRight,
            child: ProgressButton.icon(iconedButtons: {
              ButtonState.idle: IconedButton(
                  text: "Submit",
                  icon: const Icon(Icons.send, color: Colors.white),
                  color: Colors.deepPurple.shade500),
              ButtonState.loading: IconedButton(
                  text: "Loading", color: Colors.deepPurple.shade700),
              ButtonState.fail: IconedButton(
                  text: "Failed",
                  icon: const Icon(Icons.cancel, color: Colors.white),
                  color: Colors.red.shade300),
              ButtonState.success: IconedButton(
                  text: "Success",
                  icon: const Icon(
                    Icons.check_circle,
                    color: Colors.white,
                  ),
                  color: Colors.green.shade400)
            }, onPressed: _addFood, state: ButtonState.idle)),
      ]),
    ));
  }
}


//api code for calorie calculation
// void main() {
//   final future = get(
//       Uri(
//           scheme: 'https',
//           host: 'fitness-calculator.p.rapidapi.com',
//           path: 'dailycalorie',
//           queryParameters: {
//             'age': '25',
//             'gender': 'male',
//             'height': '180',
//             'weight': '70',
//             'activitylevel': 'level_1'
//           }),
//       headers: {
//         'X-RapidAPI-Key': 'aea76086b1msh2c6245001279388p1e39f3jsn91b9f5607b70',
//         'X-RapidAPI-Host': 'fitness-calculator.p.rapidapi.com'
//       });
//   runApp(MaterialApp(home: MyApp(future: future)));
// }

// class MyApp extends StatelessWidget {
//   final Future<Response> future;

//   const MyApp({super.key, required this.future});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(),
//         body: FutureBuilder(
//             future: future,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Text('Waiting');
//               } else if (snapshot.hasData) {
//                 Response response = snapshot.data!;
//                 //print(response.body);
//                 Map<String, dynamic> result = jsonDecode(response.body);
//                 // double calories = result[0]['calories'];
//                 return Text(result.toString(),
//                     style: const TextStyle(fontSize: 24));
//               } else {
//                 return const Text('something else');
//               }
//             }));
//   }
// }