import '../models/recipe_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ApiService {
  final String API_URL = "https://amberclass.fimijm.com/api/v1/recipes";

//Future method to fetch all recipes
  Future<List<Recipe>> fetchRecipe() async {
    final response = await http.get(Uri.parse(API_URL));
    if (response.statusCode == 200) {
//First format the return response.body and then return it
      return formatRecipeAsList(response.body);
    } else {
      throw Exception('Unable to fetch recipes from the REST API');
    }
  }

//This method formats the json string and returns a "List of Recipes"
  List<Recipe> formatRecipeAsList(String responseBody) {
    final parsed = json.decode(responseBody);
    return parsed['data']['recipes']
        .map<Recipe>((json) => Recipe.fromJson(json))
        .toList();
  }

//This formats the json string and returns a Recipe Object
  Recipe formatRecipe(String responseBody) {
    final parsed = json.decode(responseBody);
    return parsed['data']['recipes']
        .map<Recipe>((json) => Recipe.fromJson(json));
  }

  Future<Recipe> createRecipe(Recipe recipe) async {
    Map data = {
      'title': recipe.title,
      'image': recipe.imageUrl,
      'description': recipe.description
    };
    final http.Response response = await http.post(
      Uri.parse(API_URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 201) {
// print('Response Body: $response.body');
      return formatRecipe(response.body);
    } else {
      throw Exception('Failed to post Recipe');
    }
  }

  Future<String> updateRecipe(String id, Recipe recipe) async {
    Map data = {
      'title': recipe.title,
      'image': recipe.imageUrl,
      'description': recipe.description
    };
    final http.Response response = await http.patch(
      Uri.parse('$API_URL/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
// print('Body in Update: $data');
    if (response.statusCode == 200) {
//return formatRecipe(response.body);
      return response.body;
    } else {
      throw Exception('Failed to update a recipe');
    }
  }

  Future<void> deleteRecipe(String id) async {
    http.Response res = await http.delete(Uri.parse('$API_URL/$id'));
    print('id in Delete: $id');
    if (res.statusCode == 204) {
      print("Recipe deleted");
    } else {
      throw "Failed to delete a recipe.";
    }
  }
}
