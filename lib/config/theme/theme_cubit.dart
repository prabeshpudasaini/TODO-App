import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final Box settingsBox;

  ThemeCubit(this.settingsBox) : super(_getSavedTheme(settingsBox));

  static ThemeMode _getSavedTheme(Box box) {
    return box.get('themeMode', defaultValue: ThemeMode.system);
  }

  void toggleTheme() {
    final newMode = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(newMode);
    settingsBox.put('themeMode', newMode);
  }
}
