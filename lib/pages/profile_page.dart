import 'package:flutter/material.dart';
import 'package:avtorepair/components/toolbar.dart';
import 'package:avtorepair/components/user_avatar.dart';
import 'package:avtorepair/config/app_routes.dart';
import 'package:avtorepair/styles/app_text.dart';

enum ProfileMenu { edit, logout }

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Toolbar(
        title: 'Profile',
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
              return const [
                PopupMenuItem(
                  child: Text("Edit"),
                  value: ProfileMenu.edit,
                ),
                PopupMenuItem(
                  child: Text("Log out "),
                  value: ProfileMenu.logout,
                ),
              ];
            },
          )
        ],
      ),
      body: const Column(
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
            'Markin Daniil',
            style: AppText.header2,
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            'data my',
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
                    "762",
                    style: AppText.header2,
                  ),
                  Text(
                    "followers",
                    style: AppText.subtitle3,
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "20",
                    style: AppText.header2,
                  ),
                  Text(
                    "posts",
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
                    "following",
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
        ],
      ),
    );
  }
}
