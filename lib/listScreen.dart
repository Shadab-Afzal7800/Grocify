import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_list_app/loginScreen.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  TextEditingController textController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;
  //Save item to database
  void grocerySave() {
    String item = textController.text.trim();
    String howMuch = quantityController.text.trim();
    if (item != '' && howMuch != '') {
      Map<String, dynamic> data = {
        'name': textController.text,
        'net': quantityController.text,
      };
      FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser?.uid)
          .collection('groceryList')
          .add(data);
      textController.clear();
      quantityController.clear();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please fill all the fields')));
    }
  }

  //Delete item
  void deleteItem(String id) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser?.uid)
        .collection('groceryList')
        .doc(id)
        .delete();
  }

  //Logout Function
  void logOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (context) => Login()));
  }

  Stream<QuerySnapshot> getUserGroceryListStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser?.uid)
        .collection('groceryList')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          title: Row(
            children: [
              Expanded(
                child: Text(
                  ('Grocify'),
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
              Expanded(
                  child: TextFormField(
                onFieldSubmitted: (value) => grocerySave(),
                controller: textController,
                style: TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    focusedBorder: InputBorder.none,
                    hintText: 'Type here',
                    hintStyle: TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.white)),
              )),
              VerticalDivider(
                color: Colors.transparent,
              ),
              Expanded(
                child: TextFormField(
                  onFieldSubmitted: (value) {
                    grocerySave();
                  },
                  controller: quantityController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      hintText: 'Quantity',
                      hintStyle: TextStyle(
                          fontStyle: FontStyle.italic, color: Colors.white)),
                ),
              ),
              VerticalDivider(
                color: Colors.transparent,
              ),
              Expanded(
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () {
                      grocerySave();
                    },
                    // child: const Text(
                    //   'ADD',
                    //   style: TextStyle(
                    //       color: Color.fromARGB(255, 41, 40, 40),
                    //       fontWeight: FontWeight.bold),
                    // )
                    child: Icon(
                      Icons.add,
                      color: Colors.green,
                    )),
              )
            ],
          ),
          // flexibleSpace: Container(
          // decoration: BoxDecoration(
          // gradient: LinearGradient(
          // begin: Alignment.centerLeft,
          // end: Alignment.centerRight,
          // colors: [Colors.deepPurple, Colors.deepPurple.shade100])),
          // ),
        ),
        body: Container(
          color: Color.fromARGB(255, 53, 52, 52),
          child: StreamBuilder<QuerySnapshot>(
              stream: getUserGroceryListStream(),

              // stream: FirebaseFirestore.instance
              // .collection('groceryList')
              // .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData && snapshot.data != null) {
                    print(snapshot.data?.docs.length);

                    return ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (BuildContext context, index) {
                          var userMap = snapshot.data!.docs;
                          // String itemId = snapshot.data!.id;
                          return Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Opacity(
                              opacity: 0.7,
                              child: Card(
                                color: Colors.white,
                                margin: const EdgeInsets.all(4.0),
                                elevation: 20.0,
                                child: ListTile(
                                    title: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        userMap[index]['name'],
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                            height: 40,
                                            width: 150,
                                            color: Colors.transparent,
                                            child: Center(
                                                child: Text(
                                              userMap[index]['net'],
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ))),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 40),
                                          child: IconButton(
                                              onPressed: () {
                                                deleteItem(userMap[index].id);
                                                // deleteItem(itemId);
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Color.fromARGB(
                                                    255, 197, 90, 90),
                                              )),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          );
                        });
                  } else {
                    return Center(
                      child: Text('Grocery List is Empty'),
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
        bottomNavigationBar: NavigationBar(destinations: [
          TextButton.icon(
            onPressed: null,
            icon: Icon(
              Icons.person,
            ),
            label: Text(
              '${FirebaseAuth.instance.currentUser!.displayName}',
              style: TextStyle(color: Colors.black),
            ),
            style:
                ButtonStyle(iconColor: MaterialStatePropertyAll(Colors.black)),
          ),
          TextButton.icon(
            onPressed: () {
              logOut(context);
            },
            icon: Icon(Icons.logout_outlined),
            label: Text(
              'Logout',
              style: TextStyle(color: Colors.black),
            ),
            style:
                ButtonStyle(iconColor: MaterialStatePropertyAll(Colors.black)),
          )
        ]),
      ),
    );
  }
}
