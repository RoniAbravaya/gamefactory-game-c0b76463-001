import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';

/// A component representing a collectible item in a platformer game.
///
/// It includes collision detection for pickup, a score value, optional animation,
/// and a sound effect trigger upon collection.
class Collectible extends SpriteAnimationComponent with HasGameRef, Hitbox, Collidable {
  final int scoreValue;
  final String pickupSound;
  bool collected = false;

  /// Creates a new instance of a collectible item.
  ///
  /// [scoreValue] specifies the score the player receives upon collecting this item.
  /// [pickupSound] is the path to the sound effect file that plays when the item is collected.
  Collectible({
    required SpriteAnimation animation,
    required Vector2 position,
    required Vector2 size,
    this.scoreValue = 100,
    this.pickupSound = 'pickup.mp3',
  }) : super(animation: animation, position: position, size: size) {
    addShape(HitboxRectangle());
  }

  @override
  void onMount() {
    super.onMount();
    // Ensure the collectible has a hitbox for collision detection
    addHitbox(HitboxRectangle());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    // When a collision is detected, mark the collectible as collected
    // and trigger the pickup sound effect.
    if (!collected) {
      collected = true;
      try {
        FlameAudio.play(pickupSound);
      } catch (e) {
        // If there's an error playing the sound, log or handle it gracefully
        print('Error playing sound: $e');
      }
      removeFromParent();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Optional: Add any animations or effects for the collectible here
  }
}