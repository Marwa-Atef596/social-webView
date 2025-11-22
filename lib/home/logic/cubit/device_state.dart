class DeviceState {
  final List<String> bluetoothDevices;
  final List<String> wifiNetworks;
  final bool isLoading;

  DeviceState({
    this.bluetoothDevices = const [],
    this.wifiNetworks = const [],
    this.isLoading = false,
  });

  DeviceState copyWith({
    List<String>? bluetoothDevices,
    List<String>? wifiNetworks,
    bool? isLoading,
  }) {
    return DeviceState(
      bluetoothDevices: bluetoothDevices ?? this.bluetoothDevices,
      wifiNetworks: wifiNetworks ?? this.wifiNetworks,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}