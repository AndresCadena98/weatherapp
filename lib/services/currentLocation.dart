import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';

Future<String> getCurrentLocation() async {
  LocationPermission permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.deniedForever) {
    permission = await Geolocator.requestPermission();
    return 'Error';
  } else if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  } else if (permission == LocationPermission.whileInUse) {
    var location = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return '${location.latitude},${location.longitude}';
  } else if (permission == LocationPermission.always) {
    var location = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return '${location.latitude},${location.longitude}';
  }
  var location = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  return '${location.latitude},${location.longitude}';
}
