import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class ThemeProvider with ChangeNotifier {
  bool isLightTheme;

  ThemeProvider({
    this.isLightTheme,
  });

  getCurrentStatusNavigationBarColor() {
    if (isLightTheme) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Color(0xFFFFFFFF),
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      );
    } else {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Color(0xFF26242E),
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      );
    }
  }

  toogleThemeData() async {
    final settings = await Hive.openBox('setting');
    settings.put('isLightTheme', !isLightTheme);
    isLightTheme = !isLightTheme;
    getCurrentStatusNavigationBarColor();
    notifyListeners();
  }

  ThemeData themeData() {
    return ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primarySwatch: isLightTheme ? Colors.grey : Colors.grey,
      primaryColor: isLightTheme ? Colors.white : Color(0xFF1E1F28),
      brightness: isLightTheme ? Brightness.light : Brightness.dark,
      backgroundColor: isLightTheme ? Color(0xFFFFFFFF) : Color(0xFF26242E),
      scaffoldBackgroundColor:
          isLightTheme ? Color(0xFFFFFFFF) : Color(0xFF26242E),
    );
  }

  ThemeColor themeMode() {
    return ThemeColor(
      gradient: [
        if (isLightTheme) ...[Color(0xDDFF0080), Color(0xDDFF8C00)],
        if (!isLightTheme) ...[Color(0xFF8983F7), Color(0xFFA3DAFB)]
      ],
      textColor: isLightTheme ? Color(0xFF000000) : Color(0xFFFFFFFF),
      toggleButtonColor: isLightTheme ? Color(0xFFFFFFFF) : Color(0xFFFF34323D),
      toggleBackgroundColor:
          isLightTheme ? Color(0xFFE7E7E8) : Color(0xFF222029),
      shadow: [
        if (isLightTheme)
          BoxShadow(
            color: Color(0xFFD8D7DA),
            spreadRadius: 5,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        if (!isLightTheme)
          BoxShadow(
            color: Color(0x66000000),
            spreadRadius: 5,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
      ],
    );
  }
}

class ThemeColor {
  List<Color> gradient;
  Color backgroundColor;
  Color toggleButtonColor;
  Color toggleBackgroundColor;
  Color textColor;
  List<BoxShadow> shadow;

  ThemeColor({
    this.gradient,
    this.backgroundColor,
    this.toggleButtonColor,
    this.toggleBackgroundColor,
    this.textColor,
    this.shadow,
  });
}
