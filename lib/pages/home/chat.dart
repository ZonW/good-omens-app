import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late IO.Socket socket;
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<String> _chatHistory = [];
  String _currentResponse = '';

  @override
  void initState() {
    super.initState();
    _initializeSocket();
  }

  void _initializeSocket() {
    socket = IO.io(
        'https://good-omen-service-qkzpk.ondigitalocean.app', <String, dynamic>{
      'transports': ['websocket'],
    });

    socket.onConnect((_) {
      print('Connected to server');
    });

    socket.on('new_message', (data) {
      setState(() {
        _currentResponse += data;
        scroll();
      });
    });

    socket.on('end_of_response', (_) {
      setState(() {
        if (_currentResponse.isNotEmpty) {
          _chatHistory.add(
            'System: $_currentResponse',
          ); // Add complete response to history
          _currentResponse = ''; // Clear current response for next one
        }
        scroll();
      });
    });
  }

  void _sendInput() {
    final inputText = _inputController.text;
    if (inputText.isNotEmpty) {
      setState(() {
        _chatHistory.add('User: $inputText'); // Add user input to chat history
      });
      String chatHistoryPrompt =
          _chatHistory.join('\n') + '\nNew Question: $inputText';

      socket.emit('start_stream', {
        'verse':
            "Genesis 38:12 And in process of time the daughter of Shuah Judah's wife died; and Judah was comforted, and went up unto his sheepshearers to Timnath, he and his friend Hirah the Adullamite.",
        'input': chatHistoryPrompt,
      });
      _inputController.clear(); // Clear the input field
      FocusScope.of(context).unfocus();
    }
  }

  void scroll() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey[500],
        appBar: AppBar(
          title: Text('Chat with AI'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _chatHistory.length + 1,
                itemBuilder: (context, index) {
                  // Display _currentResponse as the last item
                  if (index == _chatHistory.length) {
                    return ListTile(title: Text(_currentResponse));
                  }
                  return ListTile(title: Text(_chatHistory[index]));
                },
              ),
            ),
            TextField(
              controller: _inputController,
              decoration: InputDecoration(
                labelText: 'Enter your input',
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendInput,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
