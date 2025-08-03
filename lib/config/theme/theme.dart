import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myapp/config/theme/color_scheme.dart';
import 'package:myapp/config/theme/text_theme.dart';


/// The [AppTheme] defines light and dark themes for the app.
///
/// Use it in a [MaterialApp] like this:
///
/// MaterialApp(
///   theme: AppTheme.light,
///   darkTheme: AppTheme.dark,
/// );
/// 
sealed class AppTheme {
  // The defined light theme.
  static ThemeData light = FlexThemeData.light(
    colorScheme: lightColorScheme,
    textTheme: lightTextTheme,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
    ),
    keyColors: const FlexKeyColors(
      useSecondary: true,
      keepPrimary: true,
      keepSecondary: true,
      keepTertiary: true,
      keepPrimaryContainer: true,
      keepSecondaryContainer: true,
    ),
    appBarElevation: 0.5,
    typography: Typography.material2021(platform: defaultTargetPlatform),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(
      applyThemeToAll: true,
    ), // Dark text/icons on surface
  );
  // The defined dark theme.
  static ThemeData dark = FlexThemeData.dark(
    colorScheme: darkColorScheme,
    textTheme: darkTextTheme,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnColors: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
    ),
    keyColors: const FlexKeyColors(
      useSecondary: true,
      keepPrimary: true,
      keepSecondary: true,
      keepTertiary: true,
      keepPrimaryContainer: true,
      keepSecondaryContainer: true,
    ),
    appBarElevation: 2,
    typography: Typography.material2021(platform: defaultTargetPlatform),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );
}
