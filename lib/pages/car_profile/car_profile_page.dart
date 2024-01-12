// ignore_for_file: prefer_const_constructors

import 'package:avtorepair/config/app_icons.dart';
import 'package:avtorepair/config/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:avtorepair/components/toolbar.dart';
import 'package:avtorepair/components/user_avatar.dart';
import 'package:avtorepair/config/app_routes.dart';
import 'package:avtorepair/styles/app_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum ProfileMenu { edit, logout }

class CarProfilePage extends StatelessWidget {
  const CarProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
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
            icon: SvgPicture.asset(AppIcons.icSetting),
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
        child: const Column(
          children: [
            SizedBox(
              height: 12,
            ),
            UserAvatar(
              size: 120,
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
            Text(
              'Выбранная машина',
              style: AppText.subtitle3,
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
                      "Lada",
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
                      "110",
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
                      "280 800",
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
                      "2006",
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
                      "Механическая",
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
                      "Бензиновый",
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
                      "Седан",
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
                      "Передний",
                      style: AppText.header2,
                    ),
                    Text(
                      "Привод",
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
                      "92 л.с.",
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
                      "42",
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
                      "VIN",
                      style: AppText.header2,
                    ),
                    Text(
                      "X7LLSRB1HAH548712",
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
