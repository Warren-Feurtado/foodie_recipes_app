import 'package:flutter/material.dart';
import './my_recipes_screen.dart';
import '../models/recipe_model.dart';
import './api_services.dart';

class EditRecipe extends StatefulWidget {
  final Recipe recipe;
  EditRecipe({super.key, required this.recipe});

  @override
  State<EditRecipe> createState() {
    return _EditRecipeState();
  }
}

class _EditRecipeState extends State<EditRecipe> {
  final ApiService api = ApiService();
  final _addFormKey = GlobalKey<FormState>();
  // int id = 0;
  String id = '';
  final _titleController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    id = widget.recipe.id.toString();
    print('The ID is: $id');
    _titleController.text = widget.recipe.title;
    _imageUrlController.text = widget.recipe.imageUrl;
    _descriptionController.text = widget.recipe.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editing Recipe'),
      ),
      body: Form(
        key: _addFormKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 440,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Column(
                        children: <Widget>[
                          const Text('Recipe Title'),
                          TextFormField(
                            controller: _titleController,
                            decoration: const InputDecoration(
                              hintText: 'Type Recipe Title',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a title';
                              }
                              return null;
                            },
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Column(
                        children: <Widget>[
                          const Text('Image Url'),
                          TextFormField(
                            controller: _imageUrlController,
                            decoration: const InputDecoration(
                              hintText: 'Recipe Image Url',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the URL for an Image';
                              }
                              return null;
                            },
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Column(
                        children: <Widget>[
                          const Text('Description'),
                          TextFormField(
                            minLines: 1,
                            maxLines: 5,
                            controller: _descriptionController,
                            decoration: const InputDecoration(
                              hintText: 'Recipe Description',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the Description';
                              }
                              return null;
                            },
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Column(
                        children: <Widget>[
                          TextButton(
                            onPressed: () {
                              if (_addFormKey.currentState!.validate()) {
                                _addFormKey.currentState!.save();
                                api.updateRecipe(
                                    id,
                                    Recipe.withoutID(
                                        title: _titleController.text,
                                        imageUrl: _imageUrlController.text,
                                        description:
                                            _descriptionController.text));
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) => MyRecipes()))
                                    .then((value) => setState(() => {}));
                              }
                            },
                            style: TextButton.styleFrom(
                                elevation: 2, backgroundColor: Colors.green),
                            child: const Text('Update Recipe',
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
