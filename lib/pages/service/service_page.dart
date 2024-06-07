import 'package:avtorepair/components/toolbar.dart';
import 'package:avtorepair/config/app_icons.dart';
import 'package:avtorepair/config/app_strings.dart';
import 'package:avtorepair/styles/app_text.dart';
import 'package:flutter/material.dart';
import 'package:avtorepair/config/db_helper.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/app_routes.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  List<Map<String, dynamic>> _allData = [];
  bool _isLoading = true;

  String dropdownValueService = 'ТО';
  String dropdownValueCar = 'ВАЗ 2110';

  var itemsService = [
    'ТО',
    'Ремонт',
    'Замена',
    'Тюнинг',
    'Запчасть',
    'Диагностика',
    'Шиномонтаж',
  ];

  var itemsServiceCar = [
    'ВАЗ 2110',
    'Ауди',
    'Беларус',
  ];

  void _refreshData() async {
    final data = await SQLHelper.getAllData();
    setState(() {
      _allData = data;
      _isLoading = false;
      _foundUsers = _allData;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _addData() async {
    await SQLHelper.createdData(
      dropdownValueCar,
      dropdownValueService,
      _nameController.text,
      int.parse(_countServiceController.text),
      int.parse(_mileageController.text),
      _commentController.text,
      _addressController.text,
    );
    _refreshData();
  }

  Future<void> _updateData(int id) async {
    await SQLHelper.updateData(
      id,
      dropdownValueCar,
      dropdownValueService,
      _nameController.text,
      int.parse(_countServiceController.text),
      int.parse(_mileageController.text),
      _commentController.text,
      _addressController.text,
    );
    _refreshData();
  }

  void _deleteData(int id, BuildContext context) async {
    await SQLHelper.deleteData(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        // backgroundColor: Colors.redAccent,
        content: Text(
          'Запись сервиса удалена',
        ),
      ),
    );
    _refreshData();
  }

  String _getStringDate(String date) {
    String formattedDate = date.toString().substring(0, 10);

    return formattedDate;
  }

  // final TextEditingController _typeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _countServiceController = TextEditingController();
  final TextEditingController _mileageController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  void showBottomSheet(int? id, int index) async {
    if (id != null) {
      final existingData =
          _allData.firstWhere((element) => element['id'] == id);
      // dropdownValueCar = existingData['autoCar'];
      // dropdownValueService = existingData['typeService'];

      // _typeController.text = existingData['typeService'];
      _nameController.text = existingData['name'];
      _countServiceController.text = existingData['countService'].toString();
      _mileageController.text = existingData['mileage'].toString();
      _commentController.text = existingData['comment'];
      _addressController.text = existingData['address'];
    }

    showModalBottomSheet(
      elevation: 5,
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          top: 30,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: DropdownButton(
                    // Initial Value
                    value: dropdownValueCar,

                    // Down Arrow Icon
                    // icon: SvgPicture.asset(AppIcons.icCar),
                    icon: const Icon(Icons.arrow_drop_down),
                    // Array list of items
                    items: itemsServiceCar.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),

                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValueCar = newValue!.toString();
                      });
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: DropdownButton(
                    // Initial Value
                    value: dropdownValueService,

                    // Down Arrow Icon
                    // icon: SvgPicture.asset(AppIcons.icCar),
                    icon: const Icon(Icons.arrow_drop_down),
                    // Array list of items
                    items: itemsService.map((String items1) {
                      return DropdownMenuItem(
                        value: items1,
                        child: Text(
                          items1,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue1) {
                      setState(() {
                        dropdownValueService = newValue1!.toString();
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Название",
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _countServiceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Стоимость",
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _mileageController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Пробег",
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Адрес",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _commentController,
              // maxLines: 2,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Комментарий",
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (id != null) {
                      _deleteData(_allData[index]['id'], context);
                    }

                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Text(
                      id == null ? "Отмена" : "Удалить",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (id == null) {
                      await _addData();
                    }
                    if (id != null) {
                      await _updateData(id);
                    }
                    // _typeFuelController.text = "";
                    // _carController.text = "";
                    _nameController.text = "";
                    _mileageController.text = "";
                    _countServiceController.text = "";
                    _addressController.text = "";
                    _commentController.text = "";
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                    print("data added");
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Text(
                      id == null ? "Добавить" : "Обновить",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 0),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _foundUsers = [];

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allData;
    } else {
      results = _allData
          .where((user) =>
              user["typeService"]
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              user["autoCar"]
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              user["countService"]
                  .toString()
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              user["mileage"]
                  .toString()
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              user["comment"]
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              user["address"]
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              user["createdAt"]
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color(0xFFECEAF4),
      appBar: Toolbar(
        title: AppStrings.service,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.calendar_month,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.calendarPage),
          ),
          IconButton(
            icon: const Icon(
              Icons.post_add,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            onPressed: () => showBottomSheet(null, 0),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                labelText: 'Поиск',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : _foundUsers.isNotEmpty
                    ? ListView.builder(
                        itemCount: _foundUsers.length,
                        itemBuilder: (context, index) => Card(
                          key: ValueKey(_foundUsers[index]["id"]),
                          margin: const EdgeInsets.only(
                            left: 15,
                            top: 10,
                            right: 15,
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                leading: SvgPicture.asset(AppIcons.icTool),
                                onTap: () {
                                  showBottomSheet(
                                      _foundUsers[index]['id'], index);
                                },
                                title: Text(
                                  _foundUsers[index]['typeService'],
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                  //style: AppText.body1,
                                ),
                                trailing: Text(
                                  _foundUsers[index]['mileage'].toString() +
                                      " км.",
                                  style: AppText.header3,
                                ),
                                subtitle: Text(
                                  _foundUsers[index]['autoCar'],
                                  //style: AppText.body2,
                                ),
                                //tileColor: AppColors.white,
                                // trailing:
                              ),
                              ListTile(
                                // leading: SvgPicture.asset(AppIcons.icCar),
                                onTap: () {
                                  showBottomSheet(
                                      _foundUsers[index]['id'], index);
                                },
                                title: Text(
                                  _foundUsers[index]['name'],
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                  //style: AppText.body1,
                                ),
                                subtitle: Text(
                                  _getStringDate(
                                      _foundUsers[index]['createdAt']),
                                  //style: AppText.body2,
                                ),
                                trailing: Text(
                                  _foundUsers[index]['countService']
                                          .toString() +
                                      " р.",
                                  style: AppText.header3,
                                ),
                                //tileColor: AppColors.white,
                                // trailing:
                              ),
                            ],
                          ),
                        ),
                      )
                    : const Text(
                        'Ничего не найдено...',
                        style: TextStyle(fontSize: 24),
                      ),
          ),
        ],
      ),
    );
  }
}
