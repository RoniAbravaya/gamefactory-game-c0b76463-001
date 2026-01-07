import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';

/// A component representing an obstacle in a platformer game.
/// It includes collision detection, visual representation, and damage dealing capabilities.
class Obstacle extends PositionComponent with HasHitboxes, Collidable {
  final Vector2 _size;
  final Vector2 _position;
  final String _spritePath;
  late SpriteComponent _spriteComponent;

  /// Creates a new obstacle.
  /// [size] specifies the size of the obstacle.
  /// [position] specifies the initial position of the obstacle.
  /// [spritePath] is the path to the sprite image. If null, the obstacle will be rendered as a rectangle.
  Obstacle({
    required Vector2 size,
    required Vector2 position,
    String? spritePath,
  })  : _size = size,
        _position = position,
        _spritePath = spritePath ?? '' {
    addHitbox(HitboxRectangle(relation: _size));
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = _size;
    position = _position;
    if (_spritePath.isNotEmpty) {
      _spriteComponent = SpriteComponent.fromImage(await Flame.images.load(_spritePath), size: _size);
      add(_spriteComponent);
    } else {
      // If no sprite path provided, render a simple colored rectangle.
      _spriteComponent = RectangleComponent(size: _size, paint: Paint()..color = const Color(0xFFA8D8EA));
      add(_spriteComponent);
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    // Implement damage dealing or other effects on collision here.
  }

  /// Moves the obstacle to a new position.
  /// This can be used for moving or spawning the obstacle in different locations.
  void moveTo(Vector2 newPosition) {
    position = newPosition;
  }

  /// Updates the obstacle's appearance. Can be used to change the obstacle's sprite or color.
  /// If [newSpritePath] is null, the obstacle will remain unchanged.
  Future<void> updateAppearance({String? newSpritePath}) async {
    if (newSpritePath != null && newSpritePath.isNotEmpty && newSpritePath != _spritePath) {
      _spriteComponent.sprite = await Sprite.load(newSpritePath);
      _spriteComponent.size = _size;
    }
  }
}