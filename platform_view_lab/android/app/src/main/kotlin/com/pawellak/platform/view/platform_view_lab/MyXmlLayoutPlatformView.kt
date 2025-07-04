package com.pawellak.platform.view.platform_view_lab

import android.content.Context
import android.view.View
import android.widget.Button
import android.widget.TextView
import android.view.LayoutInflater
import android.widget.EditText
import com.pawellak.platform_channel_with_pigeon.pigeons.MessageApi
import com.pawellak.platform_channel_with_pigeon.pigeons.ReverseMessageApi
import io.flutter.plugin.common.BinaryMessenger

import io.flutter.plugin.platform.PlatformView
import kotlin.math.roundToInt

class MyXmlLayoutPlatformView(
    private val context: Context,
    private val messenger: BinaryMessenger,
    id: Int,

) : PlatformView, MessageApi {

    private val rootView: View
    private val textViewMessage: TextView
    private val buttonSend: Button
    private val editText: EditText

    init {
        MessageApi.setUp(messenger, this)

        val inflater = LayoutInflater.from(context)
        rootView = inflater.inflate(R.layout.activity_preview, null, false)
        textViewMessage = rootView.findViewById(R.id.text_view_message)
        editText = rootView.findViewById(R.id.editText_basic)
        buttonSend = rootView.findViewById(R.id.button_send)
        textViewMessage.text = context.getString(R.string.write_some_age)

        buttonSend.setOnClickListener {
            ReverseMessageApi(messenger).getTemperatureInCityFromFlutter(
                editText.text.toString(),
            callback = { result -> buttonSend.text = result.getOrNull().toString() })
        }
    }

    override fun getView(): View {
        return rootView
    }

    override fun dispose() {}

    override fun getRoundedNumberFromNative(value: Double, callback: (Result<String>) -> Unit) {
        textViewMessage.text = value.toString()
        callback(Result.success(value.roundToInt().toString()))
    }
}
