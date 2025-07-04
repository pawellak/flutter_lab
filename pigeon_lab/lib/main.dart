import 'package:flutter/material.dart';
import 'package:pigeon_lab/pigeons/message_api.g.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> implements ReverseMessageApi {
  String _callbackFromNative = '';
  String _messageFromNative = '';
  String _anotherMessagge = '';

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
                  _anotherMessagge = data;
                });
              },
              child: Text("Call GreatApi().greet()"),
            ),
            AndroidView(viewType: ''),
            Text("_anotherMessagge: $_anotherMessagge"),
            TextButton(onPressed: _sendMessageToNative, child: Text("Send message to native")),
            Text("_callbackFromNative: $_callbackFromNative"),
          ],
        ),
      ),
    ),
  );
}
