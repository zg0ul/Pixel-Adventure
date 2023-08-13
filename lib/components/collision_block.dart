import 'package:flame/components.dart';

class CollisionBlock extends PositionComponent {
  bool isPlatform;
  // what super does is pass through what's in the constructor to the parent class (PositionComponent)
  CollisionBlock({
    position,
    size,
    this.isPlatform = false,
  }) : super(
          position: position,
          size: size,
        ) {
    // debugMode = true; // uncomment this to see the collision boxes
  }
}
