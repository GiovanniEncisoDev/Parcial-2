import 'package:ejemplo1/juego/components/character.dart';

class Player extends Character {
  Player({
    required super.position,
    required super.radius,
    super.color,
  });
}