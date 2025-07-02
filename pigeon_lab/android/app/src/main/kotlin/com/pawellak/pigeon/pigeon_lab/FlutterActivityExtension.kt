package com.pawellak.pigeon.pigeon_lab

import com.pawellak.platform_channel_with_pigeon.pigeons.GreatApi
import com.pawellak.platform_channel_with_pigeon.pigeons.MessageApi
import com.pawellak.platform_channel_with_pigeon.pigeons.ReverseMessageApi
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

open class FlutterActivityExtension : FlutterActivity(), GreatApi, MessageApi {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GreatApi.setUp(flutterEngine.dartExecutor.binaryMessenger, this)
        MessageApi.setUp(flutterEngine.dartExecutor.binaryMessenger, this)
        ReverseMessageApi(flutterEngine.dartExecutor.binaryMessenger).getMessageFromFlutter(
            "I am message from native",
            callback = { result -> println(result) })
    }

    override fun greet(message: String): String {
        return "Hello $message"
    }

    override fun getMessageFromNative(message: String, callback: (Result<String>) -> Unit) {
        callback(Result.success("I am callback from Native"))
    }
}
