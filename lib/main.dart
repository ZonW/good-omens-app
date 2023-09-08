import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VersePage(),
    );
  }
}

class VersePage extends StatefulWidget {
  @override
  _VersePageState createState() => _VersePageState();
}

class _VersePageState extends State<VersePage> {
  String verse = '';
  String input = '';
  String output = '';
  bool isLoading = false;

  TextEditingController inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchVerse();
  }

  Future<void> fetchVerse() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(Uri.parse(
        'https://good-omen-service-qkzpk.ondigitalocean.app/api/getVerse'));

    if (response.statusCode == 200) {
      setState(() {
        verse = jsonDecode(response.body)["Verse"];
        isLoading = false;
      });
    } else {
      // Handle error
      verse = response.body;
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> generateOutput() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.post(
      Uri.parse(
          'https://good-omen-service-qkzpk.ondigitalocean.app/api/explainVerse'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'verse': verse,
        'input': input,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        output = jsonDecode(response.body)["Explain"];
        isLoading = false;
      });
    } else {
      // Handle error
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Good Omens'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (isLoading) Center(child: CircularProgressIndicator()),
              if (!isLoading) ...[
                Text(
                  verse,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: inputController,
                  decoration:
                      InputDecoration(labelText: "What's in your mind?"),
                  onChanged: (val) {
                    input = val;
                  },
                ),
                ElevatedButton(
                  onPressed: generateOutput,
                  child: Text('Explain'),
                ),
                if (output.isNotEmpty) ...[
                  SizedBox(height: 20),
                  Text(
                    output,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}
