package com.riftlabs.flutter_mcumgr

import android.app.Activity
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.embedding.engine.plugins.activity.ActivityAware

import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothDevice
import android.content.Context
import android.net.Uri
import android.util.Log
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.runtime.mcumgr.ble.McuMgrBleTransport
import io.runtime.mcumgr.dfu.FirmwareUpgradeCallback
import io.runtime.mcumgr.dfu.FirmwareUpgradeController
import io.runtime.mcumgr.dfu.FirmwareUpgradeManager
import io.runtime.mcumgr.exception.McuMgrException
import java.io.IOException

/** FlutterMcumgrPlugin */
class FlutterMcumgrPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel


    private val channelName = "flutter_mcumgr";
    private lateinit var context: Context
    private lateinit var activity: Activity

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
        context = flutterPluginBinding.applicationContext

    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "getPlatformVersion") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        } else if (call.method == "startDfu") {
            val id = call.argument<String>("id")
            val macAddress = call.argument<String>("macAddress")
            val updateFileUriString = call.argument<String>("updateFileUriString")
            val updateOptions = call.argument<HashMap<String, Any>>("updateOptions")

            startDfu(id!!,macAddress,updateFileUriString,updateOptions!!)

        } else {
            result.notImplemented()
        }
    }


    private fun startDfu(
        id: String,
        macAddress: String?,
        updateFileUriString: String?,
        updateOptions: HashMap<String, Any>
    ) {
        if (this.bluetoothAdapter == null) {
            throw Exception("no bluetooth adapter")
        }
        if (upgrades.contains(id)) {
            throw Exception("update ID already present")
        }

        val device: BluetoothDevice = bluetoothAdapter.getRemoteDevice(macAddress)
        val updateFileUri = Uri.parse(updateFileUriString)

        val upgrade = DeviceUpgrade(channel, id, device, context, updateFileUri, updateOptions)
        this.upgrades[id] = upgrade

        this.upgrades[id]!!.doUpdate(updateFileUri)

    }


    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    // ******************************************
    // Implement ActivityAware interface
    // ******************************************
    override fun onDetachedFromActivity() {
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }

}
