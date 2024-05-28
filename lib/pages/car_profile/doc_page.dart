import 'dart:io';

import 'package:avtorepair/config/app_routes.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:avtorepair/components/toolbar.dart';
import 'package:image_picker/image_picker.dart';

class DocPage extends StatefulWidget {
  const DocPage({Key? key}) : super(key: key);

  @override
  State<DocPage> createState() => _DocPageState();
}

class _DocPageState extends State<DocPage> {
  File? _selectedImage;

  final List<String> pictureUrls = [
    "https://i.pinimg.com/originals/db/b0/8a/dbb08a069d1f24c4b61da740198a59cc.jpg",
    "https://storge.pic2.me/upload/186/59930129033a9.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Toolbar(
        title: "Мои документы",
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app_outlined,
                color: Color.fromARGB(255, 255, 255, 255)),
            onPressed: () => {
              Navigator.of(context).pushReplacementNamed(AppRoutes.login),
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              MaterialButton(
                color: Colors.blue,
                child: Text("Загрузка"),
                onPressed: () {
                  _pickImageFromGalery();
                },
              ),
              MaterialButton(
                color: Colors.blue,
                child: Text("Загрузка камера"),
                onPressed: () {
                  _pickImageFromCamera();
                },
              ),
              MaterialButton(
                color: Colors.blue,
                child: Text("Удалить"),
                onPressed: () {
                  _deleteImage();
                },
              ),
              const SizedBox(height: 20),
              // const Image(
              //   width: 300,
              //   height: 300,
              //   image: NetworkImage(
              //       'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
              // ),
              _selectedImage != null
                  ? Image.file(_selectedImage!)
                  : const Text("Выберите Изображение"),
              Center(
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
                    // autoPlay: true,
                    // autoPlayInterval: const Duration(seconds: 2),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _pickImageFromGalery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _selectedImage = File(returnedImage!.path);
    });
  }

  Future _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      _selectedImage = File(returnedImage!.path);
    });
  }

  Future _deleteImage() async {
    const returnedImage = null;

    setState(() {
      _selectedImage = returnedImage;
    });
  }
}

// class ImageCarousel extends StatelessWidget {
//   final List<String> pictureUrls = [
//     "https://i.pinimg.com/originals/db/b0/8a/dbb08a069d1f24c4b61da740198a59cc.jpg",
//     "https://storge.pic2.me/upload/186/59930129033a9.jpg",
//     "https://proprikol.ru/wp-content/uploads/2019/08/kartinki-nyashnye-kotiki-16.jpg",
//     "http://tapeciarnia.pl/tapety/normalne/130115_dwa_kotki_skrzynia.jpg",
//     "https://w-dog.ru/wallpapers/5/18/544018020951502/koshka-siamskaya-boke-na-dereve-goluboglazaya.jpg",
//     "https://wdorogu.ru/images/wp-content/uploads/2020/10/90366-ksyu_1280x960.jpg",
//   ];
//   final List<String> pictures = [
//     "\assets\images\facebook.png",
//     "https://storge.pic2.me/upload/186/59930129033a9.jpg",
//   ];

//   ImageCarousel({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: CarouselSlider(
//         items: pictureUrls
//             .map(
//               (url) => Container(
//                 width: MediaQuery.of(context).size.width,
//                 margin: const EdgeInsets.symmetric(horizontal: 5.0),
//                 child: Image.network(url, fit: BoxFit.cover),
//               ),
//             )
//             .toList(),
//         options: CarouselOptions(
//           autoPlay: true,
//           autoPlayInterval: const Duration(seconds: 2),
//           autoPlayAnimationDuration: const Duration(milliseconds: 800),
//           autoPlayCurve: Curves.fastOutSlowIn,
//           enlargeCenterPage: true,
//         ),
//       ),
//     );
//   }
// }
