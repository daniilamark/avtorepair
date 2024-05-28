import 'package:avtorepair/services/local_db/local_refueling.dart';
import 'package:avtorepair/styles/app_text.dart';
import 'package:flutter/material.dart';
import 'package:avtorepair/components/toolbar.dart';
import 'package:avtorepair/config/app_strings.dart';

class RefuelingPage extends StatefulWidget {
  const RefuelingPage({super.key});

  @override
  State<RefuelingPage> createState() => _RefuelingPageState();
}

class _RefuelingPageState extends State<RefuelingPage> {
  List<Map<String, dynamic>> _allData = [];
  bool _isLoading = true;

  String dropdownvalue = '95 бензин';

  // List of items in our dropdown menu
  var items = [
    '92 бензин',
    '95 бензин',
    'Дизель',
    'Электро',
  ];

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
  }

  Future<void> _addData() async {
    await LocalRefueling.createdData(
        // _typeFuelController.text,
        dropdownvalue,
        _autoCarController.text,
        _countController.text,
        _summaController.text,
        _addressController.text,
        _commentController.text);
    _refreshData();
  }

  Future<void> _updateData(int id) async {
    await LocalRefueling.updateData(
        id,
        // _typeFuelController.text,
        dropdownvalue,
        _autoCarController.text,
        _countController.text,
        _summaController.text,
        _addressController.text,
        _commentController.text);
    _refreshData();
  }

  void _deleteData(int id, BuildContext context) async {
    await LocalRefueling.deleteData(id);
    //List<Map<String, dynamic>> _data = await LocalRefueling.getSingleData(id);
    //final _data = await LocalRefueling.getSingleData(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        //backgroundColor: Colors.redAccent,
        content: Text(
          'Запись удалена',
        ),
      ),
    );

    //print(_data + "принял");
    //final textMy = _data[id]['typeFuel'];

    _refreshData();
  }

  // List<DropdownMenuItem<String>> get dropdownItems {
  //   List<DropdownMenuItem<String>> menuItems = [
  //     const DropdownMenuItem(value: "USA", child: Text("USA")),
  //     const DropdownMenuItem(value: "Canada", child: Text("Canada")),
  //     const DropdownMenuItem(value: "Brazil", child: Text("Brazil")),
  //     const DropdownMenuItem(value: "England", child: Text("England")),
  //   ];
  //   return menuItems;
  // }

  // final TextEditingController _typeFuelController = TextEditingController();
  final TextEditingController _autoCarController = TextEditingController();
  final TextEditingController _countController = TextEditingController();
  final TextEditingController _summaController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  void showBottomSheet(int? id) async {
    if (id != null) {
      final existingData =
          _allData.firstWhere((element) => element['id'] == id);
      dropdownvalue = existingData['typeFuel'];
      _autoCarController.text = existingData['autoCar'];
      _countController.text = existingData['count'];
      _summaController.text = existingData['summa'];
      _addressController.text = existingData['address'];
      _commentController.text = existingData['comment'];
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
            top: 40,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom + 100,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: _autoCarController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Авто",
                ),
              ),
              const SizedBox(height: 10),
              // TextField(
              //   controller: _typeFuelController,
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(),
              //     labelText: "Тип топлива",
              //   ),
              // ),
              Row(
                children: [
                  Text("Тип топлива"),
                  const SizedBox(width: 10),
                  DropdownButton(
                    // Initial Value
                    value: dropdownvalue,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!.toString();
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _countController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Количество",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _summaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Сумма",
                ),
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
              Center(
                child: ElevatedButton(
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

  List<Map<String, dynamic>> _foundUsers = [];

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
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
              showBottomSheet(null),
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
                            left: 15,
                            top: 10,
                            right: 15,
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                // leading: Icon(Icons.auto_awesome),
                                title: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5,
                                      ),
                                      child: Text(
                                        _foundUsers[index]['autoCar'],
                                        style: AppText.header1,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5,
                                      ),
                                      child: Text(
                                        _foundUsers[index]['typeFuel'],
                                        style: AppText.subtitle2,
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                    _foundUsers[index]['count'] + " литров"),
                              ),
                              ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                  ),
                                  child: Text(
                                    // GETTER FOR DATE
                                    _foundUsers[index]['createdAt'],
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                // subtitle: Text(_foundUsers[index]['count']),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        showBottomSheet(_allData[index]['id']);
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.indigo,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        _deleteData(
                                            _allData[index]['id'], context);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
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
