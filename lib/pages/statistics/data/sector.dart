import 'dart:math';

import 'package:avtorepair/config/db_helper.dart';
import 'package:avtorepair/services/local_db/local_refueling.dart';
import 'package:flutter/material.dart';

class Sector {
  final Color color;
  final double value;
  final String title;

  Sector({required this.color, required this.value, required this.title});
}

double? _dataRefueling;
double? _dataSevice;

void _refreshData() async {
  double dataRefueling = await LocalRefueling.getSummaRefueling();
  double dataSevice = await SQLHelper.getSummaSevice();
  _dataRefueling = dataRefueling;
  _dataSevice = dataSevice;
  // print(data);
}

List<double> get randomNumbers {
  _refreshData();
  // final Random random = Random();
  final randomNumbers = <double>[_dataSevice!, _dataRefueling!];

  // for (var i = 1; i <= 2; i++) {
  //   randomNumbers.add(random.nextDouble() * 100);
  // }

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
    // Sector(
    //     color: Colors.deepPurpleAccent,
    //     value: randomNumbers[2],
    //     title: 'Обслуживание'),
    // Sector(
    //   color: Colors.yellow,
    //   value: randomNumbers[3],
    //   title: 'Штрафы',
    // ),
  ];
}
