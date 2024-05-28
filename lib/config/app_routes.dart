import 'package:avtorepair/pages/car_profile/edit_profile_page.dart';
import 'package:avtorepair/pages/auth/login_page.dart';
import 'package:avtorepair/pages/car_profile/garage_page.dart';
import 'package:avtorepair/pages/car_profile/doc_page.dart';
import 'package:avtorepair/pages/main_page.dart';
import 'package:avtorepair/pages/map_page.dart';
import 'package:avtorepair/pages/auth/registration_page.dart';
import 'package:avtorepair/pages/map/routing_page.dart';
import 'package:avtorepair/pages/service/calendar.dart';

class AppRoutes {
  static final pages = {
    login: (context) => const LoginPage(),
    registration: (context) => const RegistrationPage(),
    //home: (context) => HomePage(),
    main: (context) => const MainPage(),
    editProfile: (context) => const EditProfilePage(),
    routingPage: (context) => const RoutingPage(),
    mapPage: (context) => const MapPage(),
    //mapPage: (context) => const MapPage(),

    garagePage: (context) => const GaragePage(),
    settingsPage: (context) => const DocPage(),
    calendarPage: (context) => TableBasicsExample(),
  };

  static const login = '/';
  static const registration = '/registration';
  //static const home = '/home';
  static const main = '/main';
  static const editProfile = '/edit_profile';
  static const routingPage = '/routingPage';
  static const mapPage = '/mapPage';

  static const garagePage = '/garage';
  static const settingsPage = '/settings';

  static const calendarPage = '/calendar';
}
