import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import './api_services.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({super.key});
  @override
  State<AddRecipe> createState() {
    return _AddRecipeState();
  }
}

class _AddRecipeState extends State<AddRecipe> {
  final ApiService api = ApiService();
  final _addFormKey = GlobalKey<FormState>();
// int id = 0;
  final _titleController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Add Recipe'),
      // ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            title: const Text('New Recipe'),
            // centerTitle: true,
            // toolbarHeight: 80,
            // pinned: true,
            backgroundColor: const Color.fromARGB(255, 9, 113, 3),
            // actions: [
            //   Padding(
            //     padding: const EdgeInsets.only(right: 8.0),
            //     child: IconButton(
            //         onPressed: () {}, icon: const Icon(Icons.search)),
            //   )
            // ],
            expandedHeight: 200,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              // title: const Text(
              //   'New Recipe',
              //   style: TextStyle(),
              // ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1504674900247-0877df9cc836?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                    fit: BoxFit.cover,
                  ),

                  //IMAGE GRADIENT
                  const Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(103, 0, 0, 0),
                            Color.fromARGB(48, 0, 0, 0),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.1, 0.8],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // centerTitle: true,
            ),
          )
        ],
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Form(
            key: _addFormKey,
            child: ListView(
              children: [
                //PAGE HEADING
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 15.0, bottom: 10.0),
                      child: RichText(
                        text: const TextSpan(children: [
                          TextSpan(
                            text: 'Let\'s Create\n',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25.0,
                                fontWeight: FontWeight.w500),
                          ),
                          TextSpan(
                            text: 'Something ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30.0,
                                fontWeight: FontWeight.w800),
                          ),
                          TextSpan(
                            text: 'New!',
                            style: TextStyle(
                                color: Color.fromARGB(255, 9, 113, 3),
                                fontSize: 30.0,
                                fontWeight: FontWeight.w800),
                          ),
                        ]),
                      ),
                      // child: Text(
                      //   'Lets Create\nSomething New!',
                      //   style: TextStyle(
                      //       fontSize: 30, fontWeight: FontWeight.bold),
                      // ),
                    ),
                  ],
                ),

                //FORM CARD
                Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                          bottomRight: Radius.circular(25),
                          bottomLeft: Radius.circular(25))),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 30),
                    child: Column(
                      children: <Widget>[
                        //RECIPE TITLE FORM FIELD CONTAINER
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.only(bottom: 15.0),
                                child: Text(
                                  'What will we call this dish?',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),

                              //RECIPE TITLE FORM FIELD
                              TextFormField(
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: 'Recipe Title',
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(79, 51, 147, 46),
                                        width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 51, 147, 46),
                                        width: 2.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 255, 2, 2),
                                        width: 2.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 255, 2, 2),
                                        width: 2.0),
                                  ),
                                ),
                                controller: _titleController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a title.';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),

                        //RECIPE IMAGE URL FORM FIELD CONTAINER
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.only(bottom: 15.0),
                                child: Text(
                                  'What does the dish look like?',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),

                              //RECIPE IMAGE URL FORM FIELD
                              TextFormField(
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: 'Image Url',
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(79, 51, 147, 46),
                                        width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 51, 147, 46),
                                        width: 2.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 255, 2, 2),
                                        width: 2.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 255, 2, 2),
                                        width: 2.0),
                                  ),
                                ),
                                controller: _imageUrlController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter the URL for an Image.';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),

                        //RECIPE DESCRIPTION FORM FIELD CONTAINER
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.only(bottom: 15.0),
                                child: Text(
                                  'Now let\'s give it a description.',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),

                              //RECIPE DESCRIPTION FORM FIELD
                              TextFormField(
                                minLines: 3,
                                maxLines: 5,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: 'Recipe Description',
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(79, 51, 147, 46),
                                        width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 51, 147, 46),
                                        width: 2.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 255, 2, 2),
                                        width: 2.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 255, 2, 2),
                                        width: 2.0),
                                  ),
                                ),
                                controller: _descriptionController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a recipe description.';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          // margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: TextButton(
                            onPressed: () {
                              if (_addFormKey.currentState!.validate()) {
                                _addFormKey.currentState!.save();

                                api.createRecipe(Recipe.withoutID(
                                    title: _titleController.text,
                                    imageUrl: _imageUrlController.text,
                                    description: _descriptionController.text));
                                Navigator.of(context).pop(context);
                              }
                            },
                            style: TextButton.styleFrom(
                                elevation: 5,
                                backgroundColor:
                                    const Color.fromARGB(255, 51, 147, 46)),
                            child: const Text('Save',
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _confirmDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Foodie App v1.0 - Warning!'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              const Text('Are you sure want delete this item?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              Navigator.popUntil(
                  context, ModalRoute.withName(Navigator.defaultRouteName));
            },
          ),
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
