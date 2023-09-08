import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:good_omens/widgets/three_body.dart';
import 'dart:convert';
import 'package:good_omens/end-points/api.dart';

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
    final response = await http.get(Uri.parse(ApiConstants.verseEndpoint));

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
        ApiConstants.explainEndpoint,
      ),
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
        title: const Text('Good Omens'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    verse,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: inputController,
                    decoration: const InputDecoration(labelText: 'Input Text'),
                    onChanged: (val) {
                      input = val;
                    },
                  ),
                  ElevatedButton(
                    onPressed: generateOutput,
                    child: const Text('Generate'),
                  ),
                  if (output.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    const Text(
                      'Output:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      output,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (isLoading)
            Center(
              child: ThreeBodySimulation(),
            ),
        ],
      ),
    );
  }
}
