package com.riftlabs.flutter_mcumgr

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothDevice
import android.net.Uri
import android.util.Log

/** FlutterMcumgrPlugin */
class FlutterMcumgrPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private val channelName = "flutter_mcumgr";
    private val bluetoothAdapter: BluetoothAdapter? = BluetoothAdapter.getDefaultAdapter()
    private val upgrades: MutableMap<String, DeviceUpgrade> = mutableMapOf()


    private fun setup(plugin: FlutterMcumgrPlugin, binaryMessenger: BinaryMessenger) {
        plugin.channel = MethodChannel(binaryMessenger, channelName);
        plugin.channel.setMethodCallHandler(plugin);

        //plugin.synth = new Synth();
        //plugin.synth.start();
    }

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {

        setup(this, flutterPluginBinding.binaryMessenger)
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_mcumgr")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "getPlatformVersion") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
