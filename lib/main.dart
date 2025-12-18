import 'package:currency_converter/views/exchange_rate_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/exchange_rate_controller.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ExchangeRateController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.dark,
      ),
      home: const ExchangeRatePage(),
    );
  }
}
