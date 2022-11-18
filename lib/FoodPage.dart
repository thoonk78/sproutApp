import 'dart:convert';
import 'user_data_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'HomePage.dart';
import 'custom_food_template_widget_stateful.dart';
import 'food.dart';

class FoodsPage extends StatefulWidget {
  FoodsPage({super.key, required this.title});

  final String title;

  @override
  State<FoodsPage> createState() => _FoodsPageState();
}

class _FoodsPageState extends State<FoodsPage> {
  //late final Future<Response> future;
  int _counter = 0;
  int _selectedIndex = 0; // The index of the food page

  //_FoodsPageState(this.future);

  ///Gets the index of the selected tab in Bottom Navigation bar and goes to that page
  void _onItemTapped(int index) {
    //Navigates to the page with the corresponding Nav bar index
    setState(() {
      _selectedIndex = index;
      Navigator.of(context).pushReplacementNamed('/${index}');
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  //Sampe list of foods
  List<Food> foods = [
    // Food(name: 'Hamburger', img: 'img\\foods\\hamburger.jpg'),
    // Food(name: 'Caesar Salad', img: 'img\\foods\\caesar-salad.jpg'),
    // Food(name: 'Pad Thai', img: 'img\\foods\\pad-thai.jpg'),
    // Food(name: 'Chicken Nuggets', img: 'img\\foods\\chicken-nugget.jpg')
  ];

  final FoodController = TextEditingController();
  UserDataModel user = UserDataModel();

  void getFoodInfo() {
    String foodName = FoodController.text;

    final Future<Response> Meal = get(
        Uri(
            scheme: 'https',
            host: 'nutrition-by-api-ninjas.p.rapidapi.com',
            path: 'v1/nutrition',
            queryParameters: {'query': '$foodName'}),
        headers: {
          'X-RapidAPI-Key':
              'aea76086b1msh2c6245001279388p1e39f3jsn91b9f5607b70',
          'X-RapidAPI-Host': 'nutrition-by-api-ninjas.p.rapidapi.com'
        });
    Meal.then((getResults));
  }

  void getResults(Response res) {
    setState(() {
      var result = jsonDecode(res.body);
      user.updateCalories(result[0]['calories']);
      user.updateFat(result[0]['fat_total_g']);
      user.updateSoduim(result[0]['sodium_mg']);
      user.updateSugar(result[0]['sugar_g']);
    });
  }

  // Template to output the food cards
  Widget foodTemplate(food) {
    return Container(
      height: 150,
      width: 150,
      child: Card(
        surfaceTintColor: Colors.blue,
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: Image.asset(
          '${food.img}',
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  // Template to overlay the food cards in favorite food section
  Widget favoriteFoodsTemplate(food) {
    return Card(
        child: Column(
      children: [
        Stack(
          //places an overlay and an add icon on top of the food cards
          children: [
            foodTemplate(food),
            Container(
              height: 150,
              width: 150,
              child: Card(
                color: Colors.black.withOpacity(0.1),
                surfaceTintColor: Colors.blue,
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 20),
        Text(
          food.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    ));
  }

  // Template to display the most recent foods card
  Widget recentFoodsTemplate(food) {
    return Card(
        child: Column(
      children: [
        foodTemplate(food),
        SizedBox(
          height: 20,
        ),
        Text(
          food.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the FoodsPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Container(
          width: double.infinity,
          height: 40,
          color: Colors.white,
          child: TextField(
            // The search bar
            controller: FoodController,
            decoration: InputDecoration(
                hintText: 'what do you want to eat?',
                prefixIcon: IconButton(
                  onPressed: getFoodInfo,
                  icon: const Icon(Icons.search),
                )),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            const Text(
              'Your favorites',
              style: TextStyle(fontSize: 22),
            ),
            Expanded(
                //Displays all favorite foods cards in favorite foods format
                child: ListView(
              scrollDirection: Axis.horizontal,
              children:
                  foods.map((food) => favoriteFoodsTemplate(food)).toList(),
            )),
            Container(
                height: 50,
                child: const Center(
                    child: Text("What you've had today",
                        style: TextStyle(fontSize: 22)))),
            Expanded(
                child: ListView(
              // Displays all recent foods cards in recent foods format
              scrollDirection: Axis.horizontal,
              children: foods.map((food) => recentFoodsTemplate(food)).toList(),
            )),
            SizedBox(height: 100),
            /*
            FutureBuilder(
                future: future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text('Waiting');
                  } else if (snapshot.hasData) {
                    Response response = snapshot.data!;
                    //print(response.body);
                    List<dynamic> result = jsonDecode(response.body);
                    double calories = result[0]['calories'];
                    return Text(calories.toString(),
                        style: const TextStyle(fontSize: 24));
                  } else {
                    return const Text('something else');
                  }
                })
                */
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        //Button to get to add foods page
        onPressed: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => CustomFoodTemplate()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),

      bottomNavigationBar: BottomNavigationBar(
        // Displays a navigatin bar at the bottom of screen
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Food',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Progress',
          ),
        ],
        currentIndex: _selectedIndex, // The index of the current page
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
