import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

const darkpink = Color(0xFFD44F4E);


CustomColors lightCustomColors = const CustomColors(
  sourceDarkpink: Color(0xFFD44F4E),
  darkpink: Color(0xFFAC3234),
  onDarkpink: Color(0xFFFFFFFF),
  darkpinkContainer: Color(0xFFFFDAD7),
  onDarkpinkContainer: Color(0xFF410005),
);

CustomColors darkCustomColors = const CustomColors(
  sourceDarkpink: Color(0xFFD44F4E),
  darkpink: Color(0xFFFFB3AF),
  onDarkpink: Color(0xFF68000D),
  darkpinkContainer: Color(0xFF8B181F),
  onDarkpinkContainer: Color(0xFFFFDAD7),
);



/// Defines a set of custom colors, each comprised of 4 complementary tones.
///
/// See also:
///   * <https://m3.material.io/styles/color/the-color-system/custom-colors>
@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.sourceDarkpink,
    required this.darkpink,
    required this.onDarkpink,
    required this.darkpinkContainer,
    required this.onDarkpinkContainer,
  });

  final Color? sourceDarkpink;
  final Color? darkpink;
  final Color? onDarkpink;
  final Color? darkpinkContainer;
  final Color? onDarkpinkContainer;

  @override
  CustomColors copyWith({
    Color? sourceDarkpink,
    Color? darkpink,
    Color? onDarkpink,
    Color? darkpinkContainer,
    Color? onDarkpinkContainer,
  }) {
    return CustomColors(
      sourceDarkpink: sourceDarkpink ?? this.sourceDarkpink,
      darkpink: darkpink ?? this.darkpink,
      onDarkpink: onDarkpink ?? this.onDarkpink,
      darkpinkContainer: darkpinkContainer ?? this.darkpinkContainer,
      onDarkpinkContainer: onDarkpinkContainer ?? this.onDarkpinkContainer,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      sourceDarkpink: Color.lerp(sourceDarkpink, other.sourceDarkpink, t),
      darkpink: Color.lerp(darkpink, other.darkpink, t),
      onDarkpink: Color.lerp(onDarkpink, other.onDarkpink, t),
      darkpinkContainer: Color.lerp(darkpinkContainer, other.darkpinkContainer, t),
      onDarkpinkContainer: Color.lerp(onDarkpinkContainer, other.onDarkpinkContainer, t),
    );
  }

  /// Returns an instance of [CustomColors] in which the following custom
  /// colors are harmonized with [dynamic]'s [ColorScheme.primary].
  ///   * [CustomColors.sourceDarkpink]
  ///   * [CustomColors.darkpink]
  ///   * [CustomColors.onDarkpink]
  ///   * [CustomColors.darkpinkContainer]
  ///   * [CustomColors.onDarkpinkContainer]
  ///
  /// See also:
  ///   * <https://m3.material.io/styles/color/the-color-system/custom-colors#harmonization>
  CustomColors harmonized(ColorScheme dynamic) {
    return copyWith(
      sourceDarkpink: sourceDarkpink!.harmonizeWith(dynamic.primary),
      darkpink: darkpink!.harmonizeWith(dynamic.primary),
      onDarkpink: onDarkpink!.harmonizeWith(dynamic.primary),
      darkpinkContainer: darkpinkContainer!.harmonizeWith(dynamic.primary),
      onDarkpinkContainer: onDarkpinkContainer!.harmonizeWith(dynamic.primary),
    );
  }
}