// import 'package:avtorepair/pages/statistics/bar_chart_widget.dart';
// import 'dart:js_interop';

import 'package:avtorepair/pages/statistics/data/price_point.dart';
import 'package:avtorepair/pages/statistics/data/sector.dart';
import 'package:avtorepair/pages/statistics/line_chart_widget.dart';
import 'package:avtorepair/pages/statistics/pie_chart_widget.dart';
import 'package:avtorepair/services/local_db/local_refueling.dart';
import 'package:collection/collection.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:avtorepair/pages/statistics/line_chart_widget.dart';
// import 'package:avtorepair/pages/statistics/pie_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:avtorepair/components/toolbar.dart';
import 'package:avtorepair/config/app_strings.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage>
    with SingleTickerProviderStateMixin {
  //

  late TabController _tabController;
  // String? _countFuel;

  // static String getCountFuel() {
  //   if (_countFuel.isNull){

  //   }
  //   return _countFuel!;
  // }
  // late double _dataCount;

  void _refreshData() async {
    double dataCountFuel = await LocalRefueling.getCountRefueling();

    print(dataCountFuel);
    setState(() {
      // _dataCount = data;
      // _countFuel = dataCountFuel as String;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: Toolbar(
        title: AppStrings.statistics,
      ),
      body:
          //  SingleChildScrollView(
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: <Widget>[
          //         // LineChartWidget(pricePoints),
          //         PieChartWidget(industrySectors),
          //         Column(
          //           children: industrySectors
          //               .map<Widget>((sector) => SectorRow(sector))
          //               .toList(),
          //         ),
          //         const Padding(padding: EdgeInsets.all(60)),
          //         // const Text("Расходы"),
          //         // BarChartWidget(points: pricePoints),
          //         // const SizedBox(height: 50),
          //         // const Text("Километраж"),
          //         // BarChartWidget(points: pricePoints),
          //         // const SizedBox(height: 300),
          //       ],
          //     ),
          //   ),
          // ),
          MyCustomTab(),
    );
  }
}

class SectorRow extends StatelessWidget {
  const SectorRow(this.sector, {Key? key}) : super(key: key);
  final Sector sector;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 16,
          child: CircleAvatar(
            backgroundColor: sector.color,
          ),
        ),
        const Spacer(),
        Text(sector.title),
      ],
    );
  }
}

class MyCustomTab extends StatefulWidget {
  const MyCustomTab({super.key});

  @override
  State<MyCustomTab> createState() => _MyCustomTabState();
}

class _MyCustomTabState extends State<MyCustomTab> {
  List<PricePoint> get pricePoints {
    // final Random random = Random();

    // double may = 3;
    // double dataCount = 2;
    final randomNumbers = <double>[1, 2, 3, 4, 8, 6, 7, 8, 9, 10, 11];
    return randomNumbers
        .mapIndexed(
            (index, element) => PricePoint(x: index.toDouble(), y: element))
        .toList();

    // for (var i = 0; i <= 11; i++) {
    //   randomNumbers.add(random.nextDouble());
    // }
  }

  List<PricePoint> get mileagePoints {
    // final Random random = Random();

    // double may = 3;
    // double dataCount = 2;
    final randomNumbers = <double>[
      2000,
      3000,
      4000,
      5600,
      6700,
      1000,
      7000,
      5000,
      9000,
      17000,
      3000,
      7000,
    ];
    return randomNumbers
        .mapIndexed(
            (index, element) => PricePoint(x: index.toDouble(), y: element))
        .toList();

    // for (var i = 0; i <= 11; i++) {
    //   randomNumbers.add(random.nextDouble());
    // }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            //  mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // ignore: prefer_const_literals_to_create_immutables
              Container(
                // height: 50,
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(20),
                //     color: Color.fromARGB(255, 112, 93, 92)),
                child: const TabBar(
                  // indicator: BoxDecoration(
                  //   color: Colors.red[800],
                  //   borderRadius: BorderRadius.circular(20),
                  // ),
                  // labelColor: Colors.black,
                  // dividerColor: Colors.black,
                  // ignore: prefer_const_literals_to_create_immutables
                  tabs: [
                    Tab(icon: Icon(Icons.account_balance_wallet)),
                    Tab(icon: Icon(Icons.leaderboard)),
                    Tab(icon: Icon(Icons.directions_car)),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 48.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // LineChartWidget(pricePoints),
                          PieChartWidget(industrySectors),
                          Column(
                            children: industrySectors
                                .map<Widget>((sector) => SectorRow(sector))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 48.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text("Всего литров: "),
                              // Text(getCountFuel()),
                            ],
                          ),
                          // BarChartWidget(
                          //   points: pricePoints,
                          // ),
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 48.0),
                      child: LineChartWidget(
                        mileagePoints,
                      ),
                    ),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
