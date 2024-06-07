import 'dart:math';
import 'dart:async';
import 'package:avtorepair/components/toolbar.dart';
import 'package:avtorepair/config/app_strings.dart';
import 'package:avtorepair/services/map/clusterized_icon_painter.dart';
import 'package:avtorepair/services/map/event_map.dart';
import 'package:avtorepair/services/map/map_point.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Map<DateTime, List<EventMap>> events = {};
  final TextEditingController _eventController = TextEditingController();
  // late final ValueNotifier<List<EventMap>> _selectedEvents;
  final List<MapObject> mapObjects = [];
  // final MapObjectId mapObjectId = const MapObjectId('map_object_collection');

// ///////////////////////////////////////////////////////////////////
  /// Контроллер для управления картами
  late final YandexMapController _mapController;
  final animation =
      const MapAnimation(type: MapAnimationType.smooth, duration: 2.0);

  /// Значение текущего масштаба карты
  var _mapZoom = 0.0;

  /// Данные о местоположении пользователя
  CameraPosition? _userLocation;

  /// Список точек на карте, по которым строится выделенная область
  //List<Point>? _polygonPointsList;

  /// Список точек на карте, по которым строится автомобильный маршрут
  List<Point> _drivingPointsList = [];

  /// Список точек для сохранения
  List<Point> _myPointsList = [];

  /// Результаты поиска маршрутов на карте
  DrivingResultWithSession? _drivingResultWithSession;

  /// Список объектов линий на карте, которые отображают маршруты
  List<PolylineMapObject> _drivingMapLines = [];

  @override
  void dispose() {
    _mapController.dispose();
    _drivingResultWithSession?.session.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Toolbar(
        title: AppStrings.routingMaps,
        actions: [
          IconButton(
            icon: const Icon(Icons.post_add,
                color: Color.fromARGB(255, 255, 255, 255)),
            onPressed: () => {},
          ),
        ],
      ),
      body: YandexMap(
        onMapCreated: (controller) async {
          _mapController = controller;
          await _initLocationLayer();
        },
        onCameraPositionChanged: (cameraPosition, _, __) {
          setState(() {
            _mapZoom = cameraPosition.zoom;
          });
        },
        onMapTap: (argument) {
          setState(() {
            // добавляем точку на
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  // icon: Icon(
                  //   Icons.map_outlined,
                  //   color: Color.fromARGB(255, 255, 255, 255),
                  // ),
                  scrollable: true,
                  title: const Text("Добавить"),
                  content: Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Событие',
                      ),
                      controller: _eventController,
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Отмена"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // events.addAll(
                        //   {
                        //     _selectedDay!: [
                        //       Event(_eventController.text),
                        //     ]
                        //   },
                        // );
                        // добавляем точку на карте
                        _myPointsList.add(argument);
                        if (_myPointsList.length == 1) {
                          _drivingPointsList.add(argument);
                        } else {
                          _drivingPointsList = [];
                          _drivingMapLines = [];
                          _drivingResultWithSession = null;
                        }
                        Navigator.of(context).pop();
                        // _selectedEvents.value = _getEventsForDay(_selectedDay!);
                      },
                      child: const Text("ОК"),
                    ),
                  ],
                );
              },
            );
          });
        },
        onMapLongTap: (argument) {
          setState(() {
            // добавляем точку маршрута на карте, если еще не выбраны две точки
            if (_drivingPointsList.length < 2) {
              _drivingPointsList.add(argument);
            } else {
              _drivingPointsList = [];
              _drivingMapLines = [];
              _drivingResultWithSession = null;
            }

            // когда выбраны точки начала и конца,
            // получаем данные предложенных маршрутов
            if (_drivingPointsList.length == 2) {
              _drivingResultWithSession = _getDrivingResultWithSession(
                startPoint: _drivingPointsList.first,
                endPoint: _drivingPointsList.last,
              );
            }
          });

          _buildRoutes();
        },
        mapObjects: [
          // mapObjects,
          _getClusterizedCollection(
            placemarks: _getPlacemarkObjects(context),
          ),
          //_getPolygonMapObject(context, points: _polygonPointsList ?? []),
          ..._getDrivingPlacemarks(context, drivingPoints: _drivingPointsList),
          ..._drivingMapLines,

          // ..._getMyPlacemarks(context, myPoints: _myPointsList),
        ],
        onUserLocationAdded: (view) async {
          // получаем местоположение пользователя
          _userLocation = await _mapController.getUserCameraPosition();
          // если местоположение найдено, центрируем карту относительно этой точки
          if (_userLocation != null) {
            await _mapController.moveCamera(
              CameraUpdate.newCameraPosition(
                _userLocation!.copyWith(zoom: 10),
              ),
              animation: const MapAnimation(
                type: MapAnimationType.linear,
                duration: 0.3,
              ),
            );
          }
          // меняем внешний вид маркера - делаем его непрозрачным
          return view.copyWith(
            pin: view.pin.copyWith(
              opacity: 1,
            ),
          );
        },
      ),
      floatingActionButton: Column(
        children: [
          const SizedBox(
            height: 380,
          ),
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              _zoomIn();
            },
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            child: const Icon(Icons.remove),
            onPressed: () {
              _zoomOut();
            },
          )
        ],
      ),
    );
  }

  Future<void> _zoomIn() async {
    // YandexMapController controller = await _c
    _mapController.moveCamera(CameraUpdate.zoomIn(), animation: animation);
  }

  Future<void> _zoomOut() async {
    // YandexMapController controller = await _c
    _mapController.moveCamera(CameraUpdate.zoomOut(), animation: animation);
  }

  /// Метод для получения коллекции кластеризованных маркеров
  ClusterizedPlacemarkCollection _getClusterizedCollection({
    required List<PlacemarkMapObject> placemarks,
  }) {
    return ClusterizedPlacemarkCollection(
        mapId: const MapObjectId('clusterized-1'),
        placemarks: placemarks,
        radius: 50,
        minZoom: 15,
        onClusterAdded: (self, cluster) async {
          return cluster.copyWith(
            appearance: cluster.appearance.copyWith(
              opacity: 1.0,
              icon: PlacemarkIcon.single(
                PlacemarkIconStyle(
                  image: BitmapDescriptor.fromBytes(
                    await ClusterIconPainter(cluster.size)
                        .getClusterIconBytes(),
                  ),
                ),
              ),
            ),
          );
        },
        onClusterTap: (self, cluster) async {
          await _mapController.moveCamera(
            animation: const MapAnimation(
                type: MapAnimationType.linear, duration: 0.3),
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: cluster.placemarks.first.point,
                zoom: _mapZoom + 1,
              ),
            ),
          );
        });
  }

  /// Метод, который включает слой местоположения пользователя на карте
  /// Выполняется проверка на доступ к местоположению, в случае отсутствия
  /// разрешения - выводит сообщение
  Future<void> _initLocationLayer() async {
    final locationPermissionIsGranted =
        await Permission.location.request().isGranted;

    if (locationPermissionIsGranted) {
      await _mapController.toggleUserLayer(visible: true);
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Нет доступа к местоположению пользователя'),
          ),
        );
      });
    }
  }

  /// Метод построения маршрутов линиями на карте
  /// Получает список возможных маршрутов и добавляет их линиями на карту
  Future<void> _buildRoutes() async {
    final drivingResult = await _drivingResultWithSession?.result;

    setState(() {
      for (var element in drivingResult?.routes ?? []) {
        _drivingMapLines.add(
          PolylineMapObject(
            mapId: MapObjectId('route $element'),
            polyline: Polyline(points: element.geometry),
            strokeColor:
                // генерируем случайный цвет для каждого маршрута
                Colors.primaries[Random().nextInt(Colors.primaries.length)],
            strokeWidth: 3,
          ),
        );
      }
    });
  }

  //
}

