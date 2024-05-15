import 'package:app3/pages/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Importing your custom components and services.
import '../colors/color_set.dart';
import '../components/appbar.dart';
import '../components/sidebar.dart';
import '../services/auth_service.dart';

class ListChat extends StatefulWidget {
  const ListChat({super.key});

  @override
  State<ListChat> createState() => _ListChatState();
}

class _ListChatState extends State<ListChat> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: htaPrimaryColors.shade100,
      drawer: Sidebar(),
      body: SafeArea(
        child: Column(
          children: [
            // Assuming MyAppBar accepts a username argument.
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 25, 15, 25),
              child: MyAppBar(),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: htaPrimaryColors.shade50,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 25.0, right: 25, top: 10, bottom: 10),
                      child: Text(
                        'Your contacts',
                        style: TextStyle(
                          fontSize: 30,
                          color: htaPrimaryColors.shade500,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Expanded(
              // Use Expanded to allow the ListView to take remaining space.
              child: _buildUserList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView(
          // Use ListTile.divideTiles to add dividers between list items.
          children: ListTile.divideTiles(
            context: context,
            tiles: snapshot.data!.docs
                .map<Widget>((doc) => _buildUserListItem(doc))
                .toList(),
          ).toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    // You can extract data directly from the DocumentSnapshot.
    String email = document['email'];
    String uid = document['uid'];

    // Ensure the current user is not the same as the user being displayed.
    if (_auth.currentUser!.email != email) {
      return Padding(
        padding:
            const EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
        child: Container(
          decoration: BoxDecoration(
            color: htaPrimaryColors.shade50,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            title: Container(
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    color: htaPrimaryColors.shade500,
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Text(
                    document['fullname'],
                    style: TextStyle(
                      fontSize: 15,
                      color: htaPrimaryColors.shade500,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    receiverUserEmail: email,
                    receiverUserId: uid,
                    receiverFullname: document['fullname'],
                  ),
                ),
              );
            },
          ),
        ),
      );
    } else {
      // Return an empty container if the user is the current user.
      return Container();
    }
  }
}
