// import 'package:avtorepair/pages/car_profile/garage_page.dart';
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

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Menus currentIndex = Menus.carProfile;

  // List<Map<String, dynamic>> _allData = [];
  // bool _isLoading = true;

  // void _refreshData() async {
  //   final data = await LocalGarage.getAllData();
  //   setState(() {
  //     _allData = data;
  //     _isLoading = false;
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _refreshData();
  // }

  @override
  Widget build(BuildContext context) {
    // final arguments = (ModalRoute.of(context)?.settings.arguments ??
    //     GarageArguments('' as int, '', '', '', '', '', '')) as GarageArguments;

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

  // PAGES CLASSES
  final pages = [
    //авто
    //заправка
    //сервис
    //маршруты
    //статистика

    //car_profile
    //refueling
    //service
    //routing
    //statistics

    const CarProfilePage(
        //   index: argu,
        // brand: '',
        // model: '',
        // mileage: '',
        // yearIssue: '',
        // typeFuel: '',
        // transmission: '',
        ),

    const RefuelingPage(),
    const ServicePage(),
    const MapPage(),
    //const RoutingPage(),
    const StatisticsPage(),
  ];
}

enum Menus {
  carProfile,
  refueling,
  service,
  routing,
  statistics,
}

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
                      icon: AppIcons.icUser,
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
                child: SvgPicture.asset(AppIcons.icCar),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
