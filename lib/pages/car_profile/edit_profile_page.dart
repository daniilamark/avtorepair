import 'package:flutter/material.dart';
//import 'package:avtorepair/components/app_text_field.dart';
import 'package:avtorepair/components/toolbar.dart';
import 'package:avtorepair/components/user_avatar.dart';
import 'package:avtorepair/config/app_strings.dart';
import 'package:avtorepair/styles/app_colors.dart';

// import '../../config/db_helper.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // List<Map<String, dynamic>> _allUser = [];
  // bool _isLoading = true;

  // final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _surnameController = TextEditingController();

  // void _refreshUser() async {
  //   final user = await SQLHelper.getAllUser();
  //   setState(
  //     () {
  //       _allUser = user;
  //       _isLoading = false;
  //     },
  //   );
  // }

  // Future<void> _addUser() async {
  //   await SQLHelper.createdUser(_nameController.text, _surnameController.text);
  //   _refreshUser();
  // }

  // Future<void> _updateUser(int id) async {
  //   await SQLHelper.updateUser(
  //       id, _nameController.text, _surnameController.text);
  //   _refreshUser();
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _refreshUser();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Toolbar(title: "Редактирование профиля"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Stack(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: UserAvatar(
                      size: 120,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: const Icon(
                        Icons.edit,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              const TextField(
                // controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: AppStrings.firstName,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const TextField(
                // controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: AppStrings.lastName,
                ),
              ),
              // const AppTextField(hint: AppStrings.lastName),
              // const SizedBox(
              //   height: 16,
              // ),
              // ElevatedButton(
              //   onPressed: () async {
              //     print("data added");
              //   },
              //   child: const Padding(
              //     padding: EdgeInsets.all(18),
              //     child: Text(
              //       // _allUser['id'] == null ? "Add data" : "Update",
              //       style: TextStyle(
              //         fontSize: 18,
              //         fontWeight: FontWeight.w500,
              //       ),
              //     ),
              //   ),
              // ),
              // const AppTextField(hint: AppStrings.phoneNumber),
              // const SizedBox(
              //   height: 16,
              // ),
              // const AppTextField(hint: AppStrings.location),
              // const SizedBox(
              //   height: 16,
              // ),
              // const AppTextField(hint: AppStrings.birthday),
              // const SizedBox(
              //   height: 16,
              // ),
              // Container(
              //   padding: const EdgeInsets.only(left: 12, right: 12, top: 6),
              //   decoration: BoxDecoration(
              //     color: AppColors.fieldColor,
              //     borderRadius: const BorderRadius.all(
              //       Radius.circular(12),
              //     ),
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         AppStrings.gender,
              //         style: AppText.body1.copyWith(
              //           fontSize: 12,
              //         ),
              //       ),
              //       Row(
              //         children: [
              //           Expanded(
              //             child: RadioListTile(
              //               title: const Text(AppStrings.male),
              //               value: Gender.male,
              //               visualDensity: const VisualDensity(
              //                 horizontal: VisualDensity.minimumDensity,
              //                 vertical: VisualDensity.minimumDensity,
              //               ),
              //               contentPadding: EdgeInsets.zero,
              //               groupValue: gender,
              //               onChanged: (value) {
              //                 setState(
              //                   () {
              //                     gender = Gender.male;
              //                   },
              //                 );
              //               },
              //             ),
              //           ),
              //           Expanded(
              //             child: RadioListTile(
              //               title: const Text(AppStrings.female),
              //               value: Gender.female,
              //               visualDensity: const VisualDensity(
              //                 horizontal: VisualDensity.minimumDensity,
              //                 vertical: VisualDensity.minimumDensity,
              //               ),
              //               contentPadding: EdgeInsets.zero,
              //               groupValue: gender,
              //               onChanged: (value) {
              //                 setState(
              //                   () {
              //                     gender = Gender.female;
              //                   },
              //                 );
              //               },
              //             ),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
