package com.example.firebase_sample_v2

import android.content.Context
import androidx.multidex.MultiDex
import com.clevertap.android.sdk.ActivityLifecycleCallback
import com.clevertap.android.sdk.CleverTapAPI
import io.flutter.app.FlutterApplication

class SampleApplication : FlutterApplication() {

    override fun attachBaseContext(base: Context) {
        super.attachBaseContext(base)
        MultiDex.install(this)
    }

    override fun onCreate() {
        super.onCreate()
        CleverTapAPI.setDebugLevel(3)
        ActivityLifecycleCallback.register(this)
    }
    
}