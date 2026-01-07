import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';

/// Represents the player character in a platformer game.
/// Handles movement, jumping, collision detection, and score tracking.
class Player extends SpriteAnimationComponent
    with HasGameRef, Hitbox, Collidable, KeyboardHandler {
  Vector2 velocity = Vector2(0, 0);
  final double gravity = 500;
  final double jumpSpeed = -300;
  final double moveSpeed = 150;
  bool onGround = false;
  int lives = 3;
  int score = 0;

  Player({SpriteAnimation? animation, Vector2? position, Vector2? size})
      : super(animation: animation, position: position, size: size) {
    addHitbox(HitboxRectangle());
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Apply gravity
    velocity.y += gravity * dt;
    position.add(velocity * dt);

    // Check for ground contact
    if (position.y > gameRef.size.y - size.y) {
      position.y = gameRef.size.y - size.y;
      onGround = true;
      velocity.y = 0;
    } else {
      onGround = false;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    // Handle collision with obstacles or platforms here
    // For simplicity, we assume any collision means landing on a platform
    onGround = true;
    velocity.y = 0;
  }

  /// Handles keyboard input for player movement and jumping.
  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is RawKeyDownEvent) {
      if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
        velocity.x = -moveSpeed;
      } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
        velocity.x = moveSpeed;
      }

      if (keysPressed.contains(LogicalKeyboardKey.space) && onGround) {
        jump();
      }
    } else if (event is RawKeyUpEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft ||
          event.logicalKey == LogicalKeyboardKey.arrowRight) {
        velocity.x = 0;
      }
    }
    return true;
  }

  /// Makes the player jump if they are on the ground.
  void jump() {
    if (onGround) {
      velocity.y = jumpSpeed;
      onGround = false;
    }
  }

  /// Increments the player's score.
  void addScore(int points) {
    score += points;
  }

  /// Decreases the player's lives and handles game over logic.
  void loseLife() {
    lives -= 1;
    if (lives <= 0) {
      // Handle game over logic here
    }
  }
}