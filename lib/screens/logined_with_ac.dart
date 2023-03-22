import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        titleSpacing: 20,
        title: Row(
          children: [
            //const Icon(Icons.arrow_back_ios, color: Colors.black,),
            const Text(
              'Hi, Peter',
              style: TextStyle(
                  color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
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
                            backgroundColor: Colors.black,
                        
                          ),
                          onPressed: () => FirebaseAuth.instance.signOut(),
                           child: const Text('Logout', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),),),
              )
            ])),
    );
  }
}