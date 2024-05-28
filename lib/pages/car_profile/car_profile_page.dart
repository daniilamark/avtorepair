// ignore_for_file: prefer_const_constructors

import 'package:avtorepair/components/car_avatar.dart';
import 'package:avtorepair/config/app_icons.dart';
import 'package:avtorepair/config/app_strings.dart';
import 'package:avtorepair/pages/car_profile/garage_page.dart';
import 'package:avtorepair/services/local_db/local_garage.dart';
import 'package:flutter/material.dart';
import 'package:avtorepair/components/toolbar.dart';
import 'package:avtorepair/components/user_avatar.dart';
import 'package:avtorepair/config/app_routes.dart';
import 'package:avtorepair/styles/app_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum ProfileMenu { edit, logout }

class CarProfilePage extends StatefulWidget {
  const CarProfilePage({super.key});

  // final String brand;
  // final String model;
  // final String mileage;
  // final String yearIssue;
  // final String typeFuel;
  // final String transmission;
  // var list = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11'];

  @override
  State<CarProfilePage> createState() => _CarProfilePageState();
}

class _CarProfilePageState extends State<CarProfilePage> {
  List<Map<String, dynamic>> _allData = [];
  bool _isLoading = false;
//
  void _refreshData() async {
    final data = await LocalGarage.getAllData();
    setState(
      () {
        _allData = data;
        _isLoading = true;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  // const CarProfilePage({
  @override
  Widget build(BuildContext context) {
    // final arguments = (ModalRoute.of(context)?.settings.arguments ??
    //     GarageArguments(Null, '2', '', '', '', '', '', '', '', '', '', ''));
    //GarageArguments(0)) as GarageArguments;

    return Scaffold(
      appBar: Toolbar(
        title: AppStrings.profile,
        actions: [
          IconButton(
            icon: SvgPicture.asset(AppIcons.icEdit),
            onPressed: () => {
              Navigator.of(context).pushNamed(AppRoutes.editProfile),
            },
          ),
          IconButton(
            icon: SvgPicture.asset(AppIcons.icGarage),
            onPressed: () => {
              Navigator.of(context).pushNamed(AppRoutes.garagePage),
            },
          ),
          IconButton(
            icon: Icon(
              Icons.file_present_outlined,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            onPressed: () => {
              Navigator.of(context).pushNamed(AppRoutes.settingsPage),
            },
          ),
          // PopupMenuButton<ProfileMenu>(
          //   onSelected: (value) {
          //     switch (value) {
          //       case ProfileMenu.edit:
          //         Navigator.of(context).pushNamed(AppRoutes.editProfile);
          //         break;
          //       case ProfileMenu.logout:
          //         Navigator.of(context).pushNamed(AppRoutes.login);
          //         break;
          //       default:
          //     }
          //   },
          //   icon: SvgPicture.asset(AppIcons.icSetting),
          //   itemBuilder: (context) {
          //     return [
          //       const PopupMenuItem(
          //         value: ProfileMenu.edit,
          //         child: Text(AppStrings.edit),
          //       ),
          //       const PopupMenuItem(
          //         value: ProfileMenu.logout,
          //         child: Text(AppStrings.logout),
          //       ),
          //     ];
          //   },
          // )
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
              'Маркин Даниил',
              style: AppText.header2,
            ),
            SizedBox(
              height: 12,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     Text(
            //       _allData[0]['brand'],
            //       // _allData[arguments.index]['brand'].isNull
            //       //     ? 'пусто'
            //       //     : 'пусто',

            //       style: AppText.header2,
            //     ),
            //     Text(
            //       _allData[0]['model'],
            //       // _allData[arguments.index]['brand'].isNull
            //       //     ? 'пусто'
            //       //     : 'пусто',

            //       style: AppText.header2,
            //     ),
            //   ],
            // ),
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
