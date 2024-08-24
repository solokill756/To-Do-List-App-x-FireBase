import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todolist/managers/card_manager.dart';
import 'package:todolist/managers/user_manager.dart';
import 'package:todolist/modules/home/widget/CardBody.dart';
import 'package:todolist/modules/home/widget/card_add_weiget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CardManager _cardManager = CardManager();
  final UserManager userManager = UserManager();
  // ignore: unused_element
  void _addItem(String content) {
    setState(() {
      _cardManager.addItem(content);
      print(1);
    });
  }

  // ignore: unused_element
  void _deleteItem(String id) {
    setState(() {
      _cardManager.deleteCard(id);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    userManager.getUserData(FirebaseAuth.instance.currentUser!.uid.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          'ToDoList',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
            },
            child: Icon(
              Icons.logout,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: _cardManager.items.map(
            (item) {
              return CardBody(deleteCard: _deleteItem, item: item);
            },
          ).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Colors.grey[300],
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            ),
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return CardAddWeiget(addCard: _addItem);
            },
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
