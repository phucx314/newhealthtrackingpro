import 'dart:io';

import 'package:app3/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/plan.dart';
import '../models/recipe.dart';
import '../models/newsRecipe.dart';
import '../styles/box_shadow.dart';
import 'button.dart';
import 'text_field.dart';

class Inputplans extends StatelessWidget {
  Inputplans({super.key, this.createPlan, this.planId});
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController timeFundController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  String? imagePath;
  final String? planId;
  final VoidCallback? createPlan;
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('plans');
  String imageUrl = '';

  Future<void> _pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    print('${file?.path}');

    if (file == null) return;
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    // Step 2: upload to firebase storage
    // install firebase_storage
    // import the library

    // get a reference to storage root
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');

    // create a reference for the image to be stored
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    //handle errors/success
    try {
      //Store the file
      await referenceImageToUpload.putFile(File(file.path));
      //Success: get the download URL
      imageUrl = await referenceImageToUpload.getDownloadURL();
    } catch (error) {
      //some error occurred
    }
  }

  void _deletePlan(BuildContext context, String id) {
    // Đảm bảo rằng recipeId không null trước khi xóa
    if (id.isNotEmpty) {
      // Xác nhận xóa
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Confirm"),
            content: const Text("Are you sure you want to delete this recipe?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Đóng hộp thoại
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  firestoreService.deletePlan(id);
                  Navigator.pop(context); // Đóng hộp thoại
                },
                child: const Text("Delete"),
              ),
            ],
          );
        },
      );
    }
    Navigator.pop(context);
  }

  void _onBackPressed(BuildContext context) {
    Navigator.of(context).pop();
  }

  Future<void> _createRecipe(BuildContext context) async {
    // Get values from controllers and image path
    final String description = descriptionController.text;
    final String timeFund = timeFundController.text;
    final String id = idController.text;

    if (imageUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please upload an image')));
      return;
    }

    await firestoreService.addPlan(
        id, description, imageUrl, timeFund, "status", DateTime.now());

    Navigator.pop(context);
  }

  Future<void> _getRecipeById() async {
    idController.text = planId!;

    Plan plan;
    await firestoreService.getPlan(idController.text).then((value) {
      plan = value;
      descriptionController.text = plan.description;
      timeFundController.text = plan.timeFund;
      imageUrl = plan.imagePath;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    if (planId != null) {
      _getRecipeById();
    }
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
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Create new plan!",
                    style: TextStyle(
                      fontSize: 40,
                      color: Color(0xFF4D8BAA),
                      fontWeight: FontWeight.bold,
                    ),
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
                    controller: timeFundController,
                    maxLines: null,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Time-Fund',
                      hintStyle: TextStyle(color: Colors.black38),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: SizedBox(
                height: 50,
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: screenSize.width * 0.9,
                    height: screenSize.height * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.add_a_photo),
                  ),
                ),
              ),
            ),
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
                      onPressed: () => _deletePlan(context, idController.text),
                      icon: const Icon(
                        Icons.delete,
                        color: Color(0xFF4D8BAA),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        // Xử lý khi nhấn nút sửa
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Color(0xFF4D8BAA),
                      ),
                    ),
                    const SizedBox(width: 25),
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
