import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:motion_sensors/motion_sensors.dart';
import 'package:vector_math/vector_math_64.dart';

class MagnitudeProvider extends ChangeNotifier {
  double x = 0;
  double y = 0;
  double z = 0;
  double magnitude = 0;
  List<double> emfDataList =[];
  List<double> xvalues =[];
  List<double> yvalues =[];
  List<double> zvalues =[];

  Vector3 magnetometer = Vector3.zero();
  Vector3 _accelerometer = Vector3.zero();
  Vector3 _absoluteOrientation2 = Vector3.zero();
  int? groupvalue = 2;
  bool startCalculating=false;

  changeValues() {

    if(startCalculating){
      motionSensors.magnetometer.listen((MagnetometerEvent event) async {
        magnetometer.setValues(event.x, event.y, event.z);



        var matrix =
        motionSensors.getRotationMatrix(_accelerometer, magnetometer);
        _absoluteOrientation2.setFrom(motionSensors.getOrientation(matrix));
        x = magnetometer.x;
        y = magnetometer.y;
        z = magnetometer.z;

        xvalues.add(x);
        yvalues.add(y);
        zvalues.add(z);
        magnitude = sqrt((pow(magnetometer.x, 2)) +
            (pow(magnetometer.y, 2)) +
            (pow(magnetometer.z, 2)));



        emfDataList.add(magnitude);

        // remove the oldest EMF value if the list is too long
        if (emfDataList.length > 40) {
          emfDataList.removeAt(0);
          yvalues.removeAt(0);
          zvalues.removeAt(0);
          xvalues.removeAt(0);
        }
        // emfDataList.forEach((element) {print(element);});

        print(emfDataList);

        notifyListeners();
      });
    }else{
      ElectroData obj=ElectroData(xvalues,yvalues, zvalues,emfDataList);
      sendData(obj);
      ///AB3eth li back
    }
  }

  setUpdateInterval(int? groupValue, int interval) {
    motionSensors.magnetometerUpdateInterval = interval;
    groupvalue = groupValue;
    print(groupvalue);
    notifyListeners();
  }
  Future<bool> sendData(ElectroData data) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.15:8080/public/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, List<double>>{
        'xvalues': data.listx!,
        'emfValues': data.listEmf!,
        'yvalues': data.listy!,
        'zvalues': data.listz!,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('error');
    }
  }
}

class ElectroData{
  List<double>? listx;
  List<double>? listy;
  List<double>? listz;
  List<double>? listEmf;

  ElectroData(this.listx, this.listy, this.listz, this.listEmf);
}
class EmfData {
  final double emfValue;

  EmfData(this.emfValue);
}