import 'package:flutter/material.dart';
import 'package:pigeon_lab/pigeons/message_api.g.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
    home: const MyHomePage(),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> implements ReverseMessageApi {
  String _callbackFromNative = '';
  String _messageFromNative = '';
  String _anotherMessage = '';

  @override
  void initState() {
    ReverseMessageApi.setUp(this);

    super.initState();
    getMessageFromFlutter("I am message from Flutter");
  }

  Future<void> _sendMessageToNative() async {
    final String callback = await MessageApi().getMessageFromNative("I am message from Flutter");

    setState(() {
      _callbackFromNative = callback;
    });
  }

  @override
  Future<String> getMessageFromFlutter(String message) async {
    setState(() {
      _messageFromNative = message;
    });
    return "Message from Flutter: $message";
  }

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("_messageFromNative: $_messageFromNative"),
            TextButton(
              onPressed: () async {
                final data = await GreatApi().greet("World");
                setState(() {
                  _anotherMessage = data;
                });
              },
              child: Text("Call GreatApi().greet()"),
            ),
            AndroidView(viewType: ''),
            Text("_anotherMessagge: $_anotherMessage"),
            TextButton(onPressed: _sendMessageToNative, child: Text("Send message to native")),
            Text("_callbackFromNative: $_callbackFromNative"),
          ],
        ),
      ),
    ),
  );
}
