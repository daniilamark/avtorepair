// ignore_for_file: prefer_const_constructors

// import 'dart:convert';
// import 'dart:io';
// import 'package:avtorepair/config/api_config.dart';
import 'dart:convert';

import 'package:avtorepair/config/api_config.dart';
import 'package:avtorepair/config/app_routes.dart';
import 'package:avtorepair/pages/auth/login_page.dart';
import 'package:avtorepair/pages/car_profile/doc_page.dart';
import 'package:avtorepair/pages/car_profile/edit_profile_page.dart';
// import 'package:http/http.dart' as http;
import 'package:avtorepair/components/car_avatar.dart';

import 'package:avtorepair/config/app_icons.dart';
import 'package:avtorepair/config/app_strings.dart';
import 'package:avtorepair/pages/car_profile/garage_page.dart';
// import 'package:avtorepair/services/local_db/local_garage.dart';
import 'package:flutter/material.dart';
import 'package:avtorepair/components/toolbar.dart';
import 'package:avtorepair/components/user_avatar.dart';
// import 'package:avtorepair/config/app_routes.dart';
import 'package:avtorepair/styles/app_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// enum ProfileMenu {edit, logout }
enum ProfileMenu { logout }

class CarProfilePage extends StatefulWidget {
  final token;
  const CarProfilePage({@required this.token, Key? key}) : super(key: key);

  @override
  State<CarProfilePage> createState() => _CarProfilePageState();
}

Future<List> _getCarsList(userId) async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request('GET', Uri.parse(getUserCarsList));
  request.body = json.encode({"userId": userId});
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var respData = await response.stream.bytesToString();
    // print(respData);
    var allData = json.decode(respData);
    List list = allData['success'];

    return list;
  } else {
    print(response.reasonPhrase);
    throw Exception('Failed to load data');
  }
}

class _CarProfilePageState extends State<CarProfilePage> {
  late String userId;
  late String email;
  int? idMainAvto;
  List itemsCars = [];

  late SharedPreferences prefs;
  // List<Map<String, dynamic>> _allData = [];
  // bool _isLoading = false;
//
  void _refreshData() async {
    // final data = await LocalGarage.getAllData();
    setState(
      () {
        // _allData = data;
        // _isLoading = true;
      },
    );
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    idMainAvto = prefs.getInt('idMainAvto');
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
    initSharedPref();

    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
    email = jwtDecodedToken['email'].toString();

    _getCarsList(userId).then((result) {
      setState(() {
        itemsCars = result;
      });
    });
  }

  // void getUserByEmail() async {
  //   // if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {

  //   // final reqBody = {'email': 'admin1@admin.com'};
  //   // final uri =
  //   //     Uri.http('http://192.168.1.184:3000/'.toString(), getUser, reqBody);

  //   // final response = await http.get(
  //   //   uri,
  //   //   headers: {"Content-Type": "application/json"},
  //   // );
  //   // print(reqBody);
  //   // var response = await http.get(Uri.parse(getUser),
  //   //     headers: {"Content-Type": "application/json; charset=utf-8"});
  //   // // body: jsonEncode(reqBody));
  //   // var jsonResponse = jsonDecode(response.body);
  //   // print(jsonResponse);
  //   // // print(response);
  //   // if (jsonResponse['status']) {
  //   //   print(jsonResponse['name']);
  //   // }
  //   var headers = {'Content-Type': 'application/json'};
  //   var request = http.Request('GET', Uri.parse(getUser));
  //   request.body = json.encode({"email": email});
  //   request.headers.addAll(headers);

  //   http.StreamedResponse response = await request.send();

  //   if (response.statusCode == 200) {
  //     // print(await response.stream.bytesToString());
  //     var streamedResponse = response;
  //     var response2 = await http.Response.fromStream(streamedResponse);
  //     final result = jsonDecode(response2.body) as Map<String, dynamic>;

  //     setState(
  //       () {
  //         name = result['success'];
  //       },
  //     );
  //     print(result['success']);
  //     // return !result['hasErrors'];
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  // }

  // const CarProfilePage({
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Toolbar(
        title: AppStrings.profile,
        actions: [
          IconButton(
            icon: SvgPicture.asset(AppIcons.icEdit),
            onPressed: () => {
              // Navigator.of(context).pushNamed(AppRoutes.editProfile),
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditProfilePage())),
            },
          ),
          IconButton(
            icon: SvgPicture.asset(AppIcons.icGarage),
            onPressed: () => {
              // Navigator.of(context).pushNamed(AppRoutes.garagePage),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GaragePage(token: widget.token!))),
            },
          ),
          IconButton(
            icon: Icon(
              Icons.file_present_outlined,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            onPressed: () => {
              // Navigator.of(context).pushNamed(AppRoutes.settingsPage),
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => DocPage())),
            },
          ),
          PopupMenuButton<ProfileMenu>(
            onSelected: (value) {
              switch (value) {
                // case ProfileMenu.edit:
                //   Navigator.of(context).pushNamed(AppRoutes.editProfile);
                //   break;
                case ProfileMenu.logout:
                  // Navigator.of(context).pushNamed(AppRoutes.login);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                  // prefs.setString('token', '');
                  break;
                default:
              }
            },
            // icon: SvgPicture.asset(AppIcons.icSetting),
            icon: const Icon(Icons.exit_to_app_outlined),
            itemBuilder: (context) {
              return [
                // const PopupMenuItem(
                //   value: ProfileMenu.edit,
                //   child: Text(AppStrings.edit),
                // ),
                const PopupMenuItem(
                  value: ProfileMenu.logout,
                  child: Text(AppStrings.logout),
                ),
              ];
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                UserAvatar(
                  size: 120,
                ),
                CarAvatar(
                  size: 120,
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              email,
              style: AppText.header2,
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  // _allData[0]['brand'],\
                  // int idMainAvto = ;
                  itemsCars[prefs.getInt('idMainAvto')!]['brand'],
                  // "",
                  // _allData[arguments.index]['brand'].isNull
                  //     ? 'пусто'
                  //     : 'пусто',

                  style: AppText.header2,
                ),
                Text(
                  // _allData[0]['model'],
                  itemsCars[prefs.getInt('idMainAvto')!]['model'],
                  // "",
                  // _allData[arguments.index]['brand'].isNull
                  //     ? 'пусто'
                  //     : 'пусто',

                  style: AppText.header2,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 1,
              height: 24,
            ),

            // марка модель
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      "",
                      // _allData[0]['brand'],
                      // _allData[arguments.index]['brand'].isNull
                      //     ? 'пусто'
                      //     : 'пусто',

                      style: AppText.header2,
                    ),
                    Text(
                      "Марка",
                      style: AppText.subtitle3,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "",
                      // _allData[0]['model'],
                      style: AppText.header2,
                    ),
                    Text(
                      "Модель",
                      style: AppText.subtitle3,
                    ),
                  ],
                )
              ],
            ),
            Divider(
              thickness: 1,
              height: 24,
            ),

            // год пробег
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      "",
                      // _allData[0]['mileage'],
                      //_allData[arguments]['mileage'].isEmpty ?? "1",
                      style: AppText.header2,
                    ),
                    Text(
                      "Пробег",
                      style: AppText.subtitle3,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "",
                      // _allData[0]['yearIssue'],
                      //_allData[arguments.index]['yearIssue'].isEmpty ?? "1",
                      style: AppText.header2,
                    ),
                    Text(
                      "Год выпуска",
                      style: AppText.subtitle3,
                    ),
                  ],
                )
              ],
            ),
            Divider(
              thickness: 1,
              height: 24,
            ),

            // кпп двигатель
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      "",
                      // _allData[0]['transmission'],
                      //_allData[arguments.index]['transmission'].isEmpty ?? "1",
                      style: AppText.header2,
                    ),
                    Text(
                      "Коробка передач",
                      style: AppText.subtitle3,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "",
                      // _allData[0]['typeFuel'],
                      // _allData[arguments.index]['typeFuel'].isEmpty ?? "1",
                      style: AppText.header2,
                    ),
                    Text(
                      "Двигатель",
                      style: AppText.subtitle3,
                    ),
                  ],
                )
              ],
            ),
            Divider(
              thickness: 1,
              height: 24,
            ),
            //

            // КУЗОВ ПРИВОД
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      "",
                      // _allData[0]['carBody'],
                      //_allData[arguments.index]['carBody'].isEmpty ?? "1",
                      style: AppText.header2,
                    ),
                    Text(
                      "Кузов",
                      style: AppText.subtitle3,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "",
                      // _allData[0]['engineVolume'],
                      //_allData[arguments.index]['engineVolume'].isEmpty ?? "1",
                      style: AppText.header2,
                    ),
                    Text(
                      "Объем двигателя",
                      style: AppText.subtitle3,
                    ),
                  ],
                )
              ],
            ),
            Divider(
              thickness: 1,
              height: 24,
            ),

            // мощность двигателя объем бака
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      "",
                      // _allData[0]['enginePower'],
                      // _allData[arguments.index]['enginePower'].isEmpty ?? "1",
                      style: AppText.header2,
                    ),
                    Text(
                      "Мощность",
                      style: AppText.subtitle3,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "",
                      // _allData[0]['volumeTank'],
                      // _allData[arguments.index]['volumeTank'].isEmpty ?? "1",
                      style: AppText.header2,
                    ),
                    Text(
                      "Объем бака",
                      style: AppText.subtitle3,
                    ),
                  ],
                )
              ],
            ),
            Divider(
              thickness: 1,
              height: 24,
            ),

            // VIN
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      "",
                      // _allData[0]['vin'],

                      // _allData[arguments.index]['vin'].isEmpty ?? "1",
                      style: AppText.header2,
                    ),
                    Text(
                      "VIN",
                      style: AppText.subtitle3,
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              thickness: 1,
              height: 24,
            ),

            SizedBox(
              height: 120,
            ),
          ],
        ),
      ),
    );
  }
}
