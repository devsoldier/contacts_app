import 'package:flutter/material.dart';

const primaryColor = Color(0xFF32BAA5);
const kColorsurfaceCanvas = Colors.white;
const Color kColorBodyText = Colors.black;
const Color kColorDisplayText = Color(0xFF272928);

const kPrimaryFont = 'Barlow';
const kSecondaryFont = 'Gilroy';

const double kChildPadding = 14;
const double kCanvasPadding = 25;

ThemeData get kAppLightTheme {
  ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: primaryColor,
    colorScheme: buildColorScheme(base.colorScheme),
    disabledColor: Colors.black,
    scaffoldBackgroundColor: kColorsurfaceCanvas,
    appBarTheme: const AppBarTheme(
      color: Color(0xFF32BAA5),
    ),
    textTheme: buildTextTheme(base.textTheme),
    primaryTextTheme: buildTextTheme(base.primaryTextTheme),
    inputDecorationTheme: buildInputDecorationTheme(
      base.inputDecorationTheme,
      buildTextTheme(base.textTheme),
    ),
    elevatedButtonTheme: buildElevatedButtonTheme(),
  );
}

ColorScheme buildColorScheme(ColorScheme colorScheme) {
  return colorScheme.copyWith(
    error: Colors.red,
    primary: primaryColor,
    secondary: primaryColor,
  );
}

TextTheme buildTextTheme(TextTheme base) {
  return base
      .copyWith(
        displayLarge: base.displayLarge?.copyWith(
          fontWeight: FontWeight.w600,
          fontFamily: kPrimaryFont,
        ),
        displayMedium: base.displayMedium?.copyWith(
          fontWeight: FontWeight.w600,
          fontFamily: kPrimaryFont,
        ),
        displaySmall: base.displaySmall?.copyWith(
          fontWeight: FontWeight.w600,
          fontFamily: kPrimaryFont,
        ),
        headlineLarge: base.headlineLarge?.copyWith(
          fontWeight: FontWeight.w600,
          fontFamily: kPrimaryFont,
        ),
        headlineMedium: base.headlineMedium?.copyWith(
          fontWeight: FontWeight.w600,
          fontFamily: kPrimaryFont,
        ),
        headlineSmall: base.headlineSmall?.copyWith(
          fontWeight: FontWeight.w600,
          fontFamily: kPrimaryFont,
        ),
        titleLarge: base.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
          fontFamily: kSecondaryFont,
        ),
        titleMedium: base.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          fontFamily: kSecondaryFont,
        ),
        titleSmall: base.titleSmall?.copyWith(
          fontFamily: kSecondaryFont,
        ),
        bodyLarge: base.bodyLarge?.copyWith(
          fontFamily: kPrimaryFont,
        ),
        bodyMedium: base.bodyMedium?.copyWith(
          fontFamily: kPrimaryFont,
        ),
        bodySmall: base.bodySmall?.copyWith(
          fontFamily: kPrimaryFont,
        ),
        labelLarge: base.labelLarge?.copyWith(
          fontWeight: FontWeight.w700,
          fontFamily: kPrimaryFont,
        ),
        labelMedium: base.labelMedium?.copyWith(
          fontFamily: kPrimaryFont,
        ),
        labelSmall: base.labelSmall?.copyWith(
          fontWeight: FontWeight.w600,
          fontFamily: kPrimaryFont,
        ),
      )
      .apply(
        bodyColor: kColorBodyText,
        displayColor: kColorDisplayText,
      );
}

InputDecorationTheme buildInputDecorationTheme(
  InputDecorationTheme base,
  TextTheme baseTextTheme,
) {
  const borderSide = BorderSide(
    color: Colors.black38,
  );
  final inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: const BorderSide(
      color: Colors.white,
    ),
  );
  return base.copyWith(
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    border: inputBorder,
    hintStyle: const TextStyle(color: Colors.black38),
    enabledBorder: inputBorder,
    disabledBorder: inputBorder.copyWith(
      borderSide: borderSide.copyWith(color: Colors.white),
    ),
    errorBorder: inputBorder.copyWith(
      borderSide: borderSide.copyWith(
        color: Colors.red,
      ),
    ),
    focusedBorder: inputBorder.copyWith(
      borderSide: borderSide.copyWith(
        color: primaryColor,
      ),
    ),
    isDense: true,
    filled: true,
    fillColor: Colors.white,
    labelStyle: baseTextTheme.bodyMedium?.copyWith(fontSize: 13),
  );
}

buildElevatedButtonTheme() {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      minimumSize: Size(200, 44),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
  );
}
