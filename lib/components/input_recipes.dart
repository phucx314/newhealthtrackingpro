import 'dart:io';

import 'package:app3/pages/recipes.dart';
import 'package:app3/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/recipe.dart';
import '../models/newsRecipe.dart';
import '../styles/box_shadow.dart';
import 'button.dart';
import 'text_field.dart';

class InputRecipes extends StatefulWidget {
  const InputRecipes({super.key, this.createRecipe, this.recipeId});

  final VoidCallback? createRecipe;
  final String? recipeId;

  @override
  _InputRecipesState createState() => _InputRecipesState();
}

class _InputRecipesState extends State<InputRecipes> {
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController detailController = TextEditingController();
  final TextEditingController idController = TextEditingController();

  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('recipes');
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    if (widget.recipeId != null) {
      _getRecipeById();
    }
  }

  Future<void> _pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    print('${file?.path}');

    if (file == null) return;
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    try {
      await referenceImageToUpload.putFile(File(file.path));
      String downloadUrl = await referenceImageToUpload.getDownloadURL();
      setState(() {
        imageUrl = downloadUrl;
      });
    } catch (error) {
      // Handle errors
    }
  }

  void _onBackPressed(BuildContext context) {
    Navigator.of(context).pop();
  }

  Future<void> _createRecipe(BuildContext context) async {
    final String description = descriptionController.text;
    final String detail = detailController.text;
    final String id = idController.text;

    if (imageUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please upload an image')));
      return;
    }

    await firestoreService.addRecipe(id, description, imageUrl, detail, "null",
        DateTime.now(), false, "author");

    Navigator.pop(context);
  }

  void _deleteRecipe(BuildContext context, String id) {
    if (id.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Confirm"),
            content: const Text("Are you sure you want to delete this recipe?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  firestoreService.deleteRecipe(id);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Recipe deleted'),
                    ),
                  );
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RecipePage()));
                },
                child: const Text("Delete"),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> updateRecipe(BuildContext context, String id) async {
    if (id.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Confirm"),
            content: const Text("Are you sure you want to update this recipe?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  firestoreService.updateRecipe(
                      idController.text,
                      descriptionController.text,
                      imageUrl,
                      detailController.text,
                      false,
                      "");
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Recipe updated'),
                    ),
                  );
                  Navigator.pop(context);
                },
                child: const Text("Update"),
              ),
            ],
          );
        },
      );
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> getRecipeById(
      String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('recipes')
              .where('id', isEqualTo: id)
              .limit(1)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first;
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting plan by id: $e');
      return null;
    }
  }

  Future<void> _getRecipeById() async {
    idController.text = widget.recipeId!;
    DocumentSnapshot<Map<String, dynamic>>? recipeDocument =
        await getRecipeById(idController.text);
    if (recipeDocument != null) {
      setState(() {
        descriptionController.text = recipeDocument['description'];
        detailController.text = recipeDocument['detail'];
        imageUrl = recipeDocument['imagePath'];
      });
    } else {
      print('Recipes document with id "001" not found.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFE9F0F5),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    widget.recipeId != null
                        ? "Your Recipes"
                        : "Create new recipe!",
                    style: const TextStyle(
                      fontSize: 40,
                      color: Color(0xFF4D8BAA),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFF4D8BAA),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    imageUrl.isNotEmpty
                        ? imageUrl
                        : 'placeholder_image_path.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: MyTextField(
                controller: idController,
                hintText: 'Id',
                obscureText: false,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: MyTextField(
                controller: descriptionController,
                hintText: 'Description',
                obscureText: false,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [shadow],
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    controller: detailController,
                    maxLines: null,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Detail',
                      hintStyle: TextStyle(color: Colors.black38),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [shadow],
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 25),
                    IconButton(
                      onPressed: () => _onBackPressed(context),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFF4D8BAA),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => _createRecipe(context),
                      icon: const Icon(
                        Icons.add,
                        color: Color(0xFF4D8BAA),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () =>
                          _deleteRecipe(context, idController.text),
                      icon: const Icon(
                        Icons.delete,
                        color: Color(0xFF4D8BAA),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => updateRecipe(context, idController.text),
                      icon: const Icon(
                        Icons.edit,
                        color: Color(0xFF4D8BAA),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: _pickImage,
                      icon: const Icon(Icons.add_a_photo),
                      color: const Color(0xFF4D8BAA),
                    ),
                    const SizedBox(
                      width: 25,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
