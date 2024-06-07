import 'dart:io';

// import 'package:avtorepair/config/app_routes.dart';
// import 'package:avtorepair/pages/car_profile/db_doc.dart';
// import 'package:avtorepair/pages/car_profile/photo_view_page.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:avtorepair/components/toolbar.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:galleryimage/galleryimage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class DocPage extends StatefulWidget {
  const DocPage({Key? key}) : super(key: key);

  @override
  State<DocPage> createState() => _DocPageState();
}

class _DocPageState extends State<DocPage> {
  // List<Map<String, dynamic>> _allData = [];

  File? _selectedImage;
  // String? _selectedImageString;

  // final ImagePicker _picker = ImagePicker();

  List<String> pictureUrls = [
    "https://storge.pic2.me/upload/186/59930129033a9.jpg",
    "https://storge.pic2.me/upload/186/59930129033a9.jpg",
    // "https://scx2.b-cdn.net/gfx/news/hires/2019/2-nature.jpg",
    // "https://isha.sadhguru.org/blog/wp-content/uploads/2016/05/natures-temples.jpg",
    // "https://upload.wikimedia.org/wikipedia/commons/7/77/Big_Nature_%28155420955%29.jpeg",
    // "https://s23574.pcdn.co/wp-content/uploads/Singular-1140x703.jpg",
    "https://storge.pic2.me/upload/186/59930129033a9.jpg",
  ];

  // void _refreshData() async {
  //   final data = await DBDocLocal.getAllData();

  //   setState(() {
  //     _allData = data;
  //     // pictureUrls.add(data.elementAt(2)['link']);
  //     // print(data.elementAt(2)['link']);
  //     // _isLoading = false;
  //     // _foundUsers = _allData;
  //   });
  // }

  // Future<void> _addData(link, name) async {
  //   await DBDocLocal.createdData(
  //     // _typeFuelController.text,
  //     link,
  //     name,
  //   );
  //   _refreshData();
  // }

