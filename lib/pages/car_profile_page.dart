// ignore_for_file: prefer_const_constructors

import 'package:avtorepair/config/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:avtorepair/components/toolbar.dart';
import 'package:avtorepair/components/user_avatar.dart';
import 'package:avtorepair/config/app_routes.dart';
import 'package:avtorepair/styles/app_text.dart';

enum ProfileMenu { edit, logout }

class CarProfilePage extends StatelessWidget {
  const CarProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Toolbar(
        title: AppStrings.profile,
        actions: [
          PopupMenuButton<ProfileMenu>(
            onSelected: (value) {
              switch (value) {
                case ProfileMenu.edit:
                  Navigator.of(context).pushNamed(AppRoutes.editProfile);
                  break;
                case ProfileMenu.logout:
                  Navigator.of(context).pushNamed(AppRoutes.login);
                  break;
                default:
              }
            },
            icon: const Icon(Icons.more_vert_rounded),
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: ProfileMenu.edit,
                  child: Text(AppStrings.edit),
                ),
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
              'ВАЗ 2110',
              style: AppText.subtitle3,
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      "76 004",
                      style: AppText.header2,
                    ),
                    Text(
                      "Километров",
                      style: AppText.subtitle3,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "89",
                      style: AppText.header2,
                    ),
                    Text(
                      "Заправок",
                      style: AppText.subtitle3,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "627",
                      style: AppText.header2,
                    ),
                    Text(
                      "Обслуживания",
                      style: AppText.subtitle3,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 1,
              height: 24,
            ),
            //
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
          ],
        ),
      ),
    );
  }
}
