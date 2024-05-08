import 'recipe.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewsRecipe {
  final List<Recipe> _menu = [
    Recipe(
      id: "1",
      description: "Gain weight faster",
      imagePath: "assets/images/test.png",
      detail: "Hearty morning delight with eggs, sausage, cheese, and veggies.",
      name: "Gain weight",
      dateCreate: DateTime.now(),
      favorites: true,
      author: "Dat",
    ),
    Recipe(
      id: "2",
      description: "Gain weight faster",
      imagePath: "assets/images/app_logo_pic.png",
      detail: "Hearty morning delight with eggs, sausage, cheese, and veggies.",
      name: "Gain weight",
      dateCreate: DateTime.now(),
      favorites: true,
      author: "Dat",
    ),
    Recipe(
      id: "3",
      description: "Gain weight faster",
      imagePath: "assets/images/test.png",
      detail: "Hearty morning delight with eggs, sausage, cheese, and veggies.",
      name: "Gain weight",
      dateCreate: DateTime.now(),
      favorites: true,
      author: "Dat",
    ),
  ];

  // GETTER
  List<Recipe> get menu => _menu;

  // Hàm thêm một công thức mới
  void addRecipe(Recipe newRecipe) {
    _menu.add(newRecipe);
  }

  // Hàm xóa một công thức khỏi danh sách dựa trên index
  void deleteRecipe(int index) {
    if (index >= 0 && index < _menu.length) {
      _menu.removeAt(index);
    }
  }
}
