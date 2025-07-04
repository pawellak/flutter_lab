package com.pawellak.platform.view.platform_view_lab

import android.content.Context
import android.view.View
import android.widget.Button
import android.widget.TextView

import android.view.LayoutInflater

import android.widget.Toast // For button click example
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel // For communication
import io.flutter.plugin.platform.PlatformView

// This class will be our PlatformView implementation
class MyXmlLayoutPlatformView(
    private val context: Context,
    private val messenger: BinaryMessenger,
    id: Int, // Unique ID for this view instance

) : PlatformView, MethodChannel.MethodCallHandler {

    private val rootView: View
    private val textViewMessage: TextView
    private val buttonSend: Button

    private val methodChannel: MethodChannel // For communication with Flutter

    init {
        // 1. Inflate the XML layout
        val inflater = LayoutInflater.from(context)
        rootView = inflater.inflate(R.layout.activity_preview, null, false)

        // 2. Get references to the views within the layout
        textViewMessage = rootView.findViewById(R.id.text_view_message)
        buttonSend = rootView.findViewById(R.id.button_send)

        // 3. Initialize MethodChannel for communication
        methodChannel = MethodChannel(messenger, "myAndroidUIView_channel_$id")
        methodChannel.setMethodCallHandler(this)

        // 4. Handle initial arguments from Flutter (optional)
       textViewMessage.text = "Default message from Native Android" // Default if no args


        // 5. Set up any event listeners
        buttonSend.setOnClickListener {
            val messageFromTextView = textViewMessage.text.toString()
            Toast.makeText(context, "Button clicked! Message: $messageFromTextView", Toast.LENGTH_LONG).show()

            // Optionally, send a message back to Flutter
            methodChannel.invokeMethod("onMessageSent", messageFromTextView)
        }
    }

    // This is called by Flutter to get the Android View
    override fun getView(): View {
        return rootView
    }

    // Handle method calls from Flutter
    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "updateMessage" -> {
                val newMessage = call.argument<String>("message")
                if (newMessage != null) {
                    textViewMessage.text = newMessage
                    result.success(null) // Indicate success
                } else {
                    result.error("INVALID_ARGS", "Message argument is null", null)
                }
            }
            // Add other methods as needed
            else -> result.notImplemented()
        }
    }

    // Called when the PlatformView is about to be Ktdestroyed
    override fun dispose() {
        // Clean up resources, e.g., remove listeners, clear MethodChannel handler
        methodChannel.setMethodCallHandler(null)
        // Any other cleanup specific to your views
    }
}