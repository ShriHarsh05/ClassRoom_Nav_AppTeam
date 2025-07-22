package com.example.classroom_navigator

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import android.content.pm.PackageManager
import android.content.pm.PackageInfo
import android.content.pm.Signature
import android.util.Base64
import android.util.Log
import java.security.MessageDigest
import java.security.NoSuchAlgorithmException

class MainActivity: FlutterActivity() {
    private val TAG = "MainActivity"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        getAppSignature()
    }

    private fun getAppSignature() {
        try {
            val info: PackageInfo = packageManager.getPackageInfo(
                packageName,
                PackageManager.GET_SIGNATURES
            )
            // ADD THIS NULL CHECK: info.signatures?.forEach { ... }
            // This safely iterates only if signatures is not null
            info.signatures?.forEach { signature -> // <--- CHANGE THIS LINE
                val md: MessageDigest = MessageDigest.getInstance("SHA")
                md.update(signature.toByteArray())
                val currentSignature = Base64.encodeToString(md.digest(), Base64.DEFAULT)
                Log.d(TAG, "SHA-1 (Base64): $currentSignature")
            }
        } catch (e: PackageManager.NameNotFoundException) {
            Log.e(TAG, "Package name not found", e)
        } catch (e: NoSuchAlgorithmException) {
            Log.e(TAG, "No such algorithm", e)
        }
    }
}