import 'package:app3/models/plan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../models/recipe.dart';

class FirestoreService {

  // RECIPES
  final CollectionReference recipes =
      FirebaseFirestore.instance.collection('recipes');

  Future<void> addRecipe(
      String id,
      String description,
      String imagePath,
      String detail,
      String name,
      DateTime dateCreate,
      bool favorites,
      String author) async {
    await recipes.add({
      'id': id,
      'description': description,
      'imagePath': imagePath,
      'detail': detail,
      'name': name,
      'dateCreate': dateCreate,
      'favorites': favorites,
      'author': author,
    });
  }

  Stream<QuerySnapshot> getRecipesStream() {
    final recipesStream =
        recipes.orderBy('dateCreate', descending: true).snapshots();
    return recipesStream;
  }

  Future<Recipe> getRecipe(String id) async {
    try {
      DocumentSnapshot docSnapshot = await recipes.doc(id).get();

      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;

        Recipe recipe = Recipe(
          id: data['id'],
          description: data['description'],
          imagePath: data['imagePath'],
          detail: data['detail'],
          name: data['name'],
          dateCreate: (data['dateCreate'] as Timestamp).toDate(),
          favorites: data['favorites'],
          author: data['author'],
        );

        return recipe;
      } else {
        throw Exception('Recipe with ID $id not found');
      }
    } catch (error) {
      throw Exception('Error fetching recipe with ID $id: $error');
    }
  }

  Future<void> deleteRecipe(String id) async {
    QuerySnapshot querySnapshot =
        await recipes.where('id', isEqualTo: id).get();

    if (querySnapshot.docs.isNotEmpty) {
      querySnapshot.docs.forEach((doc) async {
        await doc.reference.delete();
      });
    } else {
      print('Recipe with ID $id not found');
    }
  }

<<<<<<< HEAD
  Future<void> updateRecipe(
      String id,
      String newDescription,
      String newImagePath,
      String newDetail,
      bool newFavorites,
      String newAuthor) async {
    try {
      QuerySnapshot querySnapshot =
          await recipes.where('id', isEqualTo: id).get();

      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.forEach((doc) async {
          await doc.reference.update({
            'description': newDescription,
            'imagePath': newImagePath,
            'detail': newDetail,
            'favorites': newFavorites,
            'author': newAuthor
          });
        });
        print('Recipe with ID $id updated successfully.');
      } else {
        print('Recipe with ID $id not found');
      }
    } catch (e) {
      // Xử lý nếu có lỗi xảy ra trong quá trình cập nhật Firestore
      print('Error updating recipe: $e');
    }
  }

  ///P L A N
=======
  // PLAN
>>>>>>> c2c06ab960e85d1ca3c87cef719cac692ee7ad25
  final CollectionReference plans =
      FirebaseFirestore.instance.collection('plans');

  Future<void> addPlan(
    String id,
    String description,
    String imagePath,
    String timeFund,
    String status,
    DateTime dateCreate,
  ) async {
    await plans.add({
      'id': id,
      'description': description,
      'imagePath': imagePath,
      'timeFund': timeFund,
      'status': status,
      'dateCreate': dateCreate,
    });
  }

  Stream<QuerySnapshot> getPlansStream() {
    final planStream =
        plans.orderBy('dateCreate', descending: true).snapshots();
    return planStream;
  }

  Future<void> deletePlan(String id) async {
    QuerySnapshot querySnapshot = await plans.where('id', isEqualTo: id).get();

    if (querySnapshot.docs.isNotEmpty) {
      querySnapshot.docs.forEach((doc) async {
        await doc.reference.delete();
      });
    } else {
      print('Plan with ID $id not found');
    }
  }

  Future<Plan> getPlan(String id) async {
    try {
      DocumentSnapshot docSnapshot = await plans.doc(id).get();

      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;

        Plan plan = Plan(
          id: data['id'],
          description: data['description'],
          imagePath: data['imagePath'],
          timeFund: data['timeFund'],
          status: data['status'],
          dateCreate: (data['dateCreate'] as Timestamp).toDate(),
        );

        return plan;
      } else {
        throw Exception('Recipe with ID $id not found');
      }
    } catch (error) {
      throw Exception('Error fetching recipe with ID $id: $error');
    }
  }

<<<<<<< HEAD
  Future<void> updatePlan(
    String id,
    String newDescription,
    String newImagePath,
    String newtimeFund,
  ) async {
    try {
      QuerySnapshot querySnapshot =
          await plans.where('id', isEqualTo: id).get();

      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.forEach((doc) async {
          await doc.reference.update({
            'description': newDescription,
            'imagePath': newImagePath,
            'timeFund': newtimeFund,
          });
        });
        print('Plan with ID $id updated successfully.');
      } else {
        print('Plan with ID $id not found');
      }
    } catch (e) {
      // Xử lý nếu có lỗi xảy ra trong quá trình cập nhật Firestore
      print('Error updating Plan: $e');
=======
  // WATER CUPS
  final CollectionReference waterCups = FirebaseFirestore.instance.collection('water_cups');
  DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc('uid');

  Future<void> addCup(
    String cupID,
    int waterConsumed,
    String dateCreated,
    String uid,
  ) async {
    await waterCups.add({
      'cupID': cupID,
      'waterConsumed': waterConsumed,
      'dateCreated': dateCreated,
      'uid': uid,
    });
  }

  // Hàm để lấy UID của người dùng đã đăng nhập
  Future<String?> getCurrentUserUID() async {
    // Kiểm tra xem người dùng đã đăng nhập chưa
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Nếu người dùng đã đăng nhập, trả về UID của họ
      return user.uid;
    } else {
      // Nếu không có người dùng nào đăng nhập, trả về null
      return null;
    }
  }

  Future<void> deleteCup(String cupID) async {
    QuerySnapshot querySnapshot = await waterCups.where('cupID', isEqualTo: cupID).get();

    if (querySnapshot.docs.isNotEmpty) {
      querySnapshot.docs.forEach((doc) async {
        await doc.reference.delete();
      });
    } else {
      print('Cup with ID $cupID not found');
    }
  }

  Future<bool> hasWaterConsumedData(String uid) async {
    QuerySnapshot snapshot = await waterCups.where('uid', isEqualTo: uid).limit(1).get();
    return snapshot.docs.isNotEmpty;
  }


  Future<List<int>> getWaterConsumedData(String uid) async {
    try {
      QuerySnapshot querySnapshot = await waterCups.where('uid', isEqualTo: uid).get();
      List<int> waterConsumedData = [];
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        waterConsumedData.add(data['waterConsumed']);
      });
      return waterConsumedData;
    } catch (error) {
      throw Exception('Error fetching water consumed data: $error');
>>>>>>> c2c06ab960e85d1ca3c87cef719cac692ee7ad25
    }
  }
}
