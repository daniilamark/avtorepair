// import 'dart:convert';

// import 'package:avtorepair/config/api_config.dart';
// import 'package:avtorepair/pages/auth/registration_page.dart';
// import 'package:avtorepair/pages/main_page.dart';

import 'package:avtorepair/components/toolbar.dart';
import 'package:avtorepair/pages/admin/add_model_page.dart';
import 'package:avtorepair/pages/admin/add_service_page.dart';
import 'package:avtorepair/pages/admin/add_to_page.dart';
import 'package:avtorepair/pages/auth/login_page.dart';
import 'package:flutter/material.dart';
// import 'package:avtorepair/config/app_routes.dart';
import 'package:avtorepair/config/app_strings.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

class AdminPage extends StatefulWidget {
  final token;
  // const AdminPage({super.key});

  const AdminPage({@required this.token, Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  late String email;
  late SharedPreferences prefsMain;

  // TextEditingController emailController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();

  // bool _isNotValidate = false;
  // late SharedPreferences prefs;

  // @override
  // void initState() {
  //   super.initState();
  //   initSharedPref();

  //   emailController.text = "admin1@admin.com";
  //   passwordController.text = "admin1";
  //   // emailText = emailController.text;
  // }

  // void initSharedPref() async {
  //   prefs = await SharedPreferences.getInstance();
  // }

  @override
  void initState() {
    super.initState();

    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    // userId = jwtDecodedToken['_id'];
    email = jwtDecodedToken['email'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Toolbar(
        title: AppStrings.panelAdmin,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app_outlined,
                color: Color.fromARGB(255, 255, 255, 255)),
            onPressed: () => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()))
            },
          ),
          // IconButton(
          //   icon: const Icon(Icons.post_add,
          //       color: Color.fromARGB(255, 255, 255, 255)),
          //   onPressed: () => {},
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Center(
                  child: Text(
                    email,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 46,
                ),
                ElevatedButton(
                    child: const Text(
                      'Модели',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddModelPage()));
                    }),
                const SizedBox(
                  height: 6,
                ),
                ElevatedButton(
                  child: const Text(
                    'Техобслуживание',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddServicePage()));
                  },
                ),
                const SizedBox(
                  height: 6,
                ),
                // ElevatedButton(
                //   child: const Text(
                //     'Техобслуживание',
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 18,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                //   onPressed: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => const AddToPage()));
                //   },
                // ),
                const SizedBox(
                  height: 16,
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
