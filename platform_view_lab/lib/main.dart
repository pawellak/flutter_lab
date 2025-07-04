import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:platform_view_lab/pigeons/message_api.g.dart';

const mySwiftUIView = 'mySwiftUIView';
const myAndroidUIView = 'myAndroidUIView';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> implements ReverseMessageApi {
  String _cityFromAndroid = '';
  String _roundedAge = '';

  @override
  void initState() {
    ReverseMessageApi.setUp(this);
    super.initState();
  }

  @override
  Future<int> getTemperatureInCityFromFlutter(String city) async {
    setState(() {
      _cityFromAndroid = city;
    });
    if (city == "Warsaw") {
      return 10;
    } else if (city == "London") {
      return 15;
    } else if (city == "New York") {
      return 20;
    } else {
      return 0;
    }
  }

  Future<void> _getRoundedNumberFrom(double? value) async {
    if (value != null) {
      final String callback = await MessageApi().getRoundedNumberFromNative(value);
      setState(() {
        _roundedAge = callback;
      });
    } else {
      setState(() {
        _roundedAge = "error";
      });
    }
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
    home: Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(child: _getNativeView()),
            Text("City from Android: $_cityFromAndroid"),
            Text("Ronded Age: $_roundedAge"),
            TextField(
              onChanged: (value) {
                _getRoundedNumberFrom(double.tryParse(value));
              },
            ),
          ],
        ),
      ),
    ),
  );

  Widget _getNativeView() {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return AndroidView(
          viewType: myAndroidUIView,
          creationParamsCodec: StandardMessageCodec(),
          onPlatformViewCreated: (id) {},
          creationParams: {},
        );
      case TargetPlatform.iOS:
        return UiKitView(viewType: mySwiftUIView, creationParamsCodec: StandardMessageCodec(), creationParams: {});
      default:
        return Text("");
    }
  }
}
