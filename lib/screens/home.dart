import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  void initState() {
    _showDialog(context);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog<String>(
        context: context,
        builder: (BuildContext context) => _showDialog(context)
      );
    });
    super.initState();
  } 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        titleSpacing: 20,
        title: const Text(
          'Hi, welcome',
          style: TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
          child: Column(
            children: [
              Center(child: Image.asset("assets/Man_with_Mac@2x.png")),
              Container(
                height: 50,
                width: 300,
                padding: const EdgeInsets.only(top:8.0),
                child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[900],
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                          }, child: const Text('Login', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),),),
              )
            ])),
    );
  }

  Widget _showDialog(BuildContext context){
    return CupertinoAlertDialog(
          title: Text('Reminder'),
          content: new Text( "Please update to the latest version"),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text("Update"),
              onPressed: () {
                Navigator.pop(context);
              },),
          ],
        );
  }
}
