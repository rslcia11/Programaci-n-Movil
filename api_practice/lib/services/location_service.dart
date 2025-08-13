// lib/services/location_service.dart
import 'package:geolocator/geolocator.dart';

Future<Position?> determinarPosicion() async {
  bool servicioHabilitado;
  LocationPermission permiso;

  servicioHabilitado = await Geolocator.isLocationServiceEnabled();
  if (!servicioHabilitado) {
    return null;
  }

  permiso = await Geolocator.checkPermission();
  if (permiso == LocationPermission.denied) {
    permiso = await Geolocator.requestPermission();
    if (permiso == LocationPermission.denied) {
      return null;
    }
  }

  if (permiso == LocationPermission.deniedForever) {
    return null;
  }

  return await Geolocator.getCurrentPosition();
}
