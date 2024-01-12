import 'package:avtorepair/services/local_db/local_garage.dart';
import 'package:flutter/material.dart';
import 'package:avtorepair/components/toolbar.dart';

class GaragePage extends StatefulWidget {
  const GaragePage({super.key});

  @override
  State<GaragePage> createState() => _GaragePageState();
}

class _GaragePageState extends State<GaragePage> {
  List<Map<String, dynamic>> _allData = [];
  bool _isLoading = true;

  void _refreshData() async {
    final data = await LocalGarage.getAllData();
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
    await LocalGarage.createdData(
        _brandController.text,
        _modelController.text,
        _mileageController.text,
        _yearIssueController.text,
        _typeFuelController.text,
        _volumeTankController.text,
        _numberController.text,
        _vinController.text,
        _carBodyController.text,
        _transmissionController.text,
        _engineVolumeController.text,
        _enginePowerController.text);
    _refreshData();
  }

  Future<void> _updateData(int id) async {
    await LocalGarage.updateData(
        id,
        _brandController.text,
        _modelController.text,
        _mileageController.text,
        _yearIssueController.text,
        _typeFuelController.text,
        _volumeTankController.text,
        _numberController.text,
        _vinController.text,
        _carBodyController.text,
        _transmissionController.text,
        _engineVolumeController.text,
        _enginePowerController.text);
    _refreshData();
  }

  void _deleteData(int id, BuildContext context) async {
    await LocalGarage.deleteData(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Запись удалена',
        ),
      ),
    );
    _refreshData();
  }

  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _mileageController = TextEditingController();
  final TextEditingController _yearIssueController = TextEditingController();
  final TextEditingController _typeFuelController = TextEditingController();
  final TextEditingController _volumeTankController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _vinController = TextEditingController();
  final TextEditingController _carBodyController = TextEditingController();
  final TextEditingController _transmissionController = TextEditingController();
  final TextEditingController _engineVolumeController = TextEditingController();
  final TextEditingController _enginePowerController = TextEditingController();

  void showBottomSheet(int? id) async {
    if (id != null) {
      final existingData =
          _allData.firstWhere((element) => element['id'] == id);
      _brandController.text = existingData['brand'];
      _modelController.text = existingData['model'];
      _mileageController.text = existingData['mileage'];
      _yearIssueController.text = existingData['yearIssue'];
      _typeFuelController.text = existingData['typeFuel'];
      _volumeTankController.text = existingData['volumeTank'];
      _numberController.text = existingData['number'];
      _vinController.text = existingData['vin'];
      _carBodyController.text = existingData['carBody'];
      _transmissionController.text = existingData['transmission'];
      _engineVolumeController.text = existingData['engineVolume'];
      _enginePowerController.text = existingData['enginePower'];
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
              TextField(
                controller: _brandController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Марка",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _modelController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Модель",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _mileageController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Пробег",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _yearIssueController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Год выпуска",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _typeFuelController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Вид топлива",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _volumeTankController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Объем бака",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _numberController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Госномер",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _vinController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "VIN",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _carBodyController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Кузов",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _transmissionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Трансмиссия",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _engineVolumeController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Двигатель объем",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _enginePowerController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Двигатель мощность",
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
                    _brandController.text = "";
                    _modelController.text = "";
                    _mileageController.text = "";
                    _yearIssueController.text = "";
                    _typeFuelController.text = "";
                    _volumeTankController.text = "";
                    _numberController.text = "";
                    _vinController.text = "";
                    _carBodyController.text = "";
                    _transmissionController.text = "";
                    _engineVolumeController.text = "";
                    _enginePowerController.text = "";
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
                      _allData[index]['brand'],
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  subtitle: Text(_allData[index]['mileage']),
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
