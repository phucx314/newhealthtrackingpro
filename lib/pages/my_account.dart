import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../colors/color_set.dart';
import '../components/appbar.dart';
import '../components/height_weight_changer.dart';
import '../components/mybutton.dart';
import '../components/sidebar.dart';
import '../styles/box_shadow.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  late String uid = "";
  late String fullname;
  String? email;
  late String phoneNumber;
  late double height;
  late double age;
  late double weight;
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  Future<void> getUserInfo() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? userCurrent = auth.currentUser;

    if (userCurrent != null) {
      String uid = userCurrent.uid;

      DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userSnapshot.exists) {
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;

        setState(() {
          fullname = userData['fullname'] ?? '';
          email = userData['email'];
          phoneNumber = userData['phoneNumber'] ?? '';
          height = (userData['height'] ?? 0).toDouble();
          age = (userData['age'] ?? 0).toDouble();
          weight = (userData['weight'] ?? 0).toDouble();
          isLoading =
              false; // Ẩn chỉ báo loading sau khi dữ liệu đã được tải xong
        });
      } else {
        print('User data not found for UID: $uid');
        setState(() {
          isLoading =
              false; // Ẩn chỉ báo loading nếu không tìm thấy dữ liệu người dùng
        });
      }
    } else {
      print('No user is currently signed in.');
      setState(() {
        isLoading =
            false; // Ẩn chỉ báo loading nếu không có người dùng nào đang đăng nhập
      });
    }
  }

  Future<void> updateUserInfo(Map<String, dynamic> newData) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? userCurrent = auth.currentUser;

    if (userCurrent != null) {
      String uid = userCurrent.uid;

      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .update(newData);
        print('User information updated successfully.');
      } catch (e) {
        print('Error updating user information: $e');
      }
    } else {
      print('No user is currently signed in.');
    }
  }

  void showUpdateUserInfoDialog(BuildContext context, Map<String, dynamic> userData) {
  TextEditingController fullnameController =
      TextEditingController(text: userData['fullname'] ?? '');
  TextEditingController emailController =
      TextEditingController(text: userData['email'] ?? '');
  TextEditingController phoneNumberController =
      TextEditingController(text: userData['phoneNumber'] ?? '');
  TextEditingController heightController = TextEditingController(
      text: userData['height'] != null ? userData['height'].toString() : '');
  TextEditingController ageController = TextEditingController(
      text: userData['age'] != null ? userData['age'].toString() : '');
  TextEditingController weightController = TextEditingController(
      text: userData['weight'] != null ? userData['weight'].toString() : '');

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: fullnameController,
              onChanged: (value) => userData['fullname'] = value,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: emailController,
              onChanged: (value) => userData['email'] = value,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: phoneNumberController,
              onChanged: (value) => userData['phoneNumber'] = value,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              controller: heightController,
              onChanged: (value) => userData['height'] = double.tryParse(value) ?? 0,
              decoration: const InputDecoration(labelText: 'Height'),
            ),
            TextField(
              controller: weightController,
              onChanged: (value) => userData['weight'] = double.tryParse(value) ?? 0,
              decoration: const InputDecoration(labelText: 'Weight'),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            updateUserInfo(userData);
            getUserInfo();
            Navigator.pop(context); // Close the dialog
          },
          child: const Text('Update'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
      ],
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: Sidebar(),
        backgroundColor: htaPrimaryColors.shade100,
        body: SafeArea(
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          bottom: 25,
                          top: 25,
                          right: 25,
                          left: 25,
                        ),
                        child: MyAppBar(),
                      ),
                      Column(
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 0, top: 0, right: 25, left: 25),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      shadow,
                                    ],
                                  ),
                                  height: 96,
                                  width: MediaQuery.of(context).size.width,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: const Image(
                                      image: AssetImage(
                                        'assets/images/cover_pic1.png',
                                      ),
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    25, 96 + 15, 25, 0),
                                child: Positioned(
                                  top: 96 + 15,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.all(25),
                                    decoration: BoxDecoration(
                                      color: htaPrimaryColors.shade50,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        shadow,
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'General information',
                                                style: TextStyle(
                                                  color:
                                                      htaPrimaryColors.shade500,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Full name',
                                                style: TextStyle(
                                                  color:
                                                      htaPrimaryColors.shade900,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                fullname,
                                                style: TextStyle(
                                                  color:
                                                      htaPrimaryColors.shade900,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Email',
                                                style: TextStyle(
                                                  color:
                                                      htaPrimaryColors.shade900,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                email ?? '',
                                                style: TextStyle(
                                                  color:
                                                      htaPrimaryColors.shade900,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Phone number',
                                                style: TextStyle(
                                                  color:
                                                      htaPrimaryColors.shade900,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                phoneNumber,
                                                style: TextStyle(
                                                  color:
                                                      htaPrimaryColors.shade900,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Your age',
                                                style: TextStyle(
                                                  color:
                                                      htaPrimaryColors.shade900,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                age.toString(),
                                                style: TextStyle(
                                                  color:
                                                      htaPrimaryColors.shade900,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Physical health information',
                                                style: TextStyle(
                                                  color:
                                                      htaPrimaryColors.shade500,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Height',
                                                style: TextStyle(
                                                  color:
                                                      htaPrimaryColors.shade900,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                height.toString(),
                                                style: TextStyle(
                                                  color:
                                                      htaPrimaryColors.shade900,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Weight',
                                                style: TextStyle(
                                                  color:
                                                      htaPrimaryColors.shade900,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                weight.toString(),
                                                style: TextStyle(
                                                  color:
                                                      htaPrimaryColors.shade900,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 30,
                                left:
                                    MediaQuery.of(context).size.width / 2 - 48,
                                child: Container(
                                  height: 96,
                                  width: 96,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(0.5 * 96),
                                    color: htaPrimaryColors.shade50,
                                    boxShadow: [
                                      shadow,
                                    ],
                                    border: Border.all(
                                      width: 5,
                                      color: htaPrimaryColors.shade50,
                                    ),
                                  ),
                                  child: const CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/images/avatar1.png'),
                                    radius: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Button(
                                onTap: () => showUpdateUserInfoDialog(context, {
                                  'fullname': fullname,
                                  'email': email,
                                  'phoneNumber': phoneNumber,
                                  'height': height,
                                  'age': age,
                                  'weight': weight,
                                }),
                                title: 'Edit',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
