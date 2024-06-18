// import 'package:avtorepair/pages/car_profile/car_profile_page.dart';
import 'dart:convert';


// import 'package:avtorepair/components/user_avatar.dart';
import 'package:avtorepair/config/api_config.dart';
// import 'package:avtorepair/services/local_db/local_garage.dart';
import 'package:flutter/material.dart';
import 'package:avtorepair/components/toolbar.dart';

import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GaragePage extends StatefulWidget {
  final token;

  // const GaragePage({super.key});
  const GaragePage({@required this.token, Key? key}) : super(key: key);
  @override
  State<GaragePage> createState() => _GaragePageState();
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
    // List itemsCars = [];
    print(222);
    print(list.runtimeType);
    // print(allData.runtimeType);
    // print(itemsCars.runtimeType);
    // = allData['success'];

    // return itemsCars;
    return list;
    // setState(() {});
  } else {
    print(response.reasonPhrase);
    throw Exception('Failed to load data');
  }
}

class _GaragePageState extends State<GaragePage> {
  late String userId;
  late String email;
  String? avto = '';
  int? idMainAvto;

  List itemsCars = [];
  late SharedPreferences prefs;

  // List<Map<String, dynamic>> _allData = [];
  bool _isLoading = true;

  String dropdownValueTypeRefu = '95 бензин';
  String dropdownValueTypeBody = 'Седан';
  String dropdownValueTransmission = 'Механика';

  var itemsTypeRefu = [
    '92 бензин',
    '95 бензин',
    '98 бензин',
    'Дизель',
    'Электро',
    'Газ',
  ];

  var itemsTypeBody = [
    'Седан',
    'Хэтчбек',
    'Универсал',
    'Купе',
    'Кабриолет',
    'Минивэн',
    'Внедорожник',
    'Кроссовер',
    'Спецавтомобиль',
  ];

  var itemsTransmission = [
    'Механика',
    'Автомат',
    'Робот',
    'Селектор',
  ];

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    avto = prefs.getString('mainAvto');
    idMainAvto = prefs.getInt('idMainAvto');
  }

  @override
  void initState() {
    super.initState();
    initSharedPref();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
    email = jwtDecodedToken['email'].toString();

    _refreshData();

    _getCarsList(userId).then((result) {
      setState(() {
        itemsCars = result;
      });
    });

    print(itemsCars);
  }

  void _refreshData() async {
    // final data = await LocalGarage.getAllData();

    // final data2 = await getCarsList(userId);
    setState(() {
      // _allData = data;
      // itemsCars = data2;
      _isLoading = false;
    });
  }

  void createCarNode() async {
    print('func register start');
    if (_brandController.text.isNotEmpty && _modelController.text.isNotEmpty) {
      var regBody = {
        "userId": userId,
        "brand": _brandController.text,
        "model": _modelController.text,
        "mileage": _mileageController.text,
        "yearIssue": _yearIssueController.text,
        "typeFuel": dropdownValueTypeRefu,
        "volumeTank": _volumeTankController.text,
        "number": _numberController.text,
        "vin": _vinController.text,
        "carBody": dropdownValueTypeBody,
        "transmission": dropdownValueTransmission,
        "engineVolume": _engineVolumeController.text,
        "enginePower": _enginePowerController.text
      };
      print(regBody);
      var response = await http.post(Uri.parse(createCar),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['status']);
      if (jsonResponse['status']) {
        // Navigator.of(context).pushReplacementNamed(AppRoutes.login);
        _getCarsList(userId).then((result) {
          setState(() {
            itemsCars = result;
          });
        });
        print(jsonResponse);
      } else {
        print('SomeThing Went Wrong');
      }
    } else {
      setState(() {
        // _isNotValidate = true;
      });
    }
  }

  void updateCarNode(_id) async {
    print('func update Car start');

    var headers = {'Content-Type': 'application/json'};
    if (_brandController.text.isNotEmpty && _modelController.text.isNotEmpty) {
      var request = http.Request('PUT', Uri.parse('$updateCar/' + _id));
      print(request);
      request.body = json.encode({
        "userId": userId,
        "brand": _brandController.text,
        "model": _modelController.text,
        "mileage": _mileageController.text,
        "yearIssue": _yearIssueController.text,
        "typeFuel": dropdownValueTypeRefu,
        "volumeTank": _volumeTankController.text,
        "number": _numberController.text,
        "vin": _vinController.text,
        "carBody": dropdownValueTypeBody,
        "transmission": dropdownValueTransmission,
        "engineVolume": _engineVolumeController.text,
        "enginePower": _enginePowerController.text
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        print('gooooooood');
        _getCarsList(userId).then((result) {
          setState(() {
            itemsCars = result;
          });
        });
      } else {
        print(response.reasonPhrase);
      }
    } else {
      setState(() {
        // _isNotValidate = true;
      });
    }
  }

  void deleteItem(id) async {
    var regBody = {"id": id};
    var response = await http.post(Uri.parse(deleteCar),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody));
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status']) {
      _getCarsList(userId).then((result) {
        setState(() {
          itemsCars = result;
        });
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Запись удалена',
          ),
        ),
      );
      // getTodoList(userId);
    }
  }

  // Future<void> _addData() async {
  //   await LocalGarage.createdData(
  //       _brandController.text,
  //       _modelController.text,
  //       _mileageController.text,
  //       _yearIssueController.text,
  //       // _typeFuelController.text,
  //       _volumeTankController.text,
  //       _numberController.text,
  //       _vinController.text,
  //       _carBodyController.text,
  //       _transmissionController.text,
  //       _engineVolumeController.text,
  //       _enginePowerController.text);
  //   _refreshData();

  //   createCarNode();
  // }

  Future<void> _updateData(int id) async {
    // await LocalGarage.updateData(
    //     id,
    //     _brandController.text,
    //     _modelController.text,
    //     _mileageController.text,
    //     _yearIssueController.text,
    //     // _typeFuelController.text,
    //     _volumeTankController.text,
    //     _numberController.text,
    //     _vinController.text,
    //     _carBodyController.text,
    //     _transmissionController.text,
    //     _engineVolumeController.text,
    //     _enginePowerController.text);
    // _refreshData();
  }

  // void _deleteData(int id, BuildContext context) async {
  //   await LocalGarage.deleteData(id);
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(
  //       content: Text(
  //         'Запись удалена',
  //       ),
  //     ),
  //   );
  //   _refreshData();
  // }

  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _mileageController = TextEditingController();
  final TextEditingController _yearIssueController = TextEditingController();
  // final TextEditingController _typeFuelController = TextEditingController();
  final TextEditingController _volumeTankController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _vinController = TextEditingController();
  // final TextEditingController _carBodyController = TextEditingController();
  // final TextEditingController _transmissionController = TextEditingController();
  final TextEditingController _engineVolumeController = TextEditingController();
  final TextEditingController _enginePowerController = TextEditingController();

  void showBottomSheet(String? id) async {
    if (id != null) {
      final existingData =
          itemsCars.firstWhere((element) => element['_id'] == id);
      print(existingData);
      _brandController.text = existingData['brand'];
      _modelController.text = existingData['model'];
      _mileageController.text = existingData['mileage'];
      _yearIssueController.text = existingData['yearIssue'];
      dropdownValueTypeRefu = existingData['typeFuel'];
      _volumeTankController.text = existingData['volumeTank'];
      _numberController.text = existingData['number'];
      _vinController.text = existingData['vin'];
      dropdownValueTypeBody = existingData['carBody'];
      dropdownValueTransmission = existingData['transmission'];
      _engineVolumeController.text = existingData['engineVolume'];
      _enginePowerController.text = existingData['enginePower'];
    } else {
      _brandController.text = "";
      _modelController.text = "";
      _mileageController.text = "";
      _yearIssueController.text = "";
      // _typeFuelController.text = "";
      _volumeTankController.text = "";
      _numberController.text = "";
      _vinController.text = "";
      // _carBodyController.text = "";
      // _transmissionController.text = "";
      _engineVolumeController.text = "";
      _enginePowerController.text = "";
    }

    //final MediaQueryData mediaQueryData = MediaQuery.of(context);
    showModalBottomSheet(
      elevation: 5,
      //isDismissible: true,
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: 50,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom + 50,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // const UserAvatar(
              //   size: 120,
              // ),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _brandController,
                      decoration: const InputDecoration(
                        // errorText: "",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),

                        labelText: "Марка",
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _modelController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        labelText: "Модель",
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _mileageController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        // errorText: "",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        labelText: "Пробег",
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _yearIssueController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        labelText: "Год выпуска",
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _volumeTankController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        // errorText: "",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        labelText: "Объем бака",
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _numberController,
                      // keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        labelText: "Госномер",
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _vinController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  // hintText: "VIN",
                  labelText: "VIN",
                ),
              ),
              const SizedBox(height: 10),

              const Center(child: Text('Тип кузова')),
              // const SizedBox(height: 10),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 16, right: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: DropdownButton(
                  value: dropdownValueTypeBody,
                  icon: const Icon(Icons.arrow_drop_down),
                  items: itemsTypeBody.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(
                        items,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValueTypeBody = newValue!.toString();
                    });
                  },
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Трансмиссия'),
                    Text('Тип топлива'),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: DropdownButton(
                      value: dropdownValueTransmission,
                      icon: const Icon(Icons.arrow_drop_down),

                      // Array list of items
                      items: itemsTransmission.map((String items) {
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

                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValueTransmission = newValue!.toString();
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                    width: 30,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: DropdownButton(
                      // Initial Value
                      value: dropdownValueTypeRefu,

                      // Down Arrow Icon
                      icon: const Icon(Icons.arrow_drop_down),

                      // Array list of items
                      items: itemsTypeRefu.map((String items) {
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

                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValueTypeRefu = newValue!.toString();
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              const Center(child: Text('Двигатель')),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _engineVolumeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        // errorText: "",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        labelText: "Объем",
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _enginePowerController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        labelText: "Мощность",
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (id == null) {
                      //  await _addData();
                      createCarNode();
                      print(1);
                    }
                    if (id != null) {
                      // await _updateData(id);
                      updateCarNode(id);
                      setState(() {});
                      print(2);
                    }
                    _brandController.text = "";
                    _modelController.text = "";
                    _mileageController.text = "";
                    _yearIssueController.text = "";
                    // _typeFuelController.text = "";
                    _volumeTankController.text = "";
                    _numberController.text = "";
                    _vinController.text = "";
                    // _carBodyController.text = "";
                    // _transmissionController.text = "";
                    _engineVolumeController.text = "";
                    _enginePowerController.text = "";
                    setState(() {});
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
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Toolbar(
        title: "Гараж",
        actions: [
          IconButton(
            icon: const Icon(Icons.post_add,
                color: Color.fromARGB(255, 255, 255, 255)),
            onPressed: () => {
              showBottomSheet(null),
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('Основное авто: $avto')),
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    // itemCount: _allData.length,
                    itemCount: itemsCars.length,
                    itemBuilder: (context, index) => Card(
                      margin: const EdgeInsets.only(
                        left: 15,
                        top: 10,
                        right: 15,
                      ),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                          ),
                          child: Text(
                            itemsCars[index]['brand'],
                            // itemsCars![index]['_id'],
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        // subtitle: Text(_allData[index]['mileage']),
                        subtitle: Text(itemsCars[index]['model']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                showBottomSheet(itemsCars[index]['_id']);
                                print(itemsCars[index]['_id']);
                                // showBottomSheet(_allData[index]['id']);
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.indigo,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                deleteItem(itemsCars[index]['_id']);
                                // _deleteData(_allData[index]['id'], context);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                            IconButton(
                              // onPressed: () async {
                              onPressed: () async {
                                avto = itemsCars[index]['brand'];

                                // idMainAvto = itemsCars[index]['_id'] as int;
                                idMainAvto = index;
                                await prefs.setString('mainAvto', avto!);
                                await prefs.setInt('idMainAvto', idMainAvto!);
                                setState(() {});
                                // Navigator.pop(context, true);
                              },
                              icon: const Icon(
                                Icons.check_box,
                                color: Color.fromARGB(255, 184, 166, 165),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

// class GarageArguments {
//   final int index;
//   final String brand;
//   final String model;
//   final String mileage;
//   final String yearIssue;
//   final String typeFuel;
//   final String transmission;
//   final String carBody;
//   final String engineVolume;
//   final String enginePower;
//   final String volumeTank;
//   final String vin;
//   GarageArguments(
//     this.index,
//     this.brand,
//     this.model,
//     this.mileage,
//     this.yearIssue,
//     this.typeFuel,
//     this.transmission,
//     this.carBody,
//     this.engineVolume,
//     this.enginePower,
//     this.volumeTank,
//     this.vin,
//   );
// }
// class GarageArguments {
//   // final int index;
//   final int index;

//   GarageArguments(
//     this.index,
//   );
// }
