import 'dart:convert';

import 'package:avtorepair/config/api_config.dart';
import 'package:avtorepair/pages/admin/admin_page.dart';
import 'package:avtorepair/pages/auth/registration_page.dart';
import 'package:avtorepair/pages/main_page.dart';

import 'package:flutter/material.dart';
// import 'package:avtorepair/config/app_routes.dart';
import 'package:avtorepair/config/app_strings.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isNotValidate = false;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPref();

    emailController.text = "admin1@admin.com";
    passwordController.text = "admin1";
    // emailText = emailController.text;
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void loginUser() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      print('логинимся');

      var reqBody = {
        "email": emailController.text,
        "password": passwordController.text
      };
      var response = await http.post(Uri.parse(login),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqBody));

      var jsonResponse = jsonDecode(response.body);
      print(response);
      if (jsonResponse['status']) {
        var myToken = jsonResponse['token'];
        prefs.setString('token', myToken);
        // print('tyt');

        if (JwtDecoder.decode(myToken)['role'].toString() == 'admin') {
          // print(JwtDecoder.decode(myToken)['role'].toString());
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => AdminPage(token: myToken)));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => MainPage(token: myToken)));
        }

        // Navigator.pushReplacement(context,
        //     MaterialPageRoute(builder: (context) => MainPage(token: myToken)));

        // Navigator.of(context).pushNamedAndRemoveUntil(
        //   AppRoutes.main,
        //   (Route<dynamic> route) => false,
        //   arguments: {
        //     emailController.text,
        //   },
        // );
        // );

        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => CarProfilePage(emailController.text)));

        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => Dashboard(token: myToken)));
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(
        //     content: Text(
        //       'Ошибка в логине или пароле',
        //     ),
        //   ),
        // );
        print('Something went wrong');
      }
    } else {
      setState(() {
        _isNotValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Spacer(),
                const Text(
                  AppStrings.helloWelcome,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  AppStrings.loginToContinue,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: AppStrings.usermail,
                    errorText:
                        _isNotValidate ? "Введите правильный e-mail!" : null,
                    labelText: "e-mail",
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.5),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: AppStrings.userpassword,
                    labelText: "Пароль",
                    errorText: _isNotValidate ? "Введите пароль" : null,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.5),
                  ),
                ),
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: TextButton(
                //     onPressed: () {
                //       print("Forgot clicked");
                //     },
                //     style: TextButton.styleFrom(
                //       foregroundColor: Colors.white,
                //     ),
                //     child: const Text(AppStrings.forgotPassword),
                //   ),
                // ),
                const SizedBox(
                  height: 32,
                ),
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      loginUser();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Image.asset(
                        //   AppIcons.icGoogle,
                        //   width: 22,
                        //   height: 22,
                        // ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(AppStrings.login),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Text(
                      AppStrings.dontHaveAccount,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigator.of(context)
                        //     .pushReplacementNamed(AppRoutes.registration);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegistrationPage()));
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.amber,
                      ),
                      child: const Text(
                        AppStrings.signup,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class AppRoutes {
//   // final _LoginPageState aw = _LoginPageState();

//   final pages = {
//     login: (context) => const LoginPage(),
//     registration: (context) => const RegistrationPage(),
//     //home: (context) => HomePage(),
//     main: (context) => MainPage(_LoginPageState.getEmail()),
//     editProfile: (context) => const EditProfilePage(),
//     routingPage: (context) => const RoutingPage(),
//     mapPage: (context) => const MapPage(),
//     //mapPage: (context) => const MapPage(),

//     garagePage: (context) => const GaragePage(),
//     settingsPage: (context) => const DocPage(),
//     calendarPage: (context) => TableBasicsExample(),
//   };

//   static const login = '/';
//   static const registration = '/registration';
//   //static const home = '/home';
//   static const main = '/main';
//   static const editProfile = '/edit_profile';
//   static const routingPage = '/routingPage';
//   static const mapPage = '/mapPage';

//   static const garagePage = '/garage';
//   static const settingsPage = '/settings';

//   static const calendarPage = '/calendar';
// }
