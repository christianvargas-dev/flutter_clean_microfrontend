package com.example.qr_scanner_plugin

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import com.example.qr_scanner_plugin.registerQRScannerApi

class QrScannerPlugin: FlutterPlugin {
    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        registerQRScannerApi(binding.binaryMessenger) // ✅ Registra la API cuando se carga el plugin
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        QRScannerApi.setUp(binding.binaryMessenger, null) // ✅ Limpia la API al cerrar el plugin
    }
}