/// Метод для генерации точек на карте
List<MapPoint> _getMapPoints() {
  return const [
    MapPoint(name: 'РГППУ', latitude: 56.886258, longitude: 60.601292),
    MapPoint(name: 'Летний парк', latitude: 56.888004, longitude: 60.601448),
  ];
}

List<MapPoint> _addMapPoints() {
  return const [
    MapPoint(name: 'РГППУ', latitude: 56.886258, longitude: 60.601292),
    MapPoint(name: 'Летний парк', latitude: 56.888004, longitude: 60.601448),
  ];
}

/// Метод для генерации объектов маркеров для отображения на карте
List<PlacemarkMapObject> _getPlacemarkObjects(BuildContext context) {
  // _myPointsList;
  return _getMapPoints()
      .map(
        (point) => PlacemarkMapObject(
          mapId: MapObjectId('MapObject $point'),
          point: Point(latitude: point.latitude, longitude: point.longitude),
          opacity: 1,
          icon: PlacemarkIcon.single(
            PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage(
                //'assets/icons/place.png',
                'assets/icons/place.png',
              ),
              scale: 1,
            ),
          ),
          onTap: (_, __) => showModalBottomSheet(
            context: context,
            builder: (context) => _ModalBodyView(
              point: point,
            ),
          ),
        ),
      )
      .toList();
}

/// Метод для генерации точек начала и конца маршрута
List<PlacemarkMapObject> _getDrivingPlacemarks(
  BuildContext context, {
  required List<Point> drivingPoints,
}) {
  return drivingPoints
      .map(
        (point) => PlacemarkMapObject(
          mapId: MapObjectId('MapObject $point'),
          point: Point(latitude: point.latitude, longitude: point.longitude),
          opacity: 1,
          icon: PlacemarkIcon.single(
            PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage(
                'assets/icons/place.png',
                //'assets/icons/location.png',
              ),
              scale: 1,
            ),
          ),
        ),
      )
      .toList();
}

/// Метод для генерации ТОЧКИ
// List<PlacemarkMapObject> _getMyPlacemarks(
//   BuildContext context, {
//   required List<Point> myPoints,
// }) {
//   return myPoints
//       .map(
//         (point) => PlacemarkMapObject(
//           mapId: MapObjectId('MapObject $point'),
//           point: Point(latitude: point.latitude, longitude: point.longitude),
//           opacity: 1,
//           icon: PlacemarkIcon.single(
//             PlacemarkIconStyle(
//               image: BitmapDescriptor.fromAssetImage(
//                 'assets/icons/place.png',
//                 //'assets/icons/location.png',
//               ),
//               scale: 1,
//             ),
//           ),
//         ),
//       )
//       .toList();
// }

/// Метод для получения маршрутов проезда от точки начала к точке конца
DrivingResultWithSession _getDrivingResultWithSession({
  required Point startPoint,
  required Point endPoint,
}) {
  var drivingResultWithSession = YandexDriving.requestRoutes(
    points: [
      RequestPoint(
        point: startPoint,
        requestPointType: RequestPointType.wayPoint, // точка начала маршрута
      ),
      RequestPoint(
        point: endPoint,
        requestPointType: RequestPointType.wayPoint, // точка конца маршрута
      ),
    ],
    drivingOptions: const DrivingOptions(
      initialAzimuth: 0,
      routesCount: 5,
      avoidTolls: true,
      avoidPoorConditions: true,
    ),
  );

  return drivingResultWithSession;
}

/// Содержимое модального окна с информацией о точке на карте
class _ModalBodyView extends StatelessWidget {
  const _ModalBodyView({required this.point});

  final MapPoint point;

  @override
  Widget build(BuildContext context) {
    return Padding(
      //padding: const EdgeInsets.symmetric(vertical: 40),
      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(point.name, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          Text(
            '${point.latitude}, ${point.longitude}',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
