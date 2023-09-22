import 'package:avtorepair/pages/edit_profile_page.dart';
import 'package:avtorepair/pages/home_page.dart';
import 'package:avtorepair/pages/login_page.dart';
import 'package:avtorepair/pages/main_page.dart';
import 'package:avtorepair/pages/messages_page.dart';
import 'package:avtorepair/pages/nearby_page.dart';

class AppRoutes {
  static final pages = {
    login: (context) => LoginPage(),
    home: (context) => HomePage(),
    main: (context) => const MainPage(),
    editProfile: (context) => const EditProfilePage(),
    nearby: (context) => const NearbyPage(),
    messages: (context) => const MessagesPage(),
  };

  static const login = '/';
  static const home = '/home';
  static const main = '/main';
  static const editProfile = '/edit_profile';
  static const nearby = '/nearby';
  static const messages = '/messages';
}
