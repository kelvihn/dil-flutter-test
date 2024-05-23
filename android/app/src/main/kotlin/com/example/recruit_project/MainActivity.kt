package com.example.recruit_project

import android.provider.Settings
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterFragmentActivity() {

    private val CHANNEL = "sample/getAndroidId"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            // This method is invoked on the main thread.
            if (call.method == "getAndroidId") {
                val androidId = getAndroidId()
                if (androidId != null) {
                    result.success(androidId)
                } else {
                    result.error("UNAVAILABLE", "Android ID is unavailable for this device.", null)
                }
            } else {
                result.notImplemented()
            }
        }
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }

    private fun getAndroidId(): String? {
        return Settings.Secure.getString(contentResolver, Settings.Secure.ANDROID_ID)
    }
}