package com.example.auth_biometric_plugin

import android.app.Activity
import android.content.Context
import android.hardware.biometrics.BiometricPrompt
import android.os.Build
import android.os.CancellationSignal
import androidx.annotation.RequiresApi
import androidx.core.content.ContextCompat

class AuthBiometricApiImpl(private var activity: Activity?) : BiometricAuthApi {

    private var cancellationSignal: CancellationSignal? = null

    fun setActivity(activity: Activity?) {
        this.activity = activity
    }

    override fun authenticate(): BiometricResult {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            authenticateWithBiometricPrompt()
        } else {
            BiometricResult(success = false, message = " Biometric authentication not supported.")
        }
    }

    @RequiresApi(Build.VERSION_CODES.P)
    private fun authenticateWithBiometricPrompt(): BiometricResult {
        val currentActivity = activity ?: return BiometricResult(
            success = false,
            message = " Activity no disponible para autenticación biométrica."
        )

        val executor = ContextCompat.getMainExecutor(currentActivity)
        val biometricPrompt = BiometricPrompt.Builder(currentActivity) 
            .setTitle("Autenticación Biométrica")
            .setSubtitle("Usa tu huella digital para continuar")
            .setNegativeButton("Cancelar", executor) { _, _ ->
                BiometricResult(success = false, message = "⚠️ Autenticación cancelada.")
            }
            .build()

        cancellationSignal = CancellationSignal()
        biometricPrompt.authenticate(cancellationSignal!!, executor, object : BiometricPrompt.AuthenticationCallback() {
            override fun onAuthenticationSucceeded(result: BiometricPrompt.AuthenticationResult?) {
                super.onAuthenticationSucceeded(result)
                BiometricResult(success = true, message = " Autenticación exitosa.")
            }

            override fun onAuthenticationFailed() {
                super.onAuthenticationFailed()
                BiometricResult(success = false, message = " Autenticación fallida.")
            }
        })

        return BiometricResult(success = true, message = " Autenticando...")
    }
}
