import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const mySwiftUIView = 'mySwiftUIView';
const myAndroidUIView = 'myAndroidUIView';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Builder(
                builder: (context) => LayoutBuilder(
                  builder: (context, box) =>
                      SizedBox.fromSize(size: Size(box.biggest.width, 400), child: _getNativeView()),
                ),
              ),
              ElevatedButton(onPressed: () {}, child: Text("Flutter Button")),
            ],
          ),
        ),
      ),
    );
  }

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
