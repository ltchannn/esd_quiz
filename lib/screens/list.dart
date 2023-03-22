import 'package:esdlife_quiz/screens/addevent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({
    super.key,
  });

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  //final todoList = Task.todoList();
  String? selectedValue;
  String uuuid = "YPIpzkv44KddZ4FlGOzuGfKq0iE3";
  String uid = FirebaseAuth.instance.currentUser!.uid;
  final List<String> items = [
    'Deployment',
    'Development',
    'Meeting',
  ];
  List<dynamic> filterResult = [];
  Stream? stream;

  void searchFromFirebase() async {
    final result = await FirebaseFirestore.instance
        .collection('tasks')
        .doc(uid)
        .collection('mytasks')
        .where('category', isEqualTo: selectedValue)
        .get();

    filterResult = result.docs.map((e) => e.data()).toList();
  }

  String getUID() {
    final User user = FirebaseAuth.instance.currentUser!;

    String uid = "YPIpzkv44KddZ4FlGOzuGfKq0iE3";
    uid = user.uid;
    return uid;
  }

  @override
  void initState() {
    getUID();
    stream = FirebaseFirestore.instance
        .collection('tasks')
        .doc(uuuid)
        .collection('mytasks')
        .where('category', isEqualTo: selectedValue)
        .snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('tasks')
            .doc(uuuid)
            .collection('mytasks')
            .where('category', isEqualTo: selectedValue)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.length > 0) {
              final docs = snapshot.data?.docs;

              return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => AddEventScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Add',
                            style: TextStyle(color: Colors.black),
                          )),
                    ],
                    elevation: 0,
                    backgroundColor: Colors.white,
                    centerTitle: false,
                    titleSpacing: 20,
                    title: const Text(
                      'To Do',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          children: [
                            //dropdown form field
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    hint: const Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Categories',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    items: items
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ))
                                        .toList(),
                                    value: selectedValue,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedValue = value as String;
                                        searchFromFirebase();
                                      });
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: 40,
                                      width: 160,
                                      padding: const EdgeInsets.only(
                                          left: 14, right: 14),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color: Colors.black26,
                                        ),
                                        color: Colors.white,
                                      ),
                                      elevation: 2,
                                    ),
                                    iconStyleData: const IconStyleData(
                                      icon: Icon(
                                        Icons.expand_more,
                                      ),
                                      iconSize: 14,
                                      //iconEnabledColor: Colors.yellow,
                                      //iconDisabledColor: Colors.grey,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 200,
                                      width: 200,
                                      padding: null,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        //color: Colors.redAccent,
                                      ),
                                      elevation: 8,
                                      offset: const Offset(-20, 0),
                                      scrollbarTheme: ScrollbarThemeData(
                                        radius: const Radius.circular(40),
                                        thickness:
                                            MaterialStateProperty.all<double>(
                                                6),
                                        thumbVisibility:
                                            MaterialStateProperty.all<bool>(
                                                true),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding:
                                          EdgeInsets.only(left: 14, right: 14),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            for (int i = 0; i < docs!.length; i++)
                              Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: Container(
                                    margin: const EdgeInsets.all(8),
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 251, 230, 253),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          docs[i]['time'],
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                if (docs[i]['category'] ==
                                                    items[0])
                                                  Image.asset(
                                                      'assets/Deployment_icon.png'),
                                                if (docs[i]['category'] ==
                                                    items[1])
                                                  Image.asset(
                                                      'assets/Development_icon.png'),
                                                if (docs[i]['category'] ==
                                                    items[2])
                                                  Image.asset(
                                                      'assets/Meeting_icon.png'),
                                                Text(
                                                  docs[i]['category'].toString(),
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 16,
                                                )),
                                          ],
                                        ),
                                        Text(docs[i]['description']),
                                      ],
                                    ),
                                  )),
                          ],
                        ),
                      ),
                    ),
                  ));
            } else {
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  centerTitle: false,
                  titleSpacing: 20,
                  title: const Text(
                    'To Do',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                body: Center(
          child: Column(
            children: [
              Center(child: Image.asset("assets/Man_with_Mac@2x.png")),
              const Text(''' 
                   To create a new task,
              simply click the 'Add' to proceed             
              ''',
              //textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),),
              Container(
                height: 50,
                width: 300,
                padding: const EdgeInsets.only(top:8.0),
                child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(55, 230, 170, 170),
                            
                          ),
                          onPressed: () {
                           Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const AddEventScreen(),
                              ),
                            );
                          }, child: const Text('Add new', style: TextStyle(color: Colors.red, fontSize: 22, fontWeight: FontWeight.w600),),),
              ),
              

            ])),
              );
            }
          } else {
            return Container(
              width: double.infinity,
              height: 500,
              color: Colors.black,
            );
          }
        });
  }
}
