package com.app.quranchat

import android.content.Intent
import android.os.Bundle
import android.provider.Settings
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.util.Log

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.yourcompany.autostart"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            if (call.method == "openAutoStartSettings") {
                try {
                    openAutoStartSettings()
                    result.success(true)
                } catch (e: Exception) {
                    Log.e("AutoStart", "Error opening settings", e)
                    result.error("UNAVAILABLE", "Auto-start setting not available.", null)
                }
            }
        }
    }

    private fun openAutoStartSettings() {
        val manufacturer = android.os.Build.MANUFACTURER.lowercase()
        val intent = Intent()

        when (manufacturer) {
            "xiaomi" -> {
                intent.setClassName("com.miui.securitycenter", "com.miui.permcenter.autostart.AutoStartManagementActivity")
            }
            "oppo" -> {
                intent.setClassName("com.coloros.safecenter", "com.coloros.safecenter.permission.startup.StartupAppListActivity")
            }
            "vivo" -> {
                intent.setClassName("com.vivo.permissionmanager", "com.vivo.permissionmanager.activity.BgStartUpManagerActivity")
            }
            "letv" -> {
                intent.setClassName("com.letv.android.letvsafe", "com.letv.android.letvsafe.AutobootManageActivity")
            }
            "honor", "huawei" -> {
                intent.setClassName("com.huawei.systemmanager", "com.huawei.systemmanager.startupmgr.ui.StartupNormalAppListActivity")
            }
            else -> {
                // fallback
                intent.action = Settings.ACTION_APPLICATION_DETAILS_SETTINGS
                intent.data = android.net.Uri.parse("package:$packageName")
            }
        }

        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        startActivity(intent)
    }
}

