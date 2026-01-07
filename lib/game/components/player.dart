import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';

/// Represents the player character in a platformer game.
class Player extends SpriteAnimationComponent with HasGameRef, Hitbox, Collidable {
  final double speed = 200;
  bool isJumping = false;
  bool isInvulnerable = false;
  int health = 3;
  final double jumpStrength = 300;
  final double gravity = 1000;
  double ySpeed = 0;

  Player(Vector2 position)
      : super(position: position, size: Vector2(50, 75), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final spriteSheet = SpriteSheet(
      image: await gameRef.images.load('player_spritesheet.png'),
      srcSize: Vector2(50, 75),
    );
    animation = spriteSheet.createAnimation(row: 0, stepTime: 0.1, to: 4);
    addShape(HitboxRectangle());
  }

  @override
  void update(double dt) {
    super.update(dt);
    handleMovement(dt);
    handleGravity(dt);
    checkInvulnerability(dt);
  }

  void handleMovement(double dt) {
    if (isJumping) {
      ySpeed -= jumpStrength;
      isJumping = false;
    }
    position.add(Vector2(0, ySpeed * dt));
    ySpeed += gravity * dt;
  }

  void handleGravity(double dt) {
    if (position.y > gameRef.size.y - size.y / 2) {
      position.y = gameRef.size.y - size.y / 2;
      ySpeed = 0;
    }
  }

  void jump() {
    if (!isJumping && position.y >= gameRef.size.y - size.y / 2) {
      isJumping = true;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is Obstacle && !isInvulnerable) {
      takeDamage();
    } else if (other is Collectible) {
      collectItem(other);
    }
  }

  void takeDamage() {
    if (!isInvulnerable) {
      health -= 1;
      isInvulnerable = true;
      if (health <= 0) {
        // Handle player death
      }
    }
  }

  void collectItem(Collectible item) {
    // Handle item collection
  }

  void checkInvulnerability(double dt) {
    if (isInvulnerable) {
      // Handle invulnerability timer
    }
  }

  void makeVulnerable() {
    isInvulnerable = false;
  }
}

/// Represents an obstacle in the game.
class Obstacle extends SpriteComponent with Collidable {
  Obstacle(Vector2 position, Vector2 size)
      : super(position: position, size: size);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    addShape(HitboxRectangle());
  }
}

/// Represents a collectible item in the game.
class Collectible extends SpriteComponent with Collidable {
  Collectible(Vector2 position, Vector2 size)
      : super(position: position, size: size);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    addShape(HitboxCircle());
  }
}