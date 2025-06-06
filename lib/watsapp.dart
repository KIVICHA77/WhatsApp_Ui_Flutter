import 'package:flutter/material.dart';
import 'package:watsappui/calls.dart';
import 'package:watsappui/chats.dart';
import 'package:watsappui/community.dart';
import 'package:watsappui/updates.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int index=0;
    List< Widget> pages=[
      Chats(),Updates(),Community(),Calls()
    ]
;  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(221, 20, 20, 20),
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text(
          "WhatsApp",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.qr_code_scanner_outlined),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.camera_alt_outlined),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.more_vert_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.chat),
        backgroundColor: Colors.green,
        foregroundColor: Colors.black,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.green,
        currentIndex: index,
        onTap: (tappedindex){
          setState(() {
            index=tappedindex;
          });
        },
        items: [
          BottomNavigationBarItem(backgroundColor: Colors.black,icon: Icon(Icons.chat), label: "chats"),
          BottomNavigationBarItem(
            icon: Icon(Icons.update_rounded),
            label: "updates",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt),
            label: "community",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.call), label: "calls"),
        ],
      ),
      body: pages[index],
    );
  }
}
