import 'package:avtorepair/services/local_db/local_refueling.dart';
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

  void _refreshData() async {
    final data = await LocalRefueling.getAllData();
    setState(() {
      _allData = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _addData() async {
    await LocalRefueling.createdData(
        _typeFuelController.text,
        _countController.text,
        _summaController.text,
        _addressController.text,
        _commentController.text);
    _refreshData();
  }

  Future<void> _updateData(int id) async {
    await LocalRefueling.updateData(
        id,
        _typeFuelController.text,
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

  final TextEditingController _typeFuelController = TextEditingController();
  final TextEditingController _countController = TextEditingController();
  final TextEditingController _summaController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  void showBottomSheet(int? id) async {
    if (id != null) {
      final existingData =
          _allData.firstWhere((element) => element['id'] == id);
      _typeFuelController.text = existingData['typeFuel'];
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
                controller: _typeFuelController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Тип топлива",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _countController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Количество",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _summaController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Сумма",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Адрес",
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _commentController,
                maxLines: 4,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Комментарий",
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
                    _typeFuelController.text = "";
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Toolbar(
        title: AppStrings.refueling,
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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _allData.length,
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
                      _allData[index]['typeFuel'],
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  subtitle: Text(_allData[index]['count']),
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
                          _deleteData(_allData[index]['id'], context);
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
    );
  }
}
