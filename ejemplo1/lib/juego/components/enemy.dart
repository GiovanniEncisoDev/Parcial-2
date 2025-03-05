import 'package:ejemplo1/juego/components/character.dart';

class Enemy extends Character {
  Enemy({
    required super.position,
    required super.radius,
    super.color,
  });
}