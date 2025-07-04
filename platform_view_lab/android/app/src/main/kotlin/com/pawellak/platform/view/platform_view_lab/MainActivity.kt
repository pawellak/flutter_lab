package com.pawellak.platform.view.platform_view_lab


import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

import android.content.Context
import android.os.Bundle
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)




        flutterEngine.platformViewsController.registry.registerViewFactory(
            "myAndroidUIView", // Make sure this viewType matches in Dart
            WebViewFactory(flutterEngine.dartExecutor.binaryMessenger)
        )
    }


}


class WebViewFactory(private val messenger: BinaryMessenger) :
    PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, id: Int, o: Any?): PlatformView {
        return MyXmlLayoutPlatformView(
            context, messenger, id,
        )
    }
}