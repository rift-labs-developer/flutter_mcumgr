import 'flutter_mcumgr_platform_interface.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class FlutterMcumgr {
  Future<String?> getPlatformVersion() {
    return FlutterMcumgrPlatform.instance.getPlatformVersion();
  }

  static const methodChannel = MethodChannel('flutter_mcumgr');

  static Future<String> startDfu() async {
    methodChannel.setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case "onUpgradeStarted":
          break;
        case "onStateChanged":
          break;
      }
    });

    return "";
  }
}

abstract class DfuProgressListenerAdapter {
  void onDeviceConnected(String deviceAddress) {}

  void onDeviceConnecting(String deviceAddress) {}

  void onDeviceDisconnected(String deviceAddress) {}

  void onDeviceDisconnecting(String deviceAddress) {}

  void onDfuAborted(String deviceAddress) {}

  void onDfuCompleted(String deviceAddress) {}

  void onDfuProcessStarted(String deviceAddress) {}

  void onDfuProcessStarting(String deviceAddress) {}

  void onEnablingDfuMode(String deviceAddress) {}

  void onFirmwareValidating(String deviceAddress) {}

  void onError(
    String deviceAddress,
    int error,
    int errorType,
    String message,
  ) {}

  void onProgressChanged(
    String deviceAddress,
    int percent,
    double speed,
    double avgSpeed,
    int currentPart,
    int partsTotal,
  ) {}
}

class DefaultDfuProgressListenerAdapter extends DfuProgressListenerAdapter {
  void Function(String deviceAddress)? onDeviceConnectedHandle;

  void Function(String deviceAddress)? onDeviceConnectingHandle;

  void Function(String deviceAddress)? onDeviceDisconnectedHandle;

  void Function(String deviceAddress)? onDeviceDisconnectingHandle;

  void Function(String deviceAddress)? onDfuAbortedHandle;

  void Function(String deviceAddress)? onDfuCompletedHandle;

  void Function(String deviceAddress)? onDfuProcessStartedHandle;

  void Function(String deviceAddress)? onDfuProcessStartingHandle;

  void Function(String deviceAddress)? onEnablingDfuModeHandle;

  void Function(String deviceAddress)? onFirmwareValidatingHandle;

  void Function(String deviceAddress, int error, int errorType, String message)?
      onErrorHandle;

  void Function(
      String deviceAddress,
      int percent,
      double speed,
      double avgSpeed,
      int currentPart,
      int partsTotal)? onProgressChangedHandle;

  DefaultDfuProgressListenerAdapter({
    this.onDeviceConnectedHandle,
    this.onDeviceConnectingHandle,
    this.onDeviceDisconnectedHandle,
    this.onDeviceDisconnectingHandle,
    this.onDfuAbortedHandle,
    this.onDfuCompletedHandle,
    this.onDfuProcessStartedHandle,
    this.onDfuProcessStartingHandle,
    this.onEnablingDfuModeHandle,
    this.onFirmwareValidatingHandle,
    this.onErrorHandle,
    this.onProgressChangedHandle,
  });

  @override
  void onDeviceConnected(String deviceAddress) {
    super.onDeviceConnected(deviceAddress);
    if (onDeviceConnectedHandle != null) {
      onDeviceConnectedHandle!(deviceAddress);
    }
  }

  @override
  void onDeviceConnecting(String deviceAddress) {
    super.onDeviceConnecting(deviceAddress);
    if (onDeviceConnectingHandle != null) {
      onDeviceConnectingHandle!(deviceAddress);
    }
  }

  @override
  void onDeviceDisconnected(String deviceAddress) {
    super.onDeviceDisconnected(deviceAddress);
    if (onDeviceDisconnectedHandle != null) {
      onDeviceDisconnectedHandle!(deviceAddress);
    }
  }

  @override
  void onDeviceDisconnecting(String deviceAddress) {
    super.onDeviceDisconnecting(deviceAddress);
    if (onDeviceDisconnectingHandle != null) {
      onDeviceDisconnectingHandle!(deviceAddress);
    }
  }

  @override
  void onDfuAborted(String deviceAddress) {
    super.onDfuAborted(deviceAddress);
    if (onDfuAbortedHandle != null) {
      onDfuAbortedHandle!(deviceAddress);
    }
  }

  @override
  void onDfuCompleted(String deviceAddress) {
    super.onDfuCompleted(deviceAddress);
    if (onDfuCompletedHandle != null) {
      onDfuCompletedHandle!(deviceAddress);
    }
  }

  @override
  void onDfuProcessStarted(String deviceAddress) {
    super.onDfuProcessStarted(deviceAddress);
    if (onDfuProcessStartedHandle != null) {
      onDfuProcessStartedHandle!(deviceAddress);
    }
  }

  @override
  void onDfuProcessStarting(String deviceAddress) {
    super.onDfuProcessStarting(deviceAddress);
    if (onDfuProcessStartingHandle != null) {
      onDfuProcessStartingHandle!(deviceAddress);
    }
  }

  @override
  void onEnablingDfuMode(String deviceAddress) {
    super.onEnablingDfuMode(deviceAddress);
    if (onEnablingDfuModeHandle != null) {
      onEnablingDfuModeHandle!(deviceAddress);
    }
  }

  @override
  void onFirmwareValidating(String deviceAddress) {
    super.onFirmwareValidating(deviceAddress);
    if (onFirmwareValidatingHandle != null) {
      onFirmwareValidatingHandle!(deviceAddress);
    }
  }

  @override
  void onError(
    String deviceAddress,
    int error,
    int errorType,
    String message,
  ) {
    super.onError(
      deviceAddress,
      error,
      errorType,
      message,
    );
    if (onErrorHandle != null) {
      onErrorHandle!(
        deviceAddress,
        error,
        errorType,
        message,
      );
    }
  }

  void onProgressChanged(
    String deviceAddress,
    int percent,
    double speed,
    double avgSpeed,
    int currentPart,
    int partsTotal,
  ) {
    super.onProgressChanged(
      deviceAddress,
      percent,
      speed,
      avgSpeed,
      currentPart,
      partsTotal,
    );
    if (onProgressChangedHandle != null) {
      onProgressChangedHandle!(
        deviceAddress,
        percent,
        speed,
        avgSpeed,
        currentPart,
        partsTotal,
      );
    }
  }
}
