import 'package:flutter/material.dart';
import 'package:avtorepair/components/toolbar.dart';
import 'package:avtorepair/config/app_strings.dart';

class RefuelingPage extends StatelessWidget {
  const RefuelingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: Toolbar(
        title: AppStrings.refueling,
      ),
      body: Center(
          child: Text(
        "reffffuliing",
        style: TextStyle(fontSize: 30),
      )),
    );
  }
}
