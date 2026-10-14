import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_providers.dart';
import 'providers/theme_providers.dart';
import 'screens/catalog_screen.dart';

void main() {
  runApp(
    // MultiProvider mendaftarkan semua provider yang akan digunakan secara global
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProviders()),
        ChangeNotifierProvider(create: (_) => ThemeProviders()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toko Buku Sandi',
      debugShowCheckedModeBanner: false,
      // Mengambil status tema (Light / Dark) secara dinamis dari ThemeProvider
      themeMode: context.watch<ThemeProviders>().themeMode,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.pink,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.blue,
      ),
      home: CatalogScreen(),
    );
  }
}