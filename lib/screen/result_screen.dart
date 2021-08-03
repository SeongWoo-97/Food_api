import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_api/model/recipe.dart';
import 'package:food_api/model/recipe_model.dart';


class ResultScreen extends StatefulWidget {
  final str;
  final foodName;
  ResultScreen(this.foodName,this.str);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<RecipeModel> recipeList = <RecipeModel>[];
  @override
  void initState() {
    super.initState();
    getRecipes();
  }
  getRecipes() async {
    String string = 'https://api.edamam.com/api/recipes/v2?type=public&q=${widget.foodName}&app_id=42262e68&app_key=ce16039476ebbb5eec647c6695cd7411' + widget.str;
    Uri url = Uri.parse(string);
    Recipe recipe = Recipe();
    await recipe.getRecipes(widget.foodName,name: url);
    recipeList = recipe.recipes;
    setState(() {});
  }
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(
            widget.foodName + ' Result List',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_outlined),
            onPressed: () => Navigator.pop(context),
            color: Colors.black,
          ),
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
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        child: Icon(Icons.arrow_forward),
                        onTap: () {},
                      ),
                    )
                  ],
                ),
                elevation: 8.0,
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.filter_list_alt),
          onPressed: () {
          },
        ));
  }
}
