import 'dart:math';

import 'package:flutter/material.dart';

class Sector {
  final Color color;
  final double value;
  final String title;

  Sector({required this.color, required this.value, required this.title});
}

List<double> get randomNumbers {
  final Random random = Random();
  final randomNumbers = <double>[];
  for (var i = 1; i <= 4; i++) {
    randomNumbers.add(random.nextDouble() * 100);
  }

  return randomNumbers;
}

List<Sector> get industrySectors {
  return [
    Sector(
      color: Colors.redAccent,
      value: randomNumbers[0],
      title: 'Ремонт',
    ),
    Sector(
      color: Colors.blueGrey,
      value: randomNumbers[1],
      title: 'Бензин',
    ),
    Sector(
        color: Colors.deepPurpleAccent,
        value: randomNumbers[2],
        title: 'Обслуживание'),
    Sector(
      color: Colors.yellow,
      value: randomNumbers[3],
      title: 'Штрафы',
    ),
  ];
}
