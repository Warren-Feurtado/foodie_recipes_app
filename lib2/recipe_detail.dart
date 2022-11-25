import 'package:flutter/material.dart';
import 'recipe.dart';

class RecipeDetail extends StatefulWidget{
  final Recipe recipe;

  const RecipeDetail({super.key, required this.recipe});

  @override
  State<RecipeDetail> createState(){
    return _RecipeDetailState();
  }
}

class _RecipeDetailState extends State<RecipeDetail>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.title),
      ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 250,
                width: double.infinity,
                child:
                Image(
                  image:
                  NetworkImage(widget.recipe.imageUrl),
                ),
              ),
              const SizedBox(height: 4,),
              Text(
                widget.recipe.title,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 6,),
              Text(
                widget.recipe.description,
                style: const TextStyle(fontSize: 24,
                fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
    );
  }
}
