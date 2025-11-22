import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'device_state.dart';

class DeviceCubit extends Cubit<DeviceState> {
  DeviceCubit() : super(DeviceState());

  StreamSubscription<List<ScanResult>>? _btSubscription;

  // Future<void> scanBluetooth() async {
  //   emit(state.copyWith(isLoading: true));

  //   final flutterBlue = FlutterBluePlus.instance; // مجرد instance
  //   flutterBlue.startScan(timeout: const Duration(seconds: 4)); // startScan على سطر لوحده

  //   _btSubscription = flutterBlue.scanResults.listen((results) {
  //     final devices = results
  //         .map((r) => r.device.name)
  //         .where((name) => name.isNotEmpty)
  //         .toList();
  //     emit(state.copyWith(bluetoothDevices: devices));
  //   });

  //   await Future.delayed(const Duration(seconds: 4));
  //   flutterBlue.stopScan();
  //   _btSubscription?.cancel();
  //   emit(state.copyWith(isLoading: false));
  // }

  Future<void> scanWiFi() async {
    emit(state.copyWith(isLoading: true));
    final networks = await WiFiForIoTPlugin.loadWifiList();
    final ssids = networks
            ?.map((n) => n.ssid ?? '')
            .where((ssid) => ssid.isNotEmpty)
            .toList() ??
        [];
    emit(state.copyWith(wifiNetworks: ssids, isLoading: false));
  }

  @override
  Future<void> close() {
    _btSubscription?.cancel();
    return super.close();
  }
}
