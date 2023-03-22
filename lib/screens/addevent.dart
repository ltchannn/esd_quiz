import 'package:esdlife_quiz/screens/list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final user = FirebaseAuth.instance.currentUser;
  bool toggle = true;
  var picker = true;
  var _currentdate = DateTime.now();
  FocusNode searchFocusNode = FocusNode();
  FocusNode textFieldFocusNode = FocusNode();
  final _cnt = SingleValueDropDownController();
  final _descriptionBox = TextEditingController();
  //final todoList = Task.todoList();
  List<String> options = ['Deployment', 'Development', 'Meeting'];
  String? _value;

  addTaskToFirebase() async {
    final User user = FirebaseAuth.instance.currentUser!;
    String uid = user.uid;
    await FirebaseFirestore.instance
        .collection("tasks")
        .doc(user.uid)
        .collection("mytasks")
        .doc(_currentdate.toString())
        .set({
      'time':
          '${DateFormat("y").format(_currentdate)}-${DateFormat("MM").format(_currentdate)}-${DateFormat("dd").format(_currentdate)}',
      "category": _value,
      "description": _descriptionBox.text,
    });
    Fluttertoast.showToast(msg: "Added.");
  }

  void toogleButton() {
    setState(() {
      toggle = !toggle;
    });
  }

  void showPicker() {
    setState(() {
      picker = !picker;
    });
  }

  @override
  void initState() {
    SingleValueDropDownController();
    super.initState();
  }

  @override
  void dispose() {
    _cnt.dispose();
    _descriptionBox.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          titleTextStyle: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text('Add new task'),
          backgroundColor: Colors.white,
        ),
        body: eventBody());
  }

  Widget eventBody() {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //list item
                // for (Task task in todoList)
                //   Padding(
                //       padding: const EdgeInsets.only(top: 16.0),
                //       child: Container(
                //         margin: const EdgeInsets.all(8),
                //         padding: const EdgeInsets.all(16),
                //         decoration: BoxDecoration(
                //           color: const Color.fromARGB(255, 251, 230, 253),
                //           borderRadius: BorderRadius.circular(20),
                //           boxShadow: [
                //             BoxShadow(
                //               color: Colors.grey.withOpacity(0.2),
                //               spreadRadius: 5,
                //               blurRadius: 7,
                //               offset: const Offset(0, 2),
                //             ),
                //           ],
                //         ),
                //         width: double.infinity,
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               task.time!,
                //               style: const TextStyle(
                //                   fontSize: 16, fontWeight: FontWeight.bold),
                //             ),
                //             Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Row(
                //                   children: [
                //                     const Icon(Icons.add),
                //                     Text(
                //                       task.selectedCategory!,
                //                       style: const TextStyle(
                //                           fontSize: 16,
                //                           fontWeight: FontWeight.bold),
                //                     ),
                //                   ],
                //                 ),
                //                 IconButton(
                //                     onPressed: () {},
                //                     icon: const Icon(
                //                       Icons.arrow_forward_ios,
                //                       size: 16,
                //                     )),
                //               ],
                //             ),
                //             Text(task.description!),
                //           ],
                //         ),
                //       )),

                Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  //height: 300,
                  width: double.infinity,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'Date',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 16.0),
                          child: Text(
                            'Filter by date',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color:
                                      const Color.fromARGB(255, 230, 170, 170),
                                ),
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  '${DateFormat("y").format(_currentdate)}-${DateFormat("MM").format(_currentdate)}-${DateFormat("dd").format(_currentdate)}',
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              IconButton(
                                iconSize: 30.0,
                                padding: const EdgeInsets.all(5),
                                icon: Padding(
                                  padding: EdgeInsets.zero,
                                  child: toggle == true
                                      ? const Icon(
                                          Icons.expand_more,
                                        )
                                      : const Icon(
                                          Icons.expand_less,
                                        ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    toogleButton();
                                    showPicker();
                                  });

                                  if (toggle == true) {}
                                },
                              ),
                            ]),
                        Column(children: [
                          Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey, width: 0.5))),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                          ),
                          picker
                              ? Container()
                              : Container(
                                  height: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .height /
                                      3,
                                  child: CupertinoDatePicker(
                                    initialDateTime: _currentdate,
                                    onDateTimeChanged: (DateTime newdate) {
                                      print(newdate);
                                      setState(() {
                                        _currentdate = newdate;
                                      });
                                    },
                                    use24hFormat: true,
                                    maximumDate: DateTime(2050, 12, 30),
                                    minimumYear: 2010,
                                    maximumYear: 2050,
                                    dateOrder: DatePickerDateOrder.ymd,
                                    mode: CupertinoDatePickerMode.date,
                                  ),
                                ),
                        ]),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    //height: 300,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                'Category',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              child: DropdownButton(
                                isExpanded: true,
                                value: _value,
                                items: options
                                    .map((e) => DropdownMenuItem(
                                          child: Text(e.toString()),
                                          value: e.toString(),
                                        ))
                                    .toList(),
                                hint: const Text(
                                  "- Type -",
                                ),
                                onChanged: (newValue) {
                                  setState(() {
                                    _value = newValue.toString();
                                    print(_value);
                                  });
                                },
                              ),
                            )
                          ]),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    height: 500,
                    width: double.infinity,
                    child: TextField(
                      controller: _descriptionBox,
                      keyboardType: TextInputType.multiline,
                      maxLines: 100,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey))),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Container(
                    height: 50,
                    width: 300,
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[900],
                      ),
                      onPressed: () {
                        addTaskToFirebase();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const ListScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Add',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
