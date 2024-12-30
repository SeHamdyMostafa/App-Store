import 'package:appstore/Screens/Home_Page/Bottom/BottomNavBar.dart';
import 'package:appstore/helper/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      home: BottomNavBarWithCenterButton(),  
      routes: { 
        '/home': (context) => BottomNavBarWithCenterButton(),
      },
    );
  }
}
