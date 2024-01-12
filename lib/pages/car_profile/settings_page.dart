import 'package:avtorepair/config/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:avtorepair/components/toolbar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Toolbar(
        title: "Настройки",
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app_outlined,
                color: Color.fromARGB(255, 255, 255, 255)),
            onPressed: () => {
              Navigator.of(context).pushReplacementNamed(AppRoutes.login),
            },
          ),
        ],
      ),
      body: const ListViewBuilder(),
    );
  }
}

class ListViewBuilder extends StatelessWidget {
  const ListViewBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              leading: const Icon(Icons.list),
              trailing: const Text(
                "изменить",
                style: TextStyle(color: Colors.green, fontSize: 15),
              ),
              title: Text("List item $index"));
        },
      ),
    );
  }
}
