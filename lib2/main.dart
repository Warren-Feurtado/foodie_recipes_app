import 'package:flutter/material.dart';
import 'recipe.dart';
import  'recipe_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foodie Recipe',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Foodie Recipe App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
/*  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
*/
  late Future<List<Recipe>> recipeList;
  @override
  void initState(){
    super.initState();
    // recipeList = getAllRecipes2();
    recipeList = fetchRecipe();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        //AppBar has a title property that is passed in by the
        // home: const MyHomePage(title: 'Foodie Recipe App') and is displayed
        // in the Text widget
        title: Text(widget.title),
      ),
      body: SafeArea(
        child:   FutureBuilder<List<Recipe>>(
          future: recipeList,
          builder: (context, snapshot) {
            if(snapshot.hasError) print(snapshot.error);
             return snapshot.hasData ? displayRecipes(items: snapshot.data!) :
                 const Center(child: CircularProgressIndicator(),);
          }
        ),
      ),
    );
  }

  /***
   
      FutureBuilder<List<Recipe>>(
      future: getAllRecipes2(),
      builder: (context, snapshot) => ListView.builder(
      itemCount: Recipe.sampleRecipes2.length ,
      // itemCount determines the number of rows that the list has
      itemBuilder: (BuildContext context, int index){
      //itemBuilder - This builds the widget tree for each row
      //TODO: we will replace the list below to return a Material Design  Recipe Card
      //return Text(Recipe.sampleRecipes[index].label);
      //return buildRecipeCard(Recipe.sampleRecipes[index]);
      //return buildRecipeCard2(Recipe.sampleRecipes[index]);
      //TODO: Add Gesture Detector to naviigate to details Page
      // Gesture Detector Implementation
      return procDetailPage(context, index);
      },
      ),
      ),
      ),
   */

  /***
   * ListView.builder(
      itemCount: Recipe.sampleRecipes.length ,
      // itemCount determines the number of rows that the list has
      itemBuilder: (BuildContext context, int index){
      //itemBuilder - This builds the widget tree for each row
      //TODO: we will replace the list below to return a Material Design  Recipe Card
      //return Text(Recipe.sampleRecipes[index].label);
      //return buildRecipeCard(Recipe.sampleRecipes[index]);
      //return buildRecipeCard2(Recipe.sampleRecipes[index]);
      //TODO: Add Gesture Detector to naviigate to details Page
      // Gesture Detector Implementation
      return procDetailPage(context, index);
      },
      ),
   */
  Widget displayRecipes({required List<Recipe> items}){
    return ListView.builder(
      itemCount: items.length ,
      // itemCount determines the number of rows that the list has
      itemBuilder: (BuildContext context, int index){
        //itemBuilder - This builds the widget tree for each row
        //TODO: we will replace the list below to return a Material Design  Recipe Card
        //return Text(items[index].title);
        //return buildRecipeCard(Recipe.sampleRecipes[index]);
        //return buildRecipeCard2(Recipe.sampleRecipes[index]);
        //TODO: Add Gesture Detector to naviigate to details Page
        // Gesture Detector Implementation
        //return procDetailPage(context, index);
        return procDetailPage2(context, index, items);
      },
    );
  }
  //TODO: add method buildRecipeCard() here
  //Building the list in a simple listview may not be ideal for a real-world app
  //To add a little UX we might use a Material Design Card.
  // A Card defines a section of the UI where information about a specific entity
  // can be laid out
  Widget buildRecipeCard(Recipe recipe){
    return Card(
      child: Column(
        children: <Widget> [
          Image(image: AssetImage(recipe.imageUrl)),
          Text(recipe.title),
        ],
      ),
    );
  }

  Widget buildRecipeCard2(Recipe recipe, {bool isAsset = false}){

    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0)
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
              children: <Widget> [
                isAsset == true ?  Image(image: AssetImage(recipe.imageUrl)):
                                   Image(image: NetworkImage(recipe.imageUrl),),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      recipe.title,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Palatino',
                      ),
                    ),
              ],
            ),
        ),

    );
  }
  Widget buildRecipeCard3(Recipe recipe){

    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: <Widget> [
            Image(image: AssetImage(recipe.imageUrl)),
            const SizedBox(
              height: 12.0,
            ),
            Text(
              recipe.title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                fontFamily: 'Palatino',
              ),
            ),
          ],
        ),
      ),

    );
  }

  Widget procDetailPage(BuildContext context, int index){
    return GestureDetector(
      onTap: (){
          Navigator.push(context,
          MaterialPageRoute(builder: (context){
            //return const Text('Recipe Detail Page');
            //TODO: change to an actual Recipe detail Page
             return RecipeDetail(recipe: Recipe.sampleRecipes[index],);
           },
          ),
        );
      },
      child: buildRecipeCard2(Recipe.sampleRecipes[index]),
    );
  }

  Widget procDetailPage2(BuildContext context, int index, List<Recipe> item){
    return GestureDetector(
      onTap: (){
        Navigator.push(context,
          MaterialPageRoute(builder: (context){
            //return const Text('Recipe Detail Page');
            //TODO: change to an actual Recipe detail Page
            return RecipeDetail(recipe: item[index],);
          },
          ),
        );
      },
      child: buildRecipeCard2(item[index]),
    );
  }
  Future<void> getAllRecipes() async{
    var resp = await http.get(Uri.parse('https://amberclass.fimijm.com/api/v1/recipes'));
    //print(resp);
    var respData = json.decode(resp.body);
    (respData['data']['recipes'] as List<Map<String, String>>).forEach(
            (element) {
              Recipe.sampleRecipes2.add(
                Recipe(
                    id:int.parse(element['id']!) ,
                    title: element['title']!,
                    imageUrl: element['image']!,
                    description: element['description']!
                )
              );
          });
  }

  Future<Recipe> getAllRecipes2() async{
    final resp = await http.get(Uri.parse('https://amberclass.fimijm.com/api/v1/recipes'));
    //print(resp.body);
    return Recipe.fromJson(jsonDecode(resp.body));
  }

  List<Recipe> formatRecipe(String responseBody) {
    // final parsed = json.decode(responseBody).cast<String, dynamic>();
    // final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    final parsed = json.decode(responseBody);
    print(parsed['data']['recipes']);
    return parsed['data']['recipes'].map<Recipe>((json) =>Recipe.fromJson(json)).toList();
  }

  Future<List<Recipe>> fetchRecipe() async {
    final response = await http.get(Uri.parse('https://amberclass.fimijm.com/api/v1/recipes'));
    if (response.statusCode == 200) {
      print(response.body);
      return formatRecipe(response.body);
    } else {
      throw Exception('Unable to fetch recipes from the REST API');
    }
  }
}
