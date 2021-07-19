import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_api/model/recipe.dart';
import 'package:food_api/model/recipe_model.dart';

class FoodScreen extends StatefulWidget {
  final foodName;

  FoodScreen(this.foodName);

  @override
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  List<RecipeModel> recipeList = <RecipeModel>[];
  int num = 0;

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  getRecipes() async {
    Recipe recipe = Recipe();
    await recipe.getRecipes(widget.foodName);
    recipeList = recipe.recipes;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(
            widget.foodName + ' List',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: recipeList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: CachedNetworkImage(
                                imageUrl: recipeList[index].image,
                                width: 150,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                recipeList[index].label,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Source : ' + recipeList[index].source,
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                'Calories : ' + recipeList[index].calories.ceil().toString() + ' kcal',
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                'TotalWeight : ' + recipeList[index].totalWeight.ceil().toString() + 'g',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        child: Icon(Icons.arrow_forward),
                        onTap: () {},
                      )
                    ],
                  ),
                  elevation: 8.0,
                ),
              );
            }));
  }
}
