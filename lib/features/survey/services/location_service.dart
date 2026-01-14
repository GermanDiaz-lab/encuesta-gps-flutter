import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position?> fetchLocation() async {
    final permission = await _checkPermission();
    if (!permission) {
      return null;
    }
    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } on Exception {
      return null;
    }
  }

  Future<bool> _checkPermission() async {
    final enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) {
      return false;
    }
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }
}
