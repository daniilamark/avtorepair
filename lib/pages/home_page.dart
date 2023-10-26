// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:avtorepair/components/post_item.dart';
// import 'package:avtorepair/components/toolbar.dart';
// import 'package:avtorepair/config/app_icons.dart';
// import 'package:avtorepair/config/app_routes.dart';
// import 'package:avtorepair/config/app_strings.dart';

// // ignore: must_be_immutable
// class HomePage extends StatelessWidget {
//   HomePage({super.key});
//   List<String> users = [];

//   @override
//   Widget build(BuildContext context) {
//     mockUsersFromServer();
//     return Scaffold(
//       appBar: Toolbar(
//         title: AppStrings.appName,
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.of(context).pushNamed(AppRoutes.nearby);
//             },
//             icon: SvgPicture.asset(AppIcons.icLocation),
//           ),
//         ],
//       ),
//       body: ListView.separated(
//         itemBuilder: (context, index) {
//           return PostItem(
//             user: users[index],
//           );
//         },
//         itemCount: users.length,
//         separatorBuilder: (BuildContext context, int index) {
//           return const SizedBox(
//             height: 24,
//           );
//         },
//       ),
//     );
//   }

//   mockUsersFromServer() {
//     for (var i = 0; i < 1000; i++) {
//       users.add('User number $i');
//     }
//   }
// }
