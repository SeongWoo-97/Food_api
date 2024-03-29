import 'package:flutter/material.dart';
import 'package:food_api/screen/result_screen.dart';

class FilterScreen extends StatefulWidget {
  final foodName;

  FilterScreen(this.foodName);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<List<String>> optionList = [
    ['balanced', 'high-fiber', 'high-protein', 'low-carb', 'low-fat', 'low-sodium'],
    ['alcohol-free', 'celery-free', 'crustacean-free', 'dairy-free', 'egg-free', 'fish-free'],
    ['American', 'Asian', 'British', 'Caribbean', 'Central Europe', 'Eastern Europe', 'French', 'Italian', 'Japanese', 'Kosher'],
    ['Breakfast', 'Dinner', 'Lunch', 'Snack', 'Teatime'],
  ];
  List<List<bool>> selected = [[], [], [], []];
  List<String> filterName = ['', '', '', ''];

  List<Widget> buildChip(int i) {
    return List.generate(optionList[i].length, (index) {
      return FilterChip(
        label: Text(optionList[i][index]),
        elevation: 0,
        pressElevation: 5,
        selected: this.selected[i][index],
        onSelected: (bool selected) {
          if (this.selected[i].contains(true)) {
            for (int j = 0; j < this.selected[i].length; j++) {
              this.selected[i][j] = false;
            }
          }
          filterName[i] = '&' + optionList[i][index];
          setState(() {
            this.selected[i][index] = selected;
          });
        },
      );
    });
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < optionList.length; i++) {
      for (int j = 0; j < optionList[i].length; j++) {
        selected[i].add(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Filter Screen'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            child: Card(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Diet',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Wrap(
                      children: buildChip(0),
                      spacing: 7,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Card(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Health',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Wrap(
                      children: buildChip(1),
                      spacing: 7,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Card(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'CuisineType',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Wrap(
                    children: buildChip(2),
                    spacing: 7,
                  )
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Card(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'MealType',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Wrap(
                      children: buildChip(3),
                      spacing: 7,
                    ),
                  )
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              String str = '';
              for(int i = 0; i < filterName.length;i++){
                str += filterName[i];
              }
              print(str);
              Navigator.push(context,MaterialPageRoute(builder: (context) => ResultScreen(widget.foodName,str)));
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
