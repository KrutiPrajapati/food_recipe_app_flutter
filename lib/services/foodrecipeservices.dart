import 'dart:convert';
import 'package:foodrecipeapp/models/recipeModel.dart';
import 'package:http/http.dart' as http;

class FoodRecipeServices {
  Future<List<RecipeModel>> getRecipeData(String ingredient) async {
    List<RecipeModel> recipes = [];

    final queryParameters = {
      'q': ingredient,
      'app_id': 'add your app_id',
      'app_key': 'add your application key',
    };

    final uri = Uri.https('api.edamam.com', '/search', queryParameters);

    final response = await http.get(uri);

    final jsonData = jsonDecode(response.body);

    if (jsonData.containsKey("hits")) {

      final hits = jsonData["hits"] as List<dynamic>;

      recipes = hits.map((element) {
        final recipeData = element["recipe"];
        final recipeModel = RecipeModel.fromJson(recipeData);
        print('Recipe: ${recipeModel.label}, Source: ${recipeModel.source}, url: ${recipeModel.url}');
        return recipeModel;
      }).toList();
    }

    return recipes;
  }
}
