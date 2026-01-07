import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/palette.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

/// Represents the main menu scene in a platformer game.
/// It displays the game title, play button, level select option, and settings button.
class MenuScene extends Component with HasGameRef, TapDetector {
  late TextComponent title;
  late TextComponent playButton;
  late TextComponent levelSelectButton;
  late TextComponent settingsButton;
  late RectComponent background;

  @override
  Future<void>? onLoad() async {
    super.onLoad();
    _createBackground();
    _createTitle();
    _createPlayButton();
    _createLevelSelectButton();
    _createSettingsButton();
  }

  void _createBackground() {
    background = RectComponent(
      position: Vector2.zero(),
      size: gameRef.size,
      paint: Paint()..color = Colors.lightBlueAccent,
    );
    add(background);
  }

  void _createTitle() {
    title = TextComponent(
      text: 'Test Claude Fix-platformer-01',
      position: Vector2(gameRef.size.x / 2, gameRef.size.y / 4),
      anchor: Anchor.center,
      textRenderer: TextPaint(style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
    );
    add(title);
  }

  void _createPlayButton() {
    playButton = TextComponent(
      text: 'Play',
      position: Vector2(gameRef.size.x / 2, gameRef.size.y / 2),
      anchor: Anchor.center,
      textRenderer: TextPaint(style: TextStyle(fontSize: 20, color: Colors.white)),
    );
    playButton.add(RectangleHitbox()..onTap = () => _onPlayButtonPressed());
    add(playButton);
  }

  void _createLevelSelectButton() {
    levelSelectButton = TextComponent(
      text: 'Select Level',
      position: Vector2(gameRef.size.x / 2, (gameRef.size.y / 2) + 50),
      anchor: Anchor.center,
      textRenderer: TextPaint(style: TextStyle(fontSize: 20, color: Colors.white)),
    );
    levelSelectButton.add(RectangleHitbox()..onTap = () => _onLevelSelectButtonPressed());
    add(levelSelectButton);
  }

  void _createSettingsButton() {
    settingsButton = TextComponent(
      text: 'Settings',
      position: Vector2(gameRef.size.x / 2, (gameRef.size.y / 2) + 100),
      anchor: Anchor.center,
      textRenderer: TextPaint(style: TextStyle(fontSize: 20, color: Colors.white)),
    );
    settingsButton.add(RectangleHitbox()..onTap = () => _onSettingsButtonPressed());
    add(settingsButton);
  }

  void _onPlayButtonPressed() {
    // Implement navigation to the game play scene
    print('Play button pressed');
  }

  void _onLevelSelectButtonPressed() {
    // Implement navigation to the level select scene
    print('Level select button pressed');
  }

  void _onSettingsButtonPressed() {
    // Implement navigation to the settings scene
    print('Settings button pressed');
  }
}