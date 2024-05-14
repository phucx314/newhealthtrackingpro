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

String? imagePath;

class Inputplans extends StatelessWidget {
  Inputplans({super.key, this.createPlan, this.planId});
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController timeFundController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final String? planId;
  final VoidCallback? createPlan;
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('plans');
  String imageUrl = '';
  // late Plan plan;
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

  Future<void> updateRecipe(BuildContext context, String id) async {
    if (id.isNotEmpty) {
      // Xác nhận xóa
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Confirm"),
            content: const Text("Are you sure you want to update this plan?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Đóng hộp thoại
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  firestoreService.updatePlan(
                      idController.text,
                      descriptionController.text,
                      imageUrl,
                      timeFundController.text);
                  // Thông báo khi AlertDialog đã đóng và điều hướng trở lại trang PlanPage
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Plan updated'),
                    ),
                  );
                  // Điều hướng trở lại trang PlanPage
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

  Future<DocumentSnapshot<Map<String, dynamic>>?> getPlanById(String id) async {
    try {
      // Thực hiện truy vấn để lấy tài liệu từ Firestore dựa trên trường 'id' và giá trị cụ thể
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('plans')
              .where('id', isEqualTo: id)
              .limit(1) // Giới hạn số lượng tài liệu trả về chỉ cần 1 document
              .get();

      // Nếu có tài liệu phù hợp, trả về document đầu tiên
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first;
      } else {
        // Nếu không có tài liệu phù hợp, trả về null
        return null;
      }
    } catch (e) {
      // Xử lý nếu có lỗi xảy ra trong quá trình truy vấn Firestore
      print('Error getting plan by id: $e');
      return null;
    }
  }

  Future<void> _getPlanById() async {
    idController.text = planId!;
    // Plan plan;
    DocumentSnapshot<Map<String, dynamic>>? planDocument =
        await getPlanById(idController.text);
    if (planDocument != null) {
      // Xử lý khi tìm thấy document
      print('Found plan document');
      descriptionController.text = planDocument['description'];
      timeFundController.text = planDocument['timeFund'];
      imagePath = planDocument['imagePath'];
      // print(imagePath);
    } else {
      // Xử lý khi không tìm thấy document
      print('Plan document with id "001" not found.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    if (planId != null) {
      _getPlanById();
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
                    imagePath ?? 'placeholder_image_path.png',
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
                      onPressed: () => updateRecipe(context, idController.text),
                      icon: const Icon(
                        Icons.edit,
                        color: Color(0xFF4D8BAA),
                      ),
                    ),
                    const SizedBox(width: 25),
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
