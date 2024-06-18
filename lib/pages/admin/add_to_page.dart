// import 'dart:convert';

// import 'package:avtorepair/config/api_config.dart';
// import 'package:avtorepair/pages/auth/registration_page.dart';
// import 'package:avtorepair/pages/main_page.dart';

import 'package:avtorepair/components/toolbar.dart';
import 'package:flutter/material.dart';
// import 'package:avtorepair/config/app_routes.dart';

// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

class AddToPage extends StatefulWidget {
  const AddToPage({super.key});

  @override
  State<AddToPage> createState() => _AddToPageState();
}

class _AddToPageState extends State<AddToPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Toolbar(
        title: 'Техобслуживание',
        actions: [
          IconButton(
            icon: const Icon(Icons.post_add,
                color: Color.fromARGB(255, 255, 255, 255)),
            onPressed: () => {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Center(
                  child: Text(
                    'Техобслуживание',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 46,
                ),
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
