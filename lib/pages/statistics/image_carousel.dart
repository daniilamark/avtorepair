// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageCarousel extends StatelessWidget {
  final List<String> pictureUrls = List.generate(5, (index) {
    return 'https://picsum.photos/id/${index + 200}/300/200';
  });

  ImageCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Carousel'),
      ),
      body: Center(
        child: CarouselSlider(
          items: pictureUrls
              .map(
                (url) => Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Image.network(url, fit: BoxFit.cover),
                ),
              )
              .toList(),
          options: CarouselOptions(),
        ),
      ),
    );
  }
}
