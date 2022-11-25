import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../models/recipe_model.dart';
import './recipe_detail.dart';
import './add_recipe.dart';

class MyRecipes extends StatefulWidget {
  const MyRecipes({Key? key}) : super(key: key);

  @override
  State<MyRecipes> createState() => _MyRecipesState();
}

class _MyRecipesState extends State<MyRecipes> {
  late Future<List<Recipe>> recipeList;
  @override
  void initState() {
    super.initState();
    // recipeList = getAllRecipes2();
    recipeList = fetchRecipe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            pinned: true,
            backgroundColor: const Color.fromARGB(255, 33, 147, 29),
            // leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
            // title: Text('My Recipes'),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.search)),
              )
            ],
            expandedHeight: 100,
            floating: true,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('My Recipes'),
              centerTitle: true,
            ),
          )
        ],
        body: Stack(
          children: [
            //APP BAR BACKGROUND CURVE
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 12,
              // color: Color.fromARGB(255, 33, 147, 29),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60)),
                  color: Color.fromARGB(255, 33, 147, 29)),
            ),

            //DISHES LIST
            Center(
              child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: FutureBuilder<List<Recipe>>(
                    future: recipeList,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      return snapshot.hasData
                          ? RecipesList(items: snapshot.data!)
                          : const Center(
                              child: CircularProgressIndicator(),
                            );
                    },
                  )),
            ),

            Positioned(
              width: MediaQuery.of(context).size.width,
              bottom: 10,
              // right: 10,
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      elevation: 10,
                      backgroundColor: Color.fromARGB(255, 33, 147, 29),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const AddRecipe();
                        }));
                      },
                      child: Icon(Icons.add),
                      tooltip: 'Add a new Recipe',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      //APP DRAWER
      drawer: Drawer(
        width: 250,
        child: Column(
          children: [
            Container(
              height: 120,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 33, 147, 29),
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(60))),
            ),
          ],
        ),
      ),
    );
  }

  Widget RecipesList({required List<Recipe> items}) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return dishCardContainer(context, index, items);
      },
    );
  }

  //DISH CARD CONTAINER
  Widget dishCardContainer(
      BuildContext context, int index, List<Recipe> items) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return RecipeDetailsPage(recipe: items[index]);
        }));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: dishCard(items[index]),
      ),
    );
  }

  //DISH CARD
  Widget dishCard(Recipe recipe, {bool isAsset = false}) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 10,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Container(
        // width: double.infinity,
        height: 260,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            image: DecorationImage(
              image: NetworkImage(recipe.imageUrl),
              fit: BoxFit.cover,
            )),
        child: Stack(
          children: [
            //IMAGE GRADIENT
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(0, 0, 0, 0),
                      Color.fromARGB(62, 0, 0, 0),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.1, 0.8],
                  ),
                ),
              ),
            ),

            //DISH TITLE CONTAINER
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      width: 200,
                      height: 70,
                      decoration: const BoxDecoration(
                          // backgroundBlendMode: BlendMode.hardLight,
                          color: Color.fromARGB(239, 9, 114, 0),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30))),
                      child: Center(
                        child: Text(
                          recipe.title,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 235, 255, 0),
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
    // return Card(
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    //   child: Stack(
    //     children: [
    //       Container(
    //         width: MediaQuery.of(context).size.width,
    //         height: 250,
    //         decoration: BoxDecoration(
    //             borderRadius: const BorderRadius.all(Radius.circular(30)),
    //             image: DecorationImage(
    //               image: NetworkImage(recipe.imageUrl),
    //               fit: BoxFit.cover,
    //             )),
    //       ),

    //       //IMAGE GRADIENT
    //       Positioned(
    //         child: DecoratedBox(
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.all(Radius.circular(30)),
    //             gradient: LinearGradient(
    //               colors: [
    //                 Color.fromARGB(54, 0, 0, 0),
    //                 Color.fromARGB(90, 0, 0, 0),
    //               ],
    //               begin: Alignment.topCenter,
    //               end: Alignment.bottomCenter,
    //               stops: [0.3, 0.9],
    //             ),
    //           ),
    //           child: Positioned(
    //               bottom: 0,
    //               child: Container(
    //                 width: double.infinity,
    //                 height: 110,
    //                 color: Colors.black,
    //                 child: Text(
    //                   'hello world',
    //                   style: TextStyle(color: Colors.white),
    //                 ),
    //               )),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  //
  List<Recipe> formatRecipe(String responseBody) {
    final parsed = json.decode(responseBody);
    print(parsed['data']['recipes']);
    return parsed['data']['recipes']
        .map<Recipe>((json) => Recipe.fromJson(json))
        .toList();
  }

  //GET ALL RECIPES FROM API
  Future<List<Recipe>> fetchRecipe() async {
    final response = await http
        .get(Uri.parse('https://amberclass.fimijm.com/api/v1/recipes'));
    if (response.statusCode == 200) {
      print(response.body);
      return formatRecipe(response.body);
    } else {
      throw Exception('Unable to fetch recipes from the REST API');
    }
  }
}
