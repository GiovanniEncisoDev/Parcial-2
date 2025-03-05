import 'package:flutter/painting.dart';

extension ColorExtension on Color {

  /// Makes color darker by a defined percent
  Color oscurecer(double porcentaje) {
    final amount = porcentaje / 100;
    final hsl = HSLColor.fromColor(this);
    final darkenedHsl = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return darkenedHsl.toColor();
  }

  /// Makes color lighter by a defined percent
  Color aclarar(double porcentaje) {
    final amount = porcentaje / 100;
    final hsl = HSLColor.fromColor(this);
    final lightenedHsl = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return lightenedHsl.toColor();
  }

  ///Read color based on background luminance, use it from background color to get its better readability color.
  Color get readColor => (computeLuminance() > 0.5) ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 255, 255, 255);

  List<Color> get baseGradientPallet => [aclarar(10), this, oscurecer(10)];
  List<Color> get lightGradientPallet => [aclarar(20), aclarar(10), this];
  List<Color> get darkGradientPallet => [this, oscurecer(5), oscurecer(10)];
}