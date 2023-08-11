import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/actors/player.dart';
import 'package:pixel_adventure/levels/level.dart';

class PixelAdventure extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks {
  @override
  Color backgroundColor() => const Color(0xFF211F30);

  // we need to add a camera component to actually see the level we created
  late final CameraComponent cam;

  // add a reference to the player so that we can access it from the level
  Player player = Player(character: 'Mask Dude');

  // add a joystick component which needs a DragCallbacks mixin
  late JoystickComponent joystick;
  bool showJoystick = false;

  @override
  FutureOr<void> onLoad() async {
    // load all the images into the cache (can be a problem if there are too many images)
    await images.loadAllImages();

    // calling the Level class also calls the onLoad method which has the code to load the level
    // the creating of the level must be in the onLoad method because we need to wait for the images to load first (the players sprites)
    final world = Level(
      player: player,
      levelName: 'Level-02',
    );

    // create a camera with a fixed resolution (so that the game looks the same on all devices)
    cam = CameraComponent.withFixedResolution(
        world: world, width: 640, height: 360);

    // set the camera to be top left on the screen because by default it's centered (top let of the map is in the center of the screen but we want it to be in the top left)
    cam.viewfinder.anchor = Anchor.topLeft;

    // add the camera and the level to the game (order matters)
    addAll([cam, world]);

    if (showJoystick) {
    addJoystick();
    }

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (showJoystick) {
    updateJoystick(dt);
    }
    super.update(dt);
  }

  void addJoystick() {
    joystick = JoystickComponent(
      knob: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Knob.png'),
        ),
      ),
      knobRadius: 32,
      background: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Joystick.png'),
        ),
      ),
      margin: const EdgeInsets.only(left: 32, bottom: 32),
    );

    add(joystick);
  }

  void updateJoystick(double dt) {
    switch (joystick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        player.playerDirection = PlayerDirection.left;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        player.playerDirection = PlayerDirection.right;
        break;
      default:
        player.playerDirection = PlayerDirection.none;
        break;
    }
  }
}
