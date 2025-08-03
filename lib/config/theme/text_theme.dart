import 'package:flutter/material.dart';

TextTheme lightTextTheme = const TextTheme(
  displayLarge: TextStyle(
    fontSize: 57,
    fontWeight: FontWeight.bold,
    color: Color(0xFF1C1B1F), // Dark text for headings
    letterSpacing: -0.25,
  ),
  displayMedium: TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.bold,
    color: Color(0xFF1C1B1F),
    letterSpacing: -0.15,
  ),
  displaySmall: TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w600,
    color: Color(0xFF1C1B1F),
  ),
  headlineMedium: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: Color(0xFF1C1B1F),
  ),
  headlineSmall: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: Color(0xFF1C1B1F),
  ),
  titleLarge: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: Color(0xFF006A60), // Primary color for titles
  ),
  titleMedium: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Color(0xFF37474F), // Muted dark gray
  ),
  titleSmall: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Color(0xFF4A4A4A),
  ),
  bodyLarge: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Color(0xFF1C1B1F), // Standard body text
  ),
  bodyMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Color(0xFF4A4A4A), // Slightly muted gray for secondary text
  ),
  labelLarge: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Color(0xFFFFFFFF), // White for buttons/labels
  ),
  labelMedium: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Color(0xFF006A60), // Primary for smaller labels
  ),
  labelSmall: TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: Color(0xFF4C9AFF), // Secondary color for small details
  ),
);

TextTheme darkTextTheme = const TextTheme(
  displayLarge: TextStyle(
    fontSize: 57,
    fontWeight: FontWeight.bold,
    color: Color(0xFFE1E1E1), // Light text for headings
    letterSpacing: -0.25,
  ),
  displayMedium: TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.bold,
    color: Color(0xFFE1E1E1),
    letterSpacing: -0.15,
  ),
  displaySmall: TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w600,
    color: Color(0xFFE1E1E1),
  ),
  headlineMedium: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: Color(0xFFE1E1E1),
  ),
  headlineSmall: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: Color(0xFFE1E1E1),
  ),
  titleLarge: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: Color(0xFF4DB6AC), // Light Primary for titles
  ),
  titleMedium: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Color(0xFF8E8E93), // Muted light gray
  ),
  titleSmall: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Color(0xFF8E8E93),
  ),
  bodyLarge: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Color(0xFFE1E1E1), // Standard body text
  ),
  bodyMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Color(0xFFBDBDBD), // Muted light gray for secondary text
  ),
  labelLarge: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Color(0xFF1E1E1E), // Dark for buttons/labels
  ),
  labelMedium: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Color(0xFF4DB6AC), // Primary for smaller labels
  ),
  labelSmall: TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: Color(0xFF82CFFF), // Secondary for small details
  ),
);