  @override
  void initState() {
    super.initState();
    loadImage();
    // _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Toolbar(
        title: "Документы",
        actions: [
          IconButton(
            icon: const Icon(Icons.delete,
                color: Color.fromARGB(255, 255, 255, 255)),
            onPressed: () => {
              // _pickImageFromCamera(),
              _deleteImage(),
            },
          ),
          IconButton(
            icon: const Icon(Icons.add_a_photo,
                color: Color.fromARGB(255, 255, 255, 255)),
            onPressed: () => {
              _pickImageFromCamera(),
            },
          ),
          IconButton(
            icon: const Icon(Icons.file_download,
                color: Color.fromARGB(255, 255, 255, 255)),
            onPressed: () => {
              _pickImageFromGalery(),
            },
          ),
          // IconButton(
          //   icon: const Icon(Icons.exit_to_app_outlined,
          //       color: Color.fromARGB(255, 255, 255, 255)),
          //   onPressed: () => {
          //     Navigator.of(context).pushReplacementNamed(AppRoutes.login),
          //   },
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            //         MaterialButton(
            //           color: Colors.blue,
            //           child: Text("Загрузка"),
            //           onPressed: () {
            //             _pickImageFromGalery();
            //           },
            //         ),
            //         // MaterialButton(
            //         //   color: Colors.blue,
            //         //   child: Text("Загрузка"),
            //         //   onPressed: () {
            //         //     _pickImageFromGalery();
            //         //   },
            //         // ),
            //         MaterialButton(
            //           color: Colors.blue,
            //           child: Text("Загрузка камера"),
            //           onPressed: () {
            //             _pickImageFromCamera();
            //           },
            //         ),
            //         MaterialButton(
            //           color: Colors.blue,
            //           child: Text("Удалить"),
            //           onPressed: () {
            //             _deleteImage();
            //           },
            //         ),
            //         const SizedBox(height: 20),
            //         // const Image(
            //         //   width: 300,
            //         //   height: 300,
            //         //   image: NetworkImage(
            //         //       'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
            //         // ),
            _selectedImage != null
                ? Image.file(_selectedImage!)
                : const Text("Выберите Изображение"),
            // Image.file(_selectedImage!)
            // Center(
            //   child:
            //       //               //  CarouselSlider(
            //       //               //   items: pictureUrls
            //       //               //       .map(
            //       //               //         (url) => Container(
            //       //               //           width: MediaQuery.of(context).size.width,
            //       //               //           margin: const EdgeInsets.symmetric(horizontal: 5.0),
            //       //               //           child: Image.network(url, fit: BoxFit.cover),
            //       //               //         ),
            //       //               //       )
            //       //               //       .toList(),
            //       //               //   options: CarouselOptions(
            //       //               //     // autoPlay: true,
            //       //               //     // autoPlayInterval: const Duration(seconds: 2),
            //       //               //     autoPlayAnimationDuration:
            //       //               //         const Duration(milliseconds: 800),
            //       //               //     autoPlayCurve: Curves.fastOutSlowIn,
            //       //               //     enlargeCenterPage: true,
            //       //               //   ),
            //       //               // ),
            //       //               //   GalleryImage(
            //       //               // // key: ,
            //       //               // imageUrls: pictureUrls,
            //       //               // numOfShowImages: 2,
            //       //               // titleGallery: "_title",
            //       //           //     CachedNetworkImage(
            //       //           //   imageUrl:
            //       //           //       "https://ethnomir.ru/upload/medialibrary/a7c/gnom.jpg",
            //       //           //   imageBuilder: (context, imageProvider) => Container(
            //       //           //     decoration: BoxDecoration(
            //       //           //       image: DecorationImage(
            //       //           //           image: imageProvider,
            //       //           //           fit: BoxFit.cover,
            //       //           //           colorFilter: ColorFilter.mode(
            //       //           //               Colors.red, BlendMode.colorBurn)),
            //       //           //     ),
            //       //           //   ),
            //       //           //   placeholder: (context, url) =>
            //       //           //       const CircularProgressIndicator(),
            //       //           //   errorWidget: (context, url, error) => const Icon(Icons.error),
            //       //           // ),
            //       //         // ),
            //       //       ],
            //       //     ),
            //       //   ),
            //       // ),
            //       GridView.builder(
            //     physics: const BouncingScrollPhysics(
            //       parent: AlwaysScrollableScrollPhysics(),
            //     ),
            //     padding: const EdgeInsets.all(1),
            //     itemCount: pictureUrls.length,
            //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 2,
            //     ),
            //     itemBuilder: ((context, index) {
            //       return Container(
            //         padding: const EdgeInsets.all(0.5),
            //         child: InkWell(
            //           onTap: () => Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (_) =>
            //                   PhotoViewPage(photos: pictureUrls, index: index),
            //             ),
            //           ),
            //           child: Hero(
            //             tag: pictureUrls[index],
            //             child: CachedNetworkImage(
            //               imageUrl: pictureUrls[index],
            //               fit: BoxFit.cover,
            //               placeholder: (context, url) =>
            //                   Container(color: Colors.grey),
            //               errorWidget: (context, url, error) => Container(
            //                 color: Colors.red.shade400,
            //               ),
            //             ),
            //           ),
            //         ),
            //       );
            //     }),
            //   ),
            // ),
          ]),
        ),
      ),
    );
  }

  Future _pickImageFromGalery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    // saveImage(File("path/image/img223.jpg"),"img-test");
    setState(() {
      _selectedImage = File(returnedImage!.path);
      // print(returnedImage.path);

      // print("1! -" + returnedImage.path);
      // saveImage(File(_selectedImage as String), "img-test");
      saveImage(_selectedImage!);
      // print(_selectedImage);
    });
  }

  Future _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      _selectedImage = File(returnedImage!.path);
      // pictureUrls.add(returnedImage.path);
      saveImage(_selectedImage!);
    });
  }

  void saveImage(File img) async {
    final String path = (await getApplicationDocumentsDirectory()).path;

    File convertedImg = File(img.path);

    String hash = img.hashCode.toString();
    String fileName = "$hash.jpg";
    // print(img.hashCode);
    final File localImage = await convertedImg.copy('$path/$fileName');
    print("Saved image under: $path/$fileName");
    // print(localImage.path);
    // return localImage;
    // pictureUrls.add(localImage.path);
    // _addData(localImage.path, fileName);
    // print(pictureUrls.length);
  }

  void loadImage() async {
    const String fileName = "the_image.jpg";
    final String path = (await getApplicationDocumentsDirectory()).path;

    if (File('$path/$fileName').existsSync()) {
      // print("Image exists. Loading it...");
      setState(() {
        _selectedImage = File('$path/$fileName');
        // pictureUrls.add(File('$path/$fileName').path);
        // print(pictureUrls);
      });
    }
  }

  // void pickMultipleImages() async {
  //   final List<File>? images = await _picker.pickMultiImage();
  // }

  Future _deleteImage() async {
    const returnedImage = null;

    setState(() {
      _selectedImage = returnedImage;
      // pictureUrls.removeLast();
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
