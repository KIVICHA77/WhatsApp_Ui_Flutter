import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Bot extends StatefulWidget {
  const Bot({super.key});

  @override
  State<Bot> createState() => _BotState();
}

class _BotState extends State<Bot> {
  TextEditingController msgcontroller = TextEditingController();
  bool isloading = false;
  bool cansent = false;
  List<Map<String, String>> messages = [];

  Future<void> sendMessage(String userMessage) async {
    setState(() {
      messages.add({'role': 'user', 'text': userMessage});
      isloading = true;
      cansent = false;
    });

    final uri = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=AIzaSyDt8SXexxcuTGz2QVg_QpNlbF-fxyoBTRI',
    );

    final headers = {'Content-Type': 'application/json'};

    final body = jsonEncode({
      'contents': [
        {
          'parts': [
            {'text': userMessage},
          ],
        },
      ],
    });

    try {
      final response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final botReply = data['candidates'][0]['content']['parts'][0]['text'];

        setState(() {
          messages.add({'role': 'bot', 'text': botReply});
        });
      } else {
        setState(() {
          messages.add({
            'role': 'bot',
            'text': 'Something went wrong. Please try again later.',
          });
        });
      }
    } catch (e) {
      setState(() {
        messages.add({'role': 'bot', 'text': 'Error: $e'});
      });
    } finally {
      setState(() {
        isloading = false;
        msgcontroller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 248, 245, 245),
        foregroundColor: Colors.black,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Meta Ai"),
            const SizedBox(width: 6),
            Icon(Icons.verified, color: Colors.blue[700], size: 22),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
        ],
        elevation: 1,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                reverse: true,
                itemBuilder: (context, index) =>
                    buildmessage(messages.reversed.toList()[index]),
                itemCount: messages.length,
              ),
            ),
            if (isloading)
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: CircularProgressIndicator(),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: msgcontroller,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        hintText: "Type something...",
                        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.attach_file),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: isloading
                          ? null
                          : () {
                              if (msgcontroller.text.trim().isNotEmpty) {
                                sendMessage(msgcontroller.text.trim());
                              }
                            },
                      icon: const Icon(Icons.send, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildmessage(Map<String, String> Msg) {
    bool user = Msg['role'] == 'user';
    return Align(
      alignment: user ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: user ? Colors.green[300] : Colors.grey[700],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(user ? 20 : 0),
            bottomRight: Radius.circular(user ? 0 : 20),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Text(
          Msg['text'] ?? "",
          style: TextStyle(
            color: user ? Colors.black : Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}