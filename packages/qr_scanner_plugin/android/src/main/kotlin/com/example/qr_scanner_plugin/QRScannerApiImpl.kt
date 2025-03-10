package com.example.qr_scanner_plugin

import android.app.Activity
import android.content.Intent
import android.util.Log
import com.journeyapps.barcodescanner.ScanOptions
import io.flutter.plugin.common.PluginRegistry

class QRScannerApiImpl : QRScannerApi, PluginRegistry.ActivityResultListener {
    private var activity: Activity? = null
    private var scanResultCallback: ((Result<QRResult>) -> Unit)? = null

    fun setActivity(activity: Activity) { 
        this.activity = activity
    }

   override fun scanQRCode(callback: (Result<QRResult>) -> Unit) {
    Log.d("QRScannerApiImpl", "🚀 Iniciando escaneo de código QR...")
    
    val currentActivity = activity
    if (currentActivity == null) {
        Log.e("QRScannerApiImpl", "❌ Actividad no disponible. No se puede iniciar el escaneo.")
        callback(Result.failure(Exception("❌ Actividad no disponible en QRScannerApiImpl")))
        return
    }

    Log.d("QRScannerApiImpl", "📡 Actividad detectada: $currentActivity")

    scanResultCallback = callback

    val options = ScanOptions().apply {
        setDesiredBarcodeFormats(ScanOptions.QR_CODE)
        setPrompt("Escanea el código QR")
        setBeepEnabled(true) 
        setOrientationLocked(true) 
        setCameraId(0) 
    }

    val intent = options.createScanIntent(currentActivity)
    Log.d("QRScannerApiImpl", "📸 Intent de escaneo creado. Lanzando cámara...")
    
    try {
        currentActivity.startActivityForResult(intent, REQUEST_CODE_QR_SCAN)
        Log.d("QRScannerApiImpl", "✅ Cámara lanzada con startActivityForResult.")
    } catch (e: Exception) {
        Log.e("QRScannerApiImpl", "❌ Error al lanzar la cámara: ${e.localizedMessage}")
        callback(Result.failure(e))
    }
}

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        Log.d("QRScannerApiImpl", "📌 onActivityResult llamado con requestCode=$requestCode, resultCode=$resultCode")

        if (requestCode == REQUEST_CODE_QR_SCAN) {
            when (resultCode) {
                Activity.RESULT_OK -> {
                    val scannedData = data?.getStringExtra("SCAN_RESULT")
                    Log.d("QRScannerApiImpl", "✅ Código escaneado: $scannedData")

                    if (!scannedData.isNullOrEmpty()) {
                        activity?.runOnUiThread {
                            scanResultCallback?.invoke(Result.success(QRResult(value = scannedData)))
                        }
                    } else {
                        activity?.runOnUiThread {
                            scanResultCallback?.invoke(Result.failure(Exception("❌ Código QR vacío.")))
                        }
                    }
                }

                Activity.RESULT_CANCELED -> {
                    Log.e("QRScannerApiImpl", "⚠️ Escaneo cancelado por el usuario.")
                    activity?.runOnUiThread {
                        scanResultCallback?.invoke(Result.failure(Exception("⚠️ Escaneo cancelado por el usuario.")))
                    }
                }

                else -> {
                    Log.e("QRScannerApiImpl", "❌ Error desconocido en el escaneo.")
                    activity?.runOnUiThread {
                        scanResultCallback?.invoke(Result.failure(Exception("❌ Error desconocido en el escaneo.")))
                    }
                }
            }

            // Limpiar el callback después de su uso
            scanResultCallback = null
            return true
        }

        return false
    }

    companion object {
        private const val REQUEST_CODE_QR_SCAN = 1001
    }
}
