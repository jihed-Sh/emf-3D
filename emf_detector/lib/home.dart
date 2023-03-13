import 'package:emf_detector/utils/colors.dart';
import 'package:emf_detector/widgets/mainReading.dart';
import 'package:emf_detector/widgets/meterReading.dart';
import 'package:emf_detector/widgets/xyzReading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/magnitudeProvider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MainReading(),
              XYZReading(),
              MeterReading(),
              Container(
                width: 200,
                height: 50,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                            side: const BorderSide(color: Colors.white))),
                        backgroundColor:
                        MaterialStateProperty.all(AppColors.primaryColor)),
                    onPressed: () {},
                    child: const Text('Visualize')),
              ),
              const SizedBox(
                height: 10,
              ),
              Consumer<MagnitudeProvider>(
                builder: (context, model, child) => Container(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  side: const BorderSide(color: Colors.white))),
                          backgroundColor: MaterialStateProperty.all(
                              AppColors.primaryColor)),
                      onPressed: () {
                        model.changeValues();
                      },
                      child: const Text('Start')),
                ),
              ),

              // StartButton()
            ],
          ),
        ),
      ),
    );
  }
}