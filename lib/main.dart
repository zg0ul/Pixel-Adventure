import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // wait for flutter to initialize before calling stuff
  Flame.device.fullScreen(); // make the game fullscreen (removes status bar)
  Flame.device.setLandscape(); // set the game to landscape mode
  
  PixelAdventure game = PixelAdventure();
  runApp(GameWidget(game: kDebugMode ? PixelAdventure() : game),);
}

