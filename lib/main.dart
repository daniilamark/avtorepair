import 'package:avtorepair/config/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:avtorepair/styles/app_colors.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Urbanist',
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        brightness: Brightness.dark,
      ),
      initialRoute: AppRoutes.main,
      //initialRoute: AppRoutes.routingPage,
      //initialRoute: AppRoutes.mapPage,
      //initialRoute: AppRoutes.login,
      routes: AppRoutes.pages,
    );
  }
}
