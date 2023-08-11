import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:pixel_adventure/components/collision_block.dart';
import 'package:pixel_adventure/components/player.dart';

class Level extends World {
  final String levelName;
  final Player player;
  Level({required this.levelName, required this.player});
  late TiledComponent level;
  List<CollisionBlock> collisionBlocks = [];

  @override
  FutureOr<void> onLoad() async {
    // create the level
    // we use await because loading a level can take some time due to size
    // TiledComponent filename doesn't need the full path because flame_tiled already knows the path to the assets/tiles folder (hence why we need to make sure we have the assets/tiles folder without spelling errors)
    // Vector2.all(16) means that each tile is 16x16 pixels (instead of using Vector2(16, 16))
    level = await TiledComponent.load('$levelName.tmx', Vector2.all(16));

    add(level); // add the level to the game

    // get the spawn points layer from the level
    final spawnPointsLayer = level.tileMap.getLayer<ObjectGroup>('Spawnpoints');

    if (spawnPointsLayer != null) {
      for (final spawnPoint in spawnPointsLayer.objects) {
        switch (spawnPoint.class_) {
          // spawn the player in the player spawn point (Player class in Tiled)
          case 'Player':
            player.position = Vector2(spawnPoint.x, spawnPoint.y);
            add(player); // add the player to the game
            break;
          default:
        }
      }
    }

    final collisionsLayer = level.tileMap.getLayer<ObjectGroup>('Collisions');

    if (collisionsLayer != null) {
      for (final collision in collisionsLayer.objects) {
        switch (collision.class_) {
          case 'Platform':
            final platform = CollisionBlock(
              position: Vector2(collision.x, collision.y),
              size: Vector2(collision.width, collision.height),
              isPlatform: true,
            );
            collisionBlocks.add(platform);
            add(platform);
            break;
          default:
            final block = CollisionBlock(
              position: Vector2(collision.x, collision.y),
              size: Vector2(collision.width, collision.height),
            );
            collisionBlocks.add(block);
            add(block);
        }
      }
    }
    player.collisionBlocks = collisionBlocks;
    return super.onLoad();
  }
}
