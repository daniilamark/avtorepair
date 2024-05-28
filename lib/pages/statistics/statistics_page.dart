import 'package:avtorepair/pages/statistics/bar_chart_widget.dart';
import 'package:avtorepair/pages/statistics/data/price_point.dart';
import 'package:avtorepair/pages/statistics/data/sector.dart';
import 'package:avtorepair/pages/statistics/line_chart_widget.dart';
import 'package:avtorepair/pages/statistics/pie_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:avtorepair/components/toolbar.dart';
import 'package:avtorepair/config/app_strings.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Toolbar(
        title: AppStrings.statistics,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LineChartWidget(pricePoints),
              PieChartWidget(industrySectors),
              Column(
                children: industrySectors
                    .map<Widget>((sector) => SectorRow(sector))
                    .toList(),
              ),
              const Padding(padding: EdgeInsets.all(60)),
              const Text("Расходы"),
              BarChartWidget(points: pricePoints),
              const SizedBox(height: 50),
              const Text("Километраж"),
              BarChartWidget(points: pricePoints),
              const SizedBox(height: 300),
            ],
          ),
        ),
      ),
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
