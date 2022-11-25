class Recipe {
  int id = 0;
  String title;
  String imageUrl;
  String description;

  //CONSTRUCTOR
  Recipe({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
  });
  Recipe.withoutID({
    required this.title,
    required this.imageUrl,
    required this.description,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    print(json);
    return Recipe(
      id: json['id'],
      title: json['title'],
      imageUrl: json['image'],
      description: json['description'],
    );
  }
}
