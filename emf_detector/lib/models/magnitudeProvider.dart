import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlng/latlng.dart';
import 'package:motion_sensors/motion_sensors.dart';
import 'package:vector_math/vector_math_64.dart';

class MagnitudeProvider extends ChangeNotifier {
  double x = 0;
  double y = 0;
  double z = 0;
  double magnitude = 0;
  Position? _currentPosition;
  List<EmfData> emfDataList =[];

  Vector3 magnetometer = Vector3.zero();
  Vector3 _accelerometer = Vector3.zero();
  Vector3 _absoluteOrientation2 = Vector3.zero();
  int? groupvalue = 2;

  changeValues() {
    motionSensors.magnetometer.listen((MagnetometerEvent event) async {
      magnetometer.setValues(event.x, event.y, event.z);


      _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 5),
      );
      var matrix =
      motionSensors.getRotationMatrix(_accelerometer, magnetometer);
      _absoluteOrientation2.setFrom(motionSensors.getOrientation(matrix));
      x = magnetometer.x;
      y = magnetometer.y;
      z = magnetometer.z;


      magnitude = sqrt((pow(magnetometer.x, 2)) +
          (pow(magnetometer.y, 2)) +
          (pow(magnetometer.z, 2)));



      var currentLocation = LatLng(_currentPosition!.latitude, _currentPosition!.longitude);
      var emfData = EmfData(currentLocation, magnitude);
      emfDataList.add(emfData);

      // remove the oldest EMF value if the list is too long
      if (emfDataList.length > 40) {
        emfDataList.removeAt(0);
      }
      // emfDataList.forEach((element) {print(element);});

      print(emfDataList);
      notifyListeners();
    });
  }

  setUpdateInterval(int? groupValue, int interval) {
    motionSensors.magnetometerUpdateInterval = interval;
    groupvalue = groupValue;
    print(groupvalue);
    notifyListeners();
  }
}


class EmfData {
  final LatLng location;
  final double emfValue;

  EmfData(this.location, this.emfValue);
}