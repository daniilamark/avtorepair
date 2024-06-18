// import 'package:avtorepair/pages/car_profile/garage_page.dart';
// import 'dart:convert';

// import 'package:avtorepair/config/api_config.dart';

import 'package:avtorepair/pages/auth/login_page.dart';
import 'package:avtorepair/pages/map_page.dart';
import 'package:avtorepair/pages/refueling/refueling_page.dart';
//import 'package:avtorepair/pages/routing_page.dart';
import 'package:avtorepair/pages/service/service_page.dart';
import 'package:avtorepair/pages/statistics/statistics_page.dart';
// import 'package:avtorepair/services/local_db/local_garage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:avtorepair/components/bottom_navigation_item.dart';
import 'package:avtorepair/config/app_icons.dart';
import 'package:avtorepair/pages/car_profile/car_profile_page.dart';
import 'package:avtorepair/styles/app_colors.dart';
// import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyBottomNavigation extends StatelessWidget {
  final Menus currentIndex;
  final ValueChanged<Menus> onTap;
  const MyBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 87,
      margin: const EdgeInsets.all(24),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 17,
            child: Container(
              height: 70,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: BottomNavigationItem(
                      onPressed: () => onTap(Menus.carProfile),
                      icon: AppIcons.icCar,
                      current: currentIndex,
                      name: Menus.carProfile,
                    ),
                  ),
                  Expanded(
                    child: BottomNavigationItem(
                      onPressed: () => onTap(Menus.refueling),
                      icon: AppIcons.icRefuling,
                      current: currentIndex,
                      name: Menus.refueling,
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    child: BottomNavigationItem(
                      onPressed: () => onTap(Menus.routing),
                      icon: AppIcons.icMap,
                      current: currentIndex,
                      name: Menus.routing,
                    ),
                  ),
                  Expanded(
                    child: BottomNavigationItem(
                      onPressed: () => onTap(Menus.statistics),
                      icon: AppIcons.icStatistics,
                      current: currentIndex,
                      name: Menus.statistics,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 28,
            child: GestureDetector(
              onTap: () => onTap(Menus.service),
              child: Container(
                width: 48,
                height: 48,
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: AppColors.background,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(AppIcons.icTool),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  final token;
  // MainPage(this.email);
  const MainPage({@required this.token, Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

enum Menus {
  carProfile,
  refueling,
  service,
  routing,
  statistics,
}

class _MainPageState extends State<MainPage> {
  late String userId;
  late String email;
  late SharedPreferences prefsMain;

  Menus currentIndex = Menus.carProfile;

  @override
  void initState() {
    super.initState();

    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
    email = jwtDecodedToken['email'].toString();
  }

  @override
  Widget build(BuildContext context) {
// PAGES CLASSES
    final pages = [
      CarProfilePage(
          token: widget.token ??
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()))),
      RefuelingPage(
          token: widget.token ??
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()))),
      // const RefuelingPage(),
      const ServicePage(),
      const MapPage(),
      //const RoutingPage(),
      const StatisticsPage(),
    ];
    return Scaffold(
      extendBody: true,
      body: pages[currentIndex.index],
      bottomNavigationBar: MyBottomNavigation(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(
            () {
              currentIndex = value;
            },
          );
        },
      ),
    );
  }
}
