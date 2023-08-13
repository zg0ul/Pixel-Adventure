import 'package:flame/components.dart';

const double stepTime = 0.05; // the time between each frame of the animation
const double moveSpeed = 100;
Vector2 velocity = Vector2.zero();

const double gravity = 9.8;
const double jumpForce = 300;
const double terminalVelocity = 300;

const double scrollSpeed = 0.4;