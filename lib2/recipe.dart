class Recipe{
  int id;
  String title;
  String imageUrl;
  String description;
  //TODO: Add serving and ingredients
  Recipe({
        required this.id,
        required this.title,
        required this.imageUrl,
        required this.description,
  });

  factory Recipe.fromJson(Map<String, dynamic> json){
    print(json);
    return Recipe(
      id: json['id'],
      title: json['title'],
      imageUrl: json['image'],
      description: json['description'],
    );
  }

  //TODO: Add List<Recipe> here
  static List<Recipe> sampleRecipes = [
    //in Dart List - is like arrays
    Recipe(
         id: 0,
         title: 'Mackerel RunDung',
         imageUrl: 'assets/rundung.jpeg',
         description: '•	2lbs salt mackerel  •	1 Coconut or 1 1/2 Tin Coconut Milk •	1 Large Onion (Sliced) •	2 Cloves of Garlic •	2 Stalks of Escallion'
    ),
    Recipe(
        id: 1,
        title: 'Ackee and Saltfish',
        imageUrl: 'assets/ackeensaltfish.jpeg',
        description: 'Ackee and saltfish'),
    Recipe(
        id: 2,
        title: 'Rice n Peas & Fry Chicken',
        imageUrl: 'assets/ricenpeasnfrychicken.jpeg',
        description: 'Rice n Peas & Fry Chicken'),
  ];
  static List<Recipe> sampleRecipes2 = [];
}

//