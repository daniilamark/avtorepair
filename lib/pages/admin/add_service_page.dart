// import 'dart:convert';
import 'dart:convert';

import 'package:avtorepair/config/api_config.dart';
import 'package:http/http.dart' as http;
// import 'package:avtorepair/config/api_config.dart';
// import 'package:avtorepair/pages/auth/registration_page.dart';
// import 'package:avtorepair/pages/main_page.dart';

import 'package:avtorepair/components/toolbar.dart';
import 'package:flutter/material.dart';
// import 'package:avtorepair/config/app_routes.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

class AddServicePage extends StatefulWidget {
  const AddServicePage({super.key});

  @override
  State<AddServicePage> createState() => _AddServicePageState();
}

Future<List> _getServiceList() async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request('GET', Uri.parse(getServiceList));

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

    return list;
  } else {
    print(response.reasonPhrase);
    throw Exception('Failed to load data');
  }
}

class _AddServicePageState extends State<AddServicePage> {
  // List<Map<String, dynamic>> _allData = [];
  bool _isLoading = true;

  List modelsCars = [];
  List _foundModels = [];

  @override
  void initState() {
    super.initState();

    _getServiceList().then((result) {
      setState(() {
        modelsCars = result;
        _foundModels = result;
        // print(modelsCars);
      });
    });

    _refreshData();
    // print(modelsCars);
  }

  void _refreshData() async {
    // final data = modelsCars;

    // print(listOfMaps);
    setState(() {
      _isLoading = false;
      // _allData = data;
      _foundModels = modelsCars;
    });
  }

  void createServiceNode() async {
    print('func register start');
    if (_modelCarController.text.isNotEmpty &&
        _descCarController.text.isNotEmpty &&
        _milliCarController.text.isNotEmpty) {
      var regBody = {
        "model": _modelCarController.text,
        "desc": _descCarController.text,
        "milli": _milliCarController.text
      };
      print(regBody);
      var response = await http.post(Uri.parse(createService),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['status']);
      if (jsonResponse['status']) {
        // Navigator.of(context).pushReplacementNamed(AppRoutes.login);
        _getServiceList().then((result) {
          setState(() {
            _foundModels = result;
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

  void updateServiceNode(_id) async {
    print('func update Car start');

    var headers = {'Content-Type': 'application/json'};
    if (_modelCarController.text.isNotEmpty &&
        _descCarController.text.isNotEmpty &&
        _milliCarController.text.isNotEmpty) {
      var request = http.Request('PUT', Uri.parse('$updateServiceCar/' + _id));
      print(request);
      request.body = json.encode({
        "model": _modelCarController.text,
        "desc": _descCarController.text,
        "milli": _milliCarController.text
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // print(await response.stream.bytesToString());
        // print('gooooooood');
        _getServiceList().then((result) {
          setState(() {
            _foundModels = result;
          });
        });
      } else {
        // print(response.reasonPhrase);
      }
    } else {
      setState(() {
        // _isNotValidate = true;
      });
    }
  }

  void deleteItem(id) async {
    var regBody = {"id": id};
    var response = await http.post(Uri.parse(deleteService),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody));
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status']) {
      _getServiceList().then((result) {
        setState(() {
          _foundModels = result;
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

  final TextEditingController _modelCarController = TextEditingController();
  final TextEditingController _descCarController = TextEditingController();
  final TextEditingController _milliCarController = TextEditingController();

  void showBottomSheet(String? id) async {
    if (id != null) {
      final existingData =
          _foundModels.firstWhere((element) => element['_id'] == id);
      print(existingData);

      _modelCarController.text = existingData['model'];
      _descCarController.text = existingData['desc'];
      _milliCarController.text = existingData['milli'];
    } else {
      _modelCarController.text = "";
      _descCarController.text = "";
      _milliCarController.text = "";
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
            bottom: MediaQuery.of(context).viewInsets.bottom + 80,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: _modelCarController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  labelText: "Модель",
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _descCarController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  labelText: "Название сервиса",
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _milliCarController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  labelText: "Через сколько км",
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (id == null) {
                      //  await _addData();
                      // createCarNode();
                      createServiceNode();
                      setState(() {});
                      print(1);
                    }
                    if (id != null) {
                      // await _updateData(id);
                      // updateCarNode(id);
                      updateServiceNode(id);
                      setState(() {});
                      print(2);
                    }

                    _modelCarController.text = "";
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

  void _runFilter(String enteredKeyword) {
    List results = [];
    // _foundModels

    if (enteredKeyword.isEmpty) {
      results = modelsCars;
    } else {
      results = modelsCars
          .where((user) => user["model"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundModels = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Toolbar(
        title: 'Сервис',
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
      body: Column(children: [
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
              : ListView.builder(
                  // itemCount: _allData.length,
                  itemCount: _foundModels.length,
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
                          // modelsCars[index]['model'],
                          _foundModels[index]['model'],
                          // itemsCars![index]['_id'],
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      subtitle: Text(_foundModels[index]['desc']),
                      // subtitle: Text(modelsCars[index]['model']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(_foundModels[index]['milli'] + ' км'),
                          IconButton(
                            onPressed: () {
                              // showBottomSheet(modelsCars[index]['_id']);
                              showBottomSheet(_foundModels[index]['_id']);
                              print(_foundModels[index]['_id']);
                              // print(modelsCars[index]['_id']);
                              // showBottomSheet(_allData[index]['id']);
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.indigo,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // deleteItem(modelsCars[index]['_id']);
                              deleteItem(_foundModels[index]['_id']);
                              // _deleteData(_allData[index]['id'], context);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ]),
    );
  }
}
