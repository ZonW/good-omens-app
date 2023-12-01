import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:good_omens/end-points/api.dart';
import 'package:good_omens/main.dart';
import 'package:good_omens/pages/profile/profile.dart';
import 'package:good_omens/pages/profile/subscription.dart';
import 'package:good_omens/widgets/get_background.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_svg/svg.dart';

class ChatPage extends StatefulWidget {
  final String quote;
  int theme;
  final String input;

  ChatPage({
    super.key,
    required this.quote,
    required this.theme,
    required this.input,
  });
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late IO.Socket socket;
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String inputText = '';
  List<String> _chatHistory = [];
  String _currentResponse = '';
  bool isSubscribed = false;
  String? userId = FirebaseAuth.instance.currentUser?.uid;
  int limit = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _chatHistory.add('You: ${widget.quote}');
      _chatHistory.add('You: ${widget.input}');
      setState(() {
        inputText = widget.input;
        isSubscribed =
            Provider.of<UserSubscription>(context, listen: false).isSubscribed;
      });
      _initializeSocket();
      _sendInput();
    });
  }

  void _initializeSocket() {
    socket = IO.io(
      ApiConstants.baseUrl,
      <String, dynamic>{
        'transports': ['websocket'],
      },
    );

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
            'Good Omens: $_currentResponse',
          ); // Add complete response to history
          _currentResponse = ''; // Clear current response for next one
        }
        scroll();
      });
    });
  }

  void _sendInput() {
    // if user is not subscribed, redirect to subscription page
    if (!isSubscribed && limit >= 1) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                SubscriptionPage(
                  id: userId!,
                ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(-1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeOut;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
            transitionDuration: Duration(milliseconds: 500)),
      );
    }
    // if user input from text box
    limit++;
    if (_inputController.text.isNotEmpty) {
      setState(() {
        inputText = _inputController.text;
        _chatHistory.add('User: $inputText'); // Add user input to chat history
      });
    }
    String chatHistoryPrompt =
        _chatHistory.join('\n') + '\nNew Question: $inputText';

    socket.emit('start_stream', {
      'input': chatHistoryPrompt,
    });
    _inputController.clear(); // Clear the input field
    FocusScope.of(context).unfocus();
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

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(widget.theme);
        return false;
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(62),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Color(0xFFFFFFFF),
                  size: 30,
                ),
                onPressed: () async {
                  int themeOut = await Navigator.of(context).push(
                    PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            ProfileNav(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(-1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.easeOut;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                        transitionDuration: Duration(milliseconds: 500)),
                  );
                  setState(() {
                    widget.theme = themeOut;
                  });
                },
              ),
              title: SvgPicture.asset('assets/img/Good Omens.svg', height: 20),
              centerTitle: true,
              actions: [
                IconButton(
                    icon: const Icon(
                      Icons.share,
                      color: Color(0xFFFFFFFF),
                      size: 30,
                    ),
                    onPressed: () {}),
              ],
            ),
          ),
          body: Stack(children: [
            getBackground(widget.theme),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: _chatHistory.length + 1,
                    itemBuilder: (context, index) {
                      if (index < 2) {
                        return Container(); // This will not display anything for the first two indices
                      }
                      // Display _currentResponse as the last item
                      if (index == _chatHistory.length) {
                        return ListTile(
                          subtitle: Text(_currentResponse),
                          subtitleTextStyle:
                              Theme.of(context).textTheme.displayMedium,
                        );
                      }
                      return ListTile(
                          subtitle: Text(_chatHistory[index]),
                          subtitleTextStyle:
                              Theme.of(context).textTheme.displayMedium);
                    },
                  ),
                ),
                TextField(
                  controller: _inputController,
                  style: Theme.of(context).textTheme.displayMedium,
                  decoration: InputDecoration(
                    labelText: 'Other Questions?',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      color: Colors.white,
                      onPressed: _sendInput,
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
