import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/tv_shows_provider.dart';
import 'screens/popular_shows_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TVShowsProvider()),
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
      title: 'TV Shows App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PopularShowsScreen(),
    );
  }
}
