import 'dart:io';

import 'package:app3/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../pages/planpage.dart';
import '../styles/box_shadow.dart';
import 'button.dart';
import 'text_field.dart';

class Inputplans extends StatefulWidget {
  final String? planId;
  final VoidCallback? createPlan;

  const Inputplans({super.key, this.planId, this.createPlan});

  @override
  _InputplansState createState() => _InputplansState();
}

class _InputplansState extends State<Inputplans> {
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController timeFundController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    if (widget.planId != null) {
      _getPlanById();
    }
  }

  Future<void> _pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
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

  void _deletePlan(BuildContext context, String id) {
    if (id.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Confirm"),
            content: const Text("Are you sure you want to delete this plan?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  firestoreService.deletePlan(id);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PlanPage()));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Plan deleted'),
                    ),
                  );
                },
                child: const Text("Delete"),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> updatePlan(BuildContext context, String id) async {
    if (id.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Confirm"),
            content: const Text("Are you sure you want to update this plan?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Plan updated'),
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

  void _onBackPressed(BuildContext context) {
    Navigator.of(context).pop();
  }

  Future<void> _createPlan(BuildContext context) async {
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
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('plans')
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

  Future<void> _getPlanById() async {
    idController.text = widget.planId!;
    DocumentSnapshot<Map<String, dynamic>>? planDocument =
        await getPlanById(idController.text);
    if (planDocument != null) {
      setState(() {
        descriptionController.text = planDocument['description'];
        timeFundController.text = planDocument['timeFund'];
        imageUrl = planDocument['imagePath'];
      });
    } else {
      print('Plan document with id "001" not found.');
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
                      onPressed: () => _createPlan(context),
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
                      onPressed: () => updatePlan(context, idController.text),
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
