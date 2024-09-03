import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist/managers/card_manager.dart';
import 'package:todolist/managers/user_manager.dart';
import 'package:todolist/models/item.dart';
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
  void _addItem(String content, String dateBegin, String dateEnd) {
    setState(() {
      _cardManager.addItem(content, dateBegin, dateEnd);
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
    // userManager.getUserData();
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
            child: const Icon(
              Icons.logout,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _cardManager.getWorksStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Text("Something went wrong: ${snapshot.error}"));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          List<Item> works = [];
          for (var doc in snapshot.data!.docs) {
            Item newItem = Item(
                id: doc.id,
                content: doc["name"].toString(),
                date_begin: doc["date_begin"],
                date_end: doc["date_end"]);
            works.add(newItem);
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: works.map(
                (item) {
                  return CardBody(deleteCard: _deleteItem, item: item);
                },
              ).toList(),
            ),
          );
        },
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
