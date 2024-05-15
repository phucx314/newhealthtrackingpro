import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void addFoodsToFirestore() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? userCurrent = auth.currentUser;

  if (userCurrent != null) {
    String uid = userCurrent.uid;

    // final List<Map<String, dynamic>> foods = [
    //   {'name': 'Apple', 'quantity': 0, 'calories': 95, 'unit': 'piece', 'foodId': 'Apple95', 'uid': null},
    //   {'name': 'Banana', 'quantity': 0, 'calories': 105, 'unit': 'piece', 'foodId': 'Banana105', 'uid': null},
    //   {'name': 'Orange', 'quantity': 0, 'calories': 62, 'unit': 'piece', 'foodId': 'Orange62', 'uid': null},
    //   {'name': 'Grapes', 'quantity': 0, 'calories': 114, 'unit': 'cup', 'foodId': 'Grapes114', 'uid': null},
    //   {'name': 'Strawberries', 'quantity': 0, 'calories': 50, 'unit': 'cup', 'foodId': 'Strawberries50', 'uid': null},
    //   {'name': 'Blueberries', 'quantity': 0, 'calories': 84, 'unit': 'cup', 'foodId': 'Blueberries84', 'uid': null},
    //   {'name': 'Pineapple', 'quantity': 0, 'calories': 82, 'unit': 'cup', 'foodId': 'Pineapple82', 'uid': null},
    //   {'name': 'Watermelon', 'quantity': 0, 'calories': 46, 'unit': 'cup', 'foodId': 'Watermelon46', 'uid': null},
    //   {'name': 'Spinach', 'quantity': 0, 'calories': 7, 'unit': 'cup', 'foodId': 'Spinach7', 'uid': null},
    //   {'name': 'Kale', 'quantity': 0, 'calories': 33, 'unit': 'cup', 'foodId': 'Kale33', 'uid': null},
    //   {'name': 'Lettuce', 'quantity': 0, 'calories': 5, 'unit': 'cup', 'foodId': 'Lettuce5', 'uid': null},
    //   {'name': 'Carrots', 'quantity': 0, 'calories': 52, 'unit': 'cup', 'foodId': 'Carrots52', 'uid': null},
    //   {'name': 'Broccoli', 'quantity': 0, 'calories': 31, 'unit': 'cup', 'foodId': 'Broccoli31', 'uid': null},
    //   {'name': 'Cucumber', 'quantity': 0, 'calories': 8, 'unit': 'cup', 'foodId': 'Cucumber8', 'uid': null},
    //   {'name': 'Tomatoes', 'quantity': 0, 'calories': 22, 'unit': 'cup', 'foodId': 'Tomatoes22', 'uid': null},
    //   {'name': 'Onions', 'quantity': 0, 'calories': 46, 'unit': 'cup', 'foodId': 'Onions46', 'uid': null},
    //   {'name': 'Bell Peppers', 'quantity': 0, 'calories': 24, 'unit': 'cup', 'foodId': 'BellPeppers24', 'uid': null},
    //   {'name': 'Eggs', 'quantity': 0, 'calories': 70, 'unit': 'piece', 'foodId': 'Eggs70', 'uid': null},
    //   {'name': 'Chicken Breast', 'quantity': 0, 'calories': 165, 'unit': 'piece', 'foodId': 'ChickenBreast165', 'uid': null},
    //   {'name': 'Salmon', 'quantity': 0, 'calories': 206, 'unit': 'ounce', 'foodId': 'Salmon206', 'uid': null},
    //   {'name': 'Tuna', 'quantity': 0, 'calories': 159, 'unit': 'ounce', 'foodId': 'Tuna159', 'uid': null},
    //   {'name': 'Shrimp', 'quantity': 0, 'calories': 85, 'unit': 'ounce', 'foodId': 'Shrimp85', 'uid': null},
    //   {'name': 'Bacon', 'quantity': 0, 'calories': 43, 'unit': 'slice', 'foodId': 'Bacon43', 'uid': null},
    //   {'name': 'Ham', 'quantity': 0, 'calories': 145, 'unit': 'ounce', 'foodId': 'Ham145', 'uid': null},
    //   {'name': 'Turkey Breast', 'quantity': 0, 'calories': 125, 'unit': 'ounce', 'foodId': 'TurkeyBreast125', 'uid': null},
    //   {'name': 'Tofu', 'quantity': 0, 'calories': 94, 'unit': 'cup', 'foodId': 'Tofu94', 'uid': null},
    //   {'name': 'Cottage Cheese', 'quantity': 0, 'calories': 120, 'unit': 'cup', 'foodId': 'CottageCheese120', 'uid': null},
    //   {'name': 'Greek Yogurt', 'quantity': 0, 'calories': 59, 'unit': 'cup', 'foodId': 'GreekYogurt59', 'uid': null},
    //   {'name': 'Milk', 'quantity': 0, 'calories': 103, 'unit': 'cup', 'foodId': 'Milk103', 'uid': null},
    //   {'name': 'Almond Milk', 'quantity': 0, 'calories': 39, 'unit': 'cup', 'foodId': 'AlmondMilk39', 'uid': null},
    //   {'name': 'Oat Milk', 'quantity': 0, 'calories': 120, 'unit': 'cup', 'foodId': 'OatMilk120', 'uid': null},
    //   {'name': 'Coconut Milk', 'quantity': 0, 'calories': 552, 'unit': 'cup', 'foodId': 'CoconutMilk552', 'uid': null},
    //   {'name': 'Cheese', 'quantity': 0, 'calories': 110, 'unit': 'ounce', 'foodId': 'Cheese110', 'uid': null},
    //   {'name': 'Butter', 'quantity': 0, 'calories': 102, 'unit': 'tablespoon', 'foodId': 'Butter102', 'uid': null},
    //   {'name': 'Olive Oil', 'quantity': 0, 'calories': 119, 'unit': 'tablespoon', 'foodId': 'OliveOil119', 'uid': null},
    // ];
    // final List<Map<String, dynamic>> drinks = [
    //   {'name': 'Water', 'quantity': 0, 'calories': 0, 'unit': 'cup', 'foodId': 'Water0', 'uid': null},
    //   {'name': 'Green Tea', 'quantity': 0, 'calories': 0, 'unit': 'cup', 'foodId': 'GreenTea0', 'uid': null},
    //   {'name': 'Black Tea', 'quantity': 0, 'calories': 2, 'unit': 'cup', 'foodId': 'BlackTea2', 'uid': null},
    //   {'name': 'Coffee', 'quantity': 0, 'calories': 2, 'unit': 'cup', 'foodId': 'Coffee2', 'uid': null},
    //   {'name': 'Latte', 'quantity': 0, 'calories': 120, 'unit': 'cup', 'foodId': 'Latte120', 'uid': null},
    //   {'name': 'Cappuccino', 'quantity': 0, 'calories': 74, 'unit': 'cup', 'foodId': 'Cappuccino74', 'uid': null},
    //   {'name': 'Espresso', 'quantity': 0, 'calories': 3, 'unit': 'cup', 'foodId': 'Espresso3', 'uid': null},
    //   {'name': 'Hot Chocolate', 'quantity': 0, 'calories': 192, 'unit': 'cup', 'foodId': 'HotChocolate192', 'uid': null},
    //   {'name': 'Orange Juice', 'quantity': 0, 'calories': 112, 'unit': 'cup', 'foodId': 'OrangeJuice112', 'uid': null},
    //   {'name': 'Apple Juice', 'quantity': 0, 'calories': 114, 'unit': 'cup', 'foodId': 'AppleJuice114', 'uid': null},
    //   {'name': 'Grapefruit Juice', 'quantity': 0, 'calories': 96, 'unit': 'cup', 'foodId': 'GrapefruitJuice96', 'uid': null},
    //   {'name': 'Lemonade', 'quantity': 0, 'calories': 99, 'unit': 'cup', 'foodId': 'Lemonade99', 'uid': null},
    //   {'name': 'Cranberry Juice', 'quantity': 0, 'calories': 116, 'unit': 'cup', 'foodId': 'CranberryJuice116', 'uid': null},
    //   {'name': 'Pineapple Juice', 'quantity': 0, 'calories': 133, 'unit': 'cup', 'foodId': 'PineappleJuice133', 'uid': null},
    //   {'name': 'Coconut Water', 'quantity': 0, 'calories': 46, 'unit': 'cup', 'foodId': 'CoconutWater46', 'uid': null},
    //   {'name': 'Almond Milk', 'quantity': 0, 'calories': 39, 'unit': 'cup', 'foodId': 'AlmondMilk39', 'uid': null},
    //   {'name': 'Soy Milk', 'quantity': 0, 'calories': 80, 'unit': 'cup', 'foodId': 'SoyMilk80', 'uid': null},
    //   {'name': 'Rice Milk', 'quantity': 0, 'calories': 120, 'unit': 'cup', 'foodId': 'RiceMilk120', 'uid': null},
    //   {'name': 'Beer', 'quantity': 0, 'calories': 153, 'unit': 'can', 'foodId': 'Beer153', 'uid': null},
    //   {'name': 'Wine', 'quantity': 0, 'calories': 125, 'unit': 'glass', 'foodId': 'Wine125', 'uid': null},
    // ];
    List<Map<String, dynamic>> activities = [
  {
    'activityID': 'Running',
    'activityName': 'Running',
    'kcalPerMinute': 10, // Số calo đốt cháy trong 1 phút
    'duration': 0, // Thời gian thực hiện
    'uid': null, // UID của người dùng
  },
  {
    'activityID': 'Cycling',
    'activityName': 'Cycling',
    'kcalPerMinute': 8,
    'duration': 0,
    'uid': null,
  },
  {
    'activityID': 'Swimming',
    'activityName': 'Swimming',
    'kcalPerMinute': 12,
    'duration': 0,
    'uid': null,
  },
  {
    'activityID': 'JumpingRope',
    'activityName': 'Jumping Rope',
    'kcalPerMinute': 15,
    'duration': 0,
    'uid': null,
  },
  {
    'activityID': 'Hiking',
    'activityName': 'Hiking',
    'kcalPerMinute': 7,
    'duration': 0,
    'uid': null,
  },
  {
    'activityID': 'Yoga',
    'activityName': 'Yoga',
    'kcalPerMinute': 5,
    'duration': 0,
    'uid': null,
  },
  {
    'activityID': 'Dancing',
    'activityName': 'Dancing',
    'kcalPerMinute': 9,
    'duration': 0,
    'uid': null,
  },
  {
    'activityID': 'JumpingJacks',
    'activityName': 'Jumping Jacks',
    'kcalPerMinute': 11,
    'duration': 0,
    'uid': null,
  },
  {
    'activityID': 'PushUps',
    'activityName': 'Push-Ups',
    'kcalPerMinute': 6,
    'duration': 0,
    'uid': null,
  },
  {
    'activityID': 'SitUps',
    'activityName': 'Sit-Ups',
    'kcalPerMinute': 7,
    'duration': 0,
    'uid': null,
  },
  {
    'activityID': 'Squats',
    'activityName': 'Squats',
    'kcalPerMinute': 8,
    'duration': 0,
    'uid': null,
  },
  {
    'activityID': 'JumpSquats',
    'activityName': 'Jump Squats',
    'kcalPerMinute': 13,
    'duration': 0,
    'uid': null,
  },
  {
    'activityID': 'Plank',
    'activityName': 'Plank',
    'kcalPerMinute': 4,
    'duration': 0,
    'uid': null,
  },
  {
    'activityID': 'Burpees',
    'activityName': 'Burpees',
    'kcalPerMinute': 14,
    'duration': 0,
    'uid': null,
  },
  {
    'activityID': 'MountainClimbers',
    'activityName': 'Mountain Climbers',
    'kcalPerMinute': 12,
    'duration': 0,
    'uid': null,
  },
  {
    'activityID': 'Lunges',
    'activityName': 'Lunges',
    'kcalPerMinute': 8,
    'duration': 0,
    'uid': null,
  },
  {
    'activityID': 'HighKnees',
    'activityName': 'High Knees',
    'kcalPerMinute': 13,
    'duration': 0,
    'uid': null,
  },
  {
    'activityID': 'Bicycling',
    'activityName': 'Bicycling',
    'kcalPerMinute': 10,
    'duration': 0,
    'uid': null,
  },
  {
    'activityID': 'Rowing',
    'activityName': 'Rowing',
    'kcalPerMinute': 9,
    'duration': 0,
    'uid': null,
  },
  {
    'activityID': 'Boxing',
    'activityName': 'Boxing',
    'kcalPerMinute': 12,
    'duration': 0,
    'uid': null,
  },
];





    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference foodCollection = firestore.collection('activities');

    for (int i = 0; i < activities.length; i++) {
      try {
        await foodCollection.add(activities[i]);
        print('Food added to Firestore: ${activities[i]['name']}');
      } catch (e) {
        print('Error adding food to Firestore: $e');
      }
    }
  } else {
    print('No user is currently signed in.');
  }
}