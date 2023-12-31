import 'package:flutter/material.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';
import './config.dart';
import './theme_mode_manager.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeModeHandler(
      manager: ExampleThemeModeManager(),
      placeholderWidget: const Center(
        child: CircularProgressIndicator(),
      ),
      builder: (ThemeMode themeMode) {
        return MaterialApp(
          themeMode: themeMode,
          darkTheme: ThemeData(
            brightness: Brightness.dark,
          ),
          theme: ThemeData(
            brightness: Brightness.light,
          ),
          home: const HomePage(),
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final themeMode = ThemeModeHandler.of(context)?.themeMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text(MyConfig.appBarrTitle),
        actions: [
          IconButton(
            icon: Icon(themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              setState(() {
                ThemeModeHandler.of(context)?.saveThemeMode(
                    themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
              });
            },
          ),
        ],
      ),
      body: MyConfig.appWidget,
    );
  }
}
