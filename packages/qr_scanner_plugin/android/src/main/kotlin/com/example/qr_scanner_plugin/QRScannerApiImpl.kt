package com.example.qr_scanner_plugin

import android.util.Log
import io.flutter.plugin.common.BinaryMessenger

class QRScannerApiImpl : QRScannerApi {
    override fun scanQRCode(callback: (Result<QRResult>) -> Unit) {
        try {
            Log.d("QRScannerApiImpl", "Iniciando escaneo de código QR") 
            val result = QRResult(value = "Código QR escaneado desde Kotlin")
            callback(Result.success(result))
        } catch (e: Exception) {
            Log.e("QRScannerApiImpl", "Error al escanear QR", e)
            callback(Result.failure(e))
        }
    }
}

fun registerQRScannerApi(binaryMessenger: BinaryMessenger) {
    QRScannerApi.setUp(binaryMessenger, QRScannerApiImpl())
}
