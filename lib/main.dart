import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // wait for flutter to initialize before calling stuff
  await Flame.device.fullScreen(); // make the game fullscreen (removes status bar)
  await Flame.device.setLandscape(); // set the game to landscape mode
  
  PixelAdventure game = PixelAdventure();
  runApp(GameWidget(game: kDebugMode ? PixelAdventure() : game),);
}

