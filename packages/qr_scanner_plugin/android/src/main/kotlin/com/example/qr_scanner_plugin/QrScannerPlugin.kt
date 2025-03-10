package com.example.qr_scanner_plugin

import android.util.Log

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger

class QrScannerPlugin: FlutterPlugin, ActivityAware {
    private var activityBinding: ActivityPluginBinding? = null
    private var qrScannerApiImpl: QRScannerApiImpl? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        qrScannerApiImpl = QRScannerApiImpl() 
        QRScannerApi.setUp(binding.binaryMessenger, qrScannerApiImpl)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        QRScannerApi.setUp(binding.binaryMessenger, null)
        qrScannerApiImpl = null
    }

   override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activityBinding = binding
    qrScannerApiImpl?.setActivity(binding.activity) 
    binding.addActivityResultListener(qrScannerApiImpl!!)

    Log.d("QrScannerPlugin", " onAttachedToActivity llamado. Listener de actividad registrado correctamente.")
}

    override fun onDetachedFromActivity() {
        activityBinding = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }
}
