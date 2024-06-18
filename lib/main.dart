// import 'package:avtorepair/config/app_routes.dart';
// import 'package:avtorepair/pages/admin/admin_page.dart';
import 'package:avtorepair/pages/auth/login_page.dart';
// import 'package:avtorepair/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:avtorepair/styles/app_colors.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initializeDateFormatting().then((_) => runApp(MyApp(
        token: prefs.getString('token'),
      )));
}

class MyApp extends StatelessWidget {
  final token;
  //  Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(token);
  // userId = jwtDecodedToken['_id'];
  // email = jwtDecodedToken['email'].toString();

  // JwtDecoder.decode(token)['_id'];

  const MyApp({
    @required this.token,
    Key? key,
  }) : super(key: key);

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
      // initialRoute: AppRoutes.main,
      //initialRoute: AppRoutes.routingPage,
      //initialRoute: AppRoutes.mapPage,
      // initialRoute: AppRoutes.login,
      // routes: AppRoutes.pages,
      home: (token != null && JwtDecoder.isExpired(token) == false)
          // ? MainPage(token: token)
          ? LoginPage()
          : const LoginPage(),

      // home: Center(child: Text(JwtDecoder.decode(token)['role'].toString()))
      // home: const AdminPage(),
    );
  }
}
