import 'package:avtorepair/pages/edit_profile_page.dart';
import 'package:avtorepair/pages/login_page.dart';
import 'package:avtorepair/pages/main_page.dart';
import 'package:avtorepair/pages/registration_page.dart';

class AppRoutes {
  static final pages = {
    login: (context) => const LoginPage(),
    registration: (context) => const RegistrationPage(),
    //home: (context) => HomePage(),
    main: (context) => const MainPage(),
    editProfile: (context) => const EditProfilePage(),
  };

  static const login = '/';
  static const registration = '/registration';
  //static const home = '/home';
  static const main = '/main';
  static const editProfile = '/edit_profile';
}
