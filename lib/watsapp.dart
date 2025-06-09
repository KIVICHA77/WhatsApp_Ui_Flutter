import 'package:flutter/material.dart';
import 'package:watsappui/calls.dart';
import 'package:watsappui/chatbot.dart';
import 'package:watsappui/chats.dart';
import 'package:watsappui/community.dart';
import 'package:watsappui/updates.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int index = 0;
  final List<Widget> pages = [
    Chats(),
    Updates(),
    Community(),
    Calls(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Row(
          children: [
            const Text(
              "WhatsApp",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.qr_code_scanner_outlined),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.camera_alt_outlined),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.more_vert_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => Bot()),
          );
        },
        child: const Icon(Icons.chat),
        backgroundColor: Colors.green,
        foregroundColor: Colors.black,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.green[200],
        currentIndex: index,
        onTap: (tappedindex) {
          setState(() {
            index = tappedindex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(Icons.chat),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.update_rounded),
            label: "Updates",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt),
            label: "Community",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: "Calls",
          ),
        ],
      ),
      body: pages[index],
    );
  }
}
