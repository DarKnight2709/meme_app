import 'package:flutter/material.dart';
import 'package:meme_app/providers/cart_counter_provider.dart';
import 'package:meme_app/providers/meme_cart_provider.dart';
import 'package:meme_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';


void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MemeCartProvider()),
        ChangeNotifierProvider(create: (_) => CartCounterProvider())
      ],
      child: const MaterialApp(
        
        debugShowCheckedModeBanner: false,
        
        home: SplashScreen()
      ),
    );
  }
}