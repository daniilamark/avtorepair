import 'dart:convert';

import 'package:avtorepair/config/api_config.dart';
import 'package:avtorepair/config/app_icons.dart';
import 'package:avtorepair/services/local_db/local_refueling.dart';
import 'package:avtorepair/styles/app_text.dart';
import 'package:flutter/material.dart';
import 'package:avtorepair/components/toolbar.dart';
import 'package:avtorepair/config/app_strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class RefuelingPage extends StatefulWidget {
  final token;
  const RefuelingPage({@required this.token, Key? key}) : super(key: key);

  @override
  State<RefuelingPage> createState() => _RefuelingPageState();
}

Future<List> _getCarsList(userId) async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request('GET', Uri.parse(getUserCarsList));
  request.body = json.encode({"userId": userId});
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var respData = await response.stream.bytesToString();
    // print(respData);
    var allData = json.decode(respData);
    List list = allData['success'];

    return list;
  } else {
    print(response.reasonPhrase);
    throw Exception('Failed to load data');
  }
}

class _RefuelingPageState extends State<RefuelingPage> {
  List<Map<String, dynamic>> _allData = [];
  bool _isLoading = true;

  late String userId;
  List itemsCars = [];

  String dropdownvalue = '95 бензин';
  var dropdownvalueCar = '';
  // List of items in our dropdown menu
  var items = [
    '92 бензин',
    '95 бензин',
    'Дизель',
    'Электро',
  ];

  // var itemsCar = [
  //   'ВАЗ 2110',
  //   'Ауди',
  //   'Беларус',
  // ];

  List<String> itemsCarD = [];

  List<DropdownMenuItem<String>> itemsCar = [];

  void _refreshData() async {
    final data = await LocalRefueling.getAllData();
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

    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
    // email = jwtDecodedToken['email'].toString();

    _getCarsList(userId).then((result) {
      setState(() {
        itemsCars = result;
      });
    });
  }

  Future<void> _addData() async {
    await LocalRefueling.createdData(
        // _typeFuelController.text,
        dropdownvalue,
        dropdownvalueCar,
        // _autoCarController.text,
        int.parse(_countController.text),
        int.parse(_summaController.text),
        _addressController.text,
        _commentController.text);
    _refreshData();
  }

  Future<void> getList() async {}

  Future<void> _updateData(int id) async {
    await LocalRefueling.updateData(
        id,
        // _typeFuelController.text,
        dropdownvalue,
        dropdownvalueCar,
        // _autoCarController.text,
        int.parse(_countController.text),
        int.parse(_summaController.text),
        _addressController.text,
        _commentController.text);
    _refreshData();
  }

  void _deleteData(int id, BuildContext context) async {
    await LocalRefueling.deleteData(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,

        //backgroundColor: Colors.redAccent,
        content: Text(
          'Запись заправки удалена',
        ),
      ),
    );

    _refreshData();
  }

  String _getStringDate(String date) {
    String formattedDate = date.toString().substring(0, 10);

    return formattedDate;
  }

  // final TextEditingController _typeFuelController = TextEditingController();
  // final TextEditingController _autoCarController = TextEditingController();
  final TextEditingController _countController = TextEditingController();
  final TextEditingController _summaController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  void showBottomSheet(int? id, int index) async {
    // _getCarsList(userId).then((result) {
    //   setState(() {
    //     itemsCar = result;
    //   });
    // });
    // var itemsCarD = [];
    // List<DropdownMenuItem<String>> itemsCar = [];

    for (int indexx = 0; indexx < itemsCars.length; indexx++) {
      // print(itemsCars[index]['brand'] + " " + itemsCars[index]['model']);
      String car =
          itemsCars[indexx]['brand'] + " " + itemsCars[indexx]['model'];
      itemsCarD.add(car);
      print(car);
    }
    if (id == null) {
      dropdownvalueCar = itemsCarD[0];
    }
    // for (var item in itemsCarD) {
    //   itemsCar.add(DropdownMenuItem<String>(value: item, child: Text(item)));
    //   print(itemsCar);
    // }

    if (id != null) {
      final existingData =
          _allData.firstWhere((element) => element['id'] == id);
      dropdownvalue = existingData['typeFuel'];
      // _autoCarController.text = existingData['autoCar'];
      dropdownvalueCar = existingData['autoCar'];
      _countController.text = existingData['count'].toString();
      _summaController.text = existingData['summa'].toString();
      _addressController.text = existingData['address'];
      _commentController.text = existingData['comment'];
    }

    //final MediaQueryData mediaQueryData = MediaQuery.of(context);
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
                    value: dropdownvalueCar,

                    // Down Arrow Icon
                    // icon: SvgPicture.asset(AppIcons.icCar),
                    icon: const Icon(Icons.arrow_drop_down),
                    // Array list of items
                    items: itemsCarD.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (var newValue) {
                      setState(() {
                        dropdownvalueCar = newValue!.toString();
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                  width: 30,
                ),
                //////////////////////////////////////////////////////////////////////
                Container(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: DropdownButton(
                    // Initial Value
                    value: dropdownvalue,

                    // Down Arrow Icon
                    icon: const Icon(Icons.arrow_drop_down),

                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue.toString();
                      });
                      // setState(() {});
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _countController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      // errorText: "",
                      border: OutlineInputBorder(),
                      labelText: "Количество",
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _summaController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Сумма",
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
            const SizedBox(height: 20),
            TextField(
              controller: _commentController,
              maxLines: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Комментарий",
              ),
            ),
            const SizedBox(height: 20),
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
                    _countController.text = "";
                    _summaController.text = "";
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
              user["autoCar"]
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              user["typeFuel"]
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              user["count"]
                  .toString()
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              user["summa"]
                  .toString()
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
      appBar: Toolbar(
        title: AppStrings.refueling,
        actions: [
          // IconButton(
          //   icon: const Icon(
          //     Icons.search,
          //     color: Color.fromARGB(255, 255, 255, 255),
          //   ),
          //   onPressed: () => {
          //     // showBottomSheet(null),
          //   },
          // ),
          IconButton(
            icon: const Icon(
              Icons.post_add,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            onPressed: () => {
              showBottomSheet(null, 0),
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // const SizedBox(
          //   height: 20,
          // ),
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
          // const SizedBox(
          //   height: 20,
          // ),
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
                            left: 16,
                            top: 8,
                            right: 16,
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                leading: SvgPicture.asset(AppIcons.icCar),
                                onTap: () {
                                  showBottomSheet(_allData[index]['id'], index);
                                },
                                title: Text(
                                  _foundUsers[index]['autoCar'],
                                  style: AppText.header1,
                                ),
                                subtitle: Text(
                                  _foundUsers[index]['typeFuel'],
                                ),
                                trailing: Text(
                                  _foundUsers[index]['count'].toString() +
                                      " л.",
                                  style: AppText.header2,
                                ),
                              ),
                              ListTile(
                                leading:
                                    SvgPicture.asset(AppIcons.icRefulingWhite),
                                onTap: () {
                                  showBottomSheet(_allData[index]['id'], index);
                                },
                                title: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                  ),
                                  child: Text(
                                    _getStringDate(
                                        _foundUsers[index]['createdAt']),
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                trailing: Text(
                                  _foundUsers[index]['summa'].toString() +
                                      " р.",
                                  style: AppText.header3,
                                ),
                                // trailing: Row(
                                //   mainAxisSize: MainAxisSize.min,
                                //   children: [
                                //     // IconButton(
                                //     //   onPressed: () {
                                //     //     showBottomSheet(_allData[index]['id']);
                                //     //   },
                                //     //   icon: const Icon(
                                //     //     Icons.edit,
                                //     //     color: Colors.indigo,
                                //     //   ),
                                //     // ),
                                //     // IconButton(
                                //     //   onPressed: () {
                                //     //     _deleteData(
                                //     //         _allData[index]['id'], context);
                                //     //   },
                                //     //   icon: const Icon(
                                //     //     Icons.delete,
                                //     //     color: Colors.red,
                                //     //   ),
                                //     // ),
                                //   ],
                                // ),
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
