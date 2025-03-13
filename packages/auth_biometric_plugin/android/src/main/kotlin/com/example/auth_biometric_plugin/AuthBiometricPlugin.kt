package com.example.auth_biometric_plugin

import android.app.Activity
import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

class AuthBiometricPlugin : FlutterPlugin, ActivityAware {
    private var activityBinding: ActivityPluginBinding? = null
    private var authApiImpl: AuthBiometricApiImpl? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        authApiImpl = AuthBiometricApiImpl(null) 
        BiometricAuthApi.setUp(binding.binaryMessenger, authApiImpl)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        BiometricAuthApi.setUp(binding.binaryMessenger, null)
        authApiImpl = null
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activityBinding = binding
        authApiImpl?.setActivity(binding.activity) 
        Log.d("AuthBiometricPlugin", " onAttachedToActivity llamado.")
    }

    override fun onDetachedFromActivity() {
        activityBinding = null
        authApiImpl?.setActivity(null)
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }
}
