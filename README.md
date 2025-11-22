# Flutter WebView & Social Login App

A Flutter application that supports social media login (Google & Facebook) and a configurable WebView. Users can input a website URL to display, and the app can scan for available Wi-Fi networks and Bluetooth devices.

## Features

* Google & Facebook authentication
* Logout functionality
* Settings page to input a URL for WebView
* Dropdown lists for Wi-Fi networks and Bluetooth devices
* State management with Flutter Bloc (Cubits)
* Persistent URL storage using SharedPreferences

## Dependencies

* flutter_bloc
* firebase_auth
* google_sign_in
* flutter_facebook_auth
* webview_flutter
* shared_preferences
* flutter_blue_plus
* wifi_iot

## Run

1. Clone the repository
2. Install dependencies: `flutter pub get`
3. Run the app: `flutter run`
