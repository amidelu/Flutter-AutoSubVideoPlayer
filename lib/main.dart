import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:sub_video_player/dashboard.dart';

void main() {
  runApp(const MyApp());
}

const _brandColor = Color(0xFF44CD8D);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;
        if (lightDynamic != null && darkDynamic != null) {
          lightColorScheme = lightDynamic.harmonized();
          darkColorScheme = darkDynamic.harmonized();
        } else {
          lightColorScheme = ColorScheme.fromSeed(seedColor: _brandColor);
          darkColorScheme = ColorScheme.fromSeed(
              seedColor: _brandColor, brightness: Brightness.dark);
        }
        return MaterialApp(
          title: 'Auto Sub Player',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightColorScheme,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkColorScheme,
          ),
          home: const Dashboard(),
        );
      },
    );
  }
}
