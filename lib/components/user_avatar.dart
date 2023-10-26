// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final double size;

  const UserAvatar({super.key, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Image.asset(
            'assets/temp/user1.jpg',
            width: size,
            height: size,
          ),
        ),
        SizedBox(
          width: 24,
        ),
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Image.asset(
            'assets/temp/car.jpg',
            width: size,
            height: size,
          ),
        ),
      ],
    );
  }
}
