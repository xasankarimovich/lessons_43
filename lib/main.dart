import 'package:flutter/material.dart';
import 'package:homework_43/utils/styles.dart';
import 'package:homework_43/views/widgets/pin_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void toggleThemeMode(bool value) {
    AppConstants.themeMode = value ? ThemeMode.dark : ThemeMode.light;
    setState(() {});
  }

  void onBackgroundChanged(String imageUrl) {
    AppConstants.imageUrl = imageUrl;
    setState(() {});
  }

  void onLanguageChanged(String language) {
    AppConstants.language = language;
    setState(() {});
  }

  void onColorChanged(Color color) {
    AppConstants.appColor = color;
    setState(() {});
  }

  void onTextChanged(Color color, double size) {
    AppConstants.textSize = size;
    AppConstants.textColor = color;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: AppConstants.appColor,
        ),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: AppConstants.themeMode,
      home: Onboarding(
        onThemeChanged: toggleThemeMode,
        onBackgroundChanged: onBackgroundChanged,
        onLanguageChanged: onLanguageChanged,
        onColorChanged: onColorChanged,
        onTextChanged: onTextChanged,
      ),
    );
  }
}