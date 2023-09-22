import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:avtorepair/components/toolbar.dart';
import 'package:avtorepair/config/app_icons.dart';
import 'package:avtorepair/config/app_strings.dart';

class NearbyPage extends StatelessWidget {
  const NearbyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Toolbar(
        title: AppStrings.nearby,
      ),
      body: FlutterMap(
        options: MapOptions(
          center: const LatLng(56.495802, 60.236307),
          zoom: 10,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: const LatLng(56.495802, 60.236307),
                width: 100,
                height: 50,
                builder: (context) {
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                        ),
                        child: const Text(
                          "Username",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SvgPicture.asset(
                        AppIcons.icLocation,
                        colorFilter: const ColorFilter.mode(
                          Colors.black,
                          BlendMode.srcIn,
                        ),
                      )
                    ],
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
