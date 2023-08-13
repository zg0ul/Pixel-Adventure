import 'dart:async';

import 'package:flame/components.dart';
import 'package:pixel_adventure/constants/settings.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

class BackgroundTile extends SpriteComponent with HasGameRef<PixelAdventure> {
  final String color;
  BackgroundTile({
    this.color = 'Green',
    position,
  }) : super(
          position: position,
        );

  @override
  FutureOr<void> onLoad() {
    priority = -1; // set the background to always be behind everything else
    size = Vector2.all(64.6);
    sprite = Sprite(game.images.fromCache('Background/$color.png'));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    position.y += scrollSpeed; // move the background down
    double tileSize = 64;
    int scrollHeight = (gameRef.size.y / tileSize).floor();
    if (position.y > scrollHeight * tileSize) {
      position.y = -tileSize;
    }
    super.update(dt);
  }
}
