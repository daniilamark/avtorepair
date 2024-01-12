class AppLatLong {
  final double lat;
  final double long;

  const AppLatLong({
    required this.lat,
    required this.long,
  });
}

// lat - ШИРОТА
// long - ДОЛГОТА
class MoscowLocation extends AppLatLong {
  const MoscowLocation({
    super.lat = 55.7522200,
    super.long = 37.6155600,
  });
}

class EkbLocation extends AppLatLong {
  const EkbLocation({
    super.lat = 56.8519,
    super.long = 60.6122,
  });
}
