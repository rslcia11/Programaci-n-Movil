// lib/screens/mapa_ubicacion.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../services/location_service.dart';

class MapaUbicacion extends StatefulWidget {
  @override
  State<MapaUbicacion> createState() => _MapaUbicacionState();
}

class _MapaUbicacionState extends State<MapaUbicacion> {
  GoogleMapController? _mapController;
  Position? _posicionActual;
  Marker? _marcadorUsuario;

  @override
  void initState() {
    super.initState();
    _obtenerUbicacion();
  }

  Future<void> _obtenerUbicacion() async {
    Position? pos = await determinarPosicion();
    if (pos != null) {
      setState(() {
        _posicionActual = pos;
        _marcadorUsuario = Marker(
          markerId: MarkerId('usuario'),
          position: LatLng(pos.latitude, pos.longitude),
          infoWindow: InfoWindow(title: 'Tu ubicación'),
        );
      });
      _mapController?.animateCamera(
        CameraUpdate.newLatLng(LatLng(pos.latitude, pos.longitude)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mapa con ubicación')),
      body: _posicionActual == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(_posicionActual!.latitude, _posicionActual!.longitude),
                zoom: 15,
              ),
              markers: _marcadorUsuario != null ? {_marcadorUsuario!} : {},
              onMapCreated: (controller) {
                _mapController = controller;
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
    );
  }
}
