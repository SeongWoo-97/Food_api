import 'dart:async';
import 'dart:convert';
import 'package:food_api/model/recipe_model.dart';
import 'package:http/http.dart' as http;

class Recipe {
  List<RecipeModel> recipes = [];

  Future<void> getRecipes(String food) async {
    Uri url = Uri.parse('https://api.edamam.com/search?q=$food&app_id=42262e68&app_key=ce16039476ebbb5eec647c6695cd7411');
// "https://api.edamam.com/api/recipes/v2?type=public&q=Chicken&app_id=42262e68&app_key=ce16039476ebbb5eec647c6695cd7411"
    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['more'] == true) {
      jsonData['hits'].forEach((element) {
        if (element['recipe']['url'] != null && element['recipe']['image'] != null) {
          RecipeModel recipeModel = RecipeModel(
            label: element['recipe']['label'],
            image: element['recipe']['image'],
            source: element['recipe']['source'],
            shareAs: element['recipe']['shareAs'],
            calories: element['recipe']['calories'],
            totalWeight: element['recipe']['totalWeight'],
          );
          recipes.add(recipeModel);
        }
      });
    }
  }
}
