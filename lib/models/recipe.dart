class Recipe {
  final String id;
  final String description; //
  final String imagePath; // lib/image/..
  final String detail; //
  final String name; //
  final DateTime dateCreate;
  final bool favorites;
  final String author;
  Recipe({
    required this.id,
    required this.description,
    required this.imagePath,
    required this.detail,
    required this.name,
    required this.dateCreate,
    required this.favorites,
    required this.author,
  });
}
