import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import './add_recipe.dart';
import './edit_recipe.dart';

class RecipeDetailsPage extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetailsPage({super.key, required this.recipe});

  @override
  State<RecipeDetailsPage> createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(height: 295),
              //IMAGE CONTAINER
              Container(
                height: 250,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.recipe.imageUrl),
                )),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(0, 0, 0, 0),
                        Color.fromARGB(183, 0, 0, 0),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.1, 1],
                    ),
                  ),
                ),
              ),

              Positioned(
                width: MediaQuery.of(context).size.width,
                bottom: 5,
                //TITLE, TIME & DIFFICULTY ROW
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 35.0, left: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.timer,
                                size: 15,
                                // color: Color.fromARGB(255, 215, 22, 19),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '75 minutes',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 30.0),
                          child: Text(
                            'Easy',
                            style: TextStyle(
                                color: Color.fromARGB(255, 33, 147, 29),
                                fontWeight: FontWeight.w800),
                          ),
                        )
                      ],
                    ),

                    //DISH TITLE CONTAINER
                    Card(
                      margin: const EdgeInsets.all(0),
                      clipBehavior: Clip.antiAlias,
                      elevation: 5,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25))),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: 190,
                        height: 70,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 33, 147, 29),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20))),
                        child: Center(
                            child: Text(
                          widget.recipe.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 235, 255, 0),
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ),

              //BACK BUTTON
              Positioned(
                top: 10,
                left: 10,
                child: FloatingActionButton(
                  mini: true,
                  backgroundColor: const Color.fromARGB(118, 255, 255, 255),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  tooltip: 'Go back',
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),

              //EDIT BUTTON
              Positioned(
                top: 10,
                right: 10,
                child: FloatingActionButton(
                  mini: true,
                  backgroundColor: const Color.fromARGB(173, 255, 255, 255),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return EditRecipe(recipe: widget.recipe);
                    }));
                  },
                  tooltip: 'Edit this recipe',
                  child: const Icon(
                    Icons.edit_note,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
              //DELETE BUTTON
              Positioned(
                top: 60,
                right: 10,
                child: FloatingActionButton(
                  mini: true,
                  backgroundColor: const Color.fromARGB(173, 255, 255, 255),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  tooltip: 'Delet this recipe',
                  child: const Icon(
                    Icons.delete_forever_rounded,
                    color: Color.fromARGB(255, 203, 6, 6),
                  ),
                ),
              ),
            ],
          ),

          //DISH DESCRIPTION
          Expanded(
            child: ListView(children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 10.0, bottom: 20.0),
                child: Card(
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      widget.recipe.description,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),

              //INGREDIENTS HEADING
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Icon(Icons.soup_kitchen_sharp),
                    Text(
                      'Ingredients:',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),

          //ADD RECIPE FloatingActionButton.
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 33, 147, 29),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AddRecipe();
                }));
              },
              child: const Icon(Icons.add),
              tooltip: 'Add a new Recipe',
            ),
          ),
        ],
      ),
    );
  }
}
