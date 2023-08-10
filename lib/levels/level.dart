import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Level extends World {
  late TiledComponent level;

  @override
  FutureOr<void> onLoad() async {
    // we use await because loading a level can take some time due to size
    // TiledComponent filename doesn't need the full path because flame_tiled already knows the path to the assets/tiles folder (hence why we need to make sure we have the assets/tiles folder without spelling errors)
    // Vector2.all(16) means that each tile is 16x16 pixels (instead of using Vector2(16, 16))
    level = await TiledComponent.load('Level-01.tmx', Vector2.all(16)); // create the level

    add(level); // add the level to the game

    return super.onLoad();
  }
}
