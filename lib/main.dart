import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodie/ui/dashboard.dart';
import 'package:foodie/ui/login.dart';
import 'package:foodie/ui/splash_screen.dart';
import 'package:foodie/utils/app_colors.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: Color(0xff02537e),
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff02537e)),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
        routes: {
          '/login': (BuildContext context) => const LoginScreen(),
          '/dashboard': (BuildContext context) => const DashboardScreen(),
        });
  }
}
