import 'dart:math';

import 'package:flutter/material.dart';
import 'package:motion_sensors/motion_sensors.dart' as MagnetometerEvent;
import 'package:sensors/sensors.dart';
import 'package:vector_math/vector_math.dart';

class PositionReading extends StatefulWidget {
  const PositionReading({Key? key}) : super(key: key);

  @override
  _PositionReadingState createState() => _PositionReadingState();
}

class _PositionReadingState extends State<PositionReading> {
  List getPosition() {
    if (accelerometerEvent == null ||
        gyroscopeEvent == null ||
        magnetometerEvent == null) {
      return [0.0, 0.0];
    }

    double ax = accelerometerEvent.x;
    double ay = accelerometerEvent.y;
    double az = accelerometerEvent.z;

    double gx = gyroscopeEvent.x;
    double gy = gyroscopeEvent.y;
    double gz = gyroscopeEvent.z;

    double mx = magnetometerEvent.x;
    double my = magnetometerEvent.y;
    double mz = magnetometerEvent.z;

    double norm = sqrt(ax * ax + ay * ay + az * az);
    ax /= norm;
    ay /= norm;
    az /= norm;
    double roll = atan2(ay, az);
    double pitch = atan2(-ax, sqrt(ay * ay + az * az));

    Quaternion gyroOrientation = Quaternion.axisAngle(Vector3(1, 0, 0), pitch) *
        Quaternion.axisAngle(Vector3(0, 1, 0), roll);

    double beta = filterFactor;
    double alpha = 1.0 - beta;

    orientation = (orientation * gyroOrientation).normalized();

    Vector3 magneticField = Vector3(mx, my, mz);
    Vector3 gravity = Vector3(ax, ay, az);
    Quaternion mgFieldAsVector4;
    // mgFieldAsVector4.
    Quaternion magneticFieldInertialFrame =
        (orientation * Quaternion.axisAngle(Vector3(1, 0, 0), magneticField.x));
    Quaternion gravityInertialFrame =
        orientation * Quaternion.axisAngle(Vector3(1, 0, 0), magneticField.x);

    double cosRoll = cos(roll);
    double sinRoll = sin(roll);
    double cosPitch = cos(pitch);
    double sinPitch = sin(pitch);

    double x = magneticFieldInertialFrame.x;
    double y = magneticFieldInertialFrame.y;
    List l = [];
    l.add(x);
    l.add(y);
    return l;
  }

  late AccelerometerEvent accelerometerEvent;
  late GyroscopeEvent gyroscopeEvent;
  late MagnetometerEvent.MagnetometerEvent magnetometerEvent;
  var magnetometerEvents;
  double filterFactor = 0.5;
  Quaternion orientation = Quaternion.identity();
  Vector3 position = Vector3.zero();
  Vector3 velocity = Vector3.zero();
  @override
  void initState() {
    super.initState();

    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        accelerometerEvent = event;
      });
    });

    gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        gyroscopeEvent = event;
      });
    });

    magnetometerEvents.listen((MagnetometerEvent.MagnetometerEvent event) {
      setState(() {
        magnetometerEvent = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List position = getPosition();
    return Scaffold(
      body: Center(
        child: Text('${position[0]}         ${position[1]}  ',
            style: TextStyle(fontSize: 30)),
      ),
    );
  }
}
