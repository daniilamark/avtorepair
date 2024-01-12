import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:avtorepair/components/toolbar.dart';
import 'package:avtorepair/config/app_strings.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Toolbar(
        title: AppStrings.statistics,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              const Center(
                child: Text(
                  "Котостатистика",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Center(
                child: ImageCarousel(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageCarousel extends StatelessWidget {
  final List<String> pictureUrls = [
    "https://i.pinimg.com/originals/db/b0/8a/dbb08a069d1f24c4b61da740198a59cc.jpg",
    "https://storge.pic2.me/upload/186/59930129033a9.jpg",
    "https://proprikol.ru/wp-content/uploads/2019/08/kartinki-nyashnye-kotiki-16.jpg",
    "http://tapeciarnia.pl/tapety/normalne/130115_dwa_kotki_skrzynia.jpg",
    "https://w-dog.ru/wallpapers/5/18/544018020951502/koshka-siamskaya-boke-na-dereve-goluboglazaya.jpg",
    "https://wdorogu.ru/images/wp-content/uploads/2020/10/90366-ksyu_1280x960.jpg",
  ];

  ImageCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CarouselSlider(
        items: pictureUrls
            .map(
              (url) => Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Image.network(url, fit: BoxFit.cover),
              ),
            )
            .toList(),
        options: CarouselOptions(
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 2),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
        ),
      ),
    );
  }
}
