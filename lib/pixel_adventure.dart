import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:pixel_adventure/levels/level.dart';

class PixelAdventure extends FlameGame {
  @override
  Color backgroundColor() => const Color(0xFF211F30);

  // we need to add a camera component to actually see the level we created
  late final CameraComponent cam;

  final world = Level(
    levelName: 'Level-02',
  ); // calling the Level class also calls the onLoad method which has the code to load the level

  @override
  FutureOr<void> onLoad() async {
    // load all the images into the cache (can be a problem if there are too many images)
    await images.loadAllImages();

    // create a camera with a fixed resolution (so that the game looks the same on all devices)
    cam = CameraComponent.withFixedResolution(
        world: world, width: 640, height: 360);

    // set the camera to be top left on the screen because by default it's centered (top let of the map is in the center of the screen but we want it to be in the top left)
    cam.viewfinder.anchor = Anchor.topLeft;

    // add the camera and the level to the game (order matters)
    addAll([cam, world]);

    return super.onLoad();
  }
}
