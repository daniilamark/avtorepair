// import 'dart:math';
import 'package:collection/collection.dart';

class PricePoint {
  final double x;
  final double y;

  PricePoint({required this.x, required this.y});
}

List<PricePoint> get pricePoints {
  // final Random random = Random();
  final randomNumbers = <double>[155, 2, 34, 4, 53, 6, 7, 8, 93, 10, 11];

  // for (var i = 0; i <= 11; i++) {
  //   randomNumbers.add(random.nextDouble());
  // }

  return randomNumbers
      .mapIndexed(
          (index, element) => PricePoint(x: index.toDouble(), y: element))
      .toList();
}
