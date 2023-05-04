import 'dart:io';
import 'dart:math';

import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:emf_detector/widgets/PostionReading.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:emf_detector/models/magnitudeProvider.dart';

class LocalAndWebObjectsView extends StatefulWidget {
  const LocalAndWebObjectsView({Key? key}) : super(key: key);

  @override
  State<LocalAndWebObjectsView> createState() => _LocalAndWebObjectsViewState();
}
PositionReading pr = new PositionReading() ;
//List currentPosition = pr.getPosition();
class _LocalAndWebObjectsViewState extends State<LocalAndWebObjectsView> {
  late ARSessionManager arSessionManager;
  @override
  void initState() {
   pr.initState();
    super.initState();
  }
  late ARObjectManager arObjectManager;
  bool startOrStop = false;
  //String localObjectReference;
  ARNode? localObjectNode;

  //String webObjectReference;
  ARNode? webObjectNode;

  @override
  void dispose() {
    arSessionManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Local / Web Objects"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: ARView(
                  onARViewCreated: onARViewCreated,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () async {

                        setState(() {
                          startOrStop = !startOrStop;
                        });
                        renderAR();
                      },
                      child: Text(!startOrStop ? "Start" : "Stop")),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;

    this.arSessionManager.onInitialize(
          showFeaturePoints: false,
          showPlanes: false,
          // customPlaneTexturePath: "emf_detector/assets/triangle.png",
          showWorldOrigin: false,
          handleTaps: false,
        );
    this.arObjectManager.onInitialize();
  }

  Future<void> startMesuring1() async {
    if (localObjectNode != null) {
      arObjectManager.removeNode(localObjectNode!);
      localObjectNode = null;
    } else {
      // var newN= ARNode(type: type, uri: uri)
      var newNode = ARNode(
          type: NodeType.localGLTF2,
          uri: "assets/Chicken_01/Cube_BaseColor.png",
          scale: Vector3(0.2, 0.2, 0.2),
          position: Vector3(l[0], l[1], l[2]),
          rotation: Vector4(0.0, 0.0, 0.0, 0.0));
      bool? didAddLocalNode = await arObjectManager.addNode(newNode);
      localObjectNode = (didAddLocalNode!) ? newNode : null;
    }
  }

  Future<void> renderAR() async {
    // if (webObjectNode != null) {
    //   arObjectManager.removeNode(webObjectNode!);
    //   webObjectNode = null;
    // } else {
double i=0;
int k=0;
double z=0;
Random random = new Random();
    while (startOrStop)  {
      k=random.nextInt(30)+3;
      for(int j=0 ;j<k;j++){
      var newNode = new ARNode(
          type: NodeType.webGLB,
          position:Vector3(0+i,0+z,0),
          //rotation: Vector4(0, 45, 0, 0) ,
          uri:
              "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/AnimatedMorphCube/glTF-Binary/AnimatedMorphCube.glb",
          scale: Vector3(0.005, 0.005, 0.005));
      bool? didAddWebNode = await arObjectManager.addNode(newNode);

      webObjectNode = (didAddWebNode!) ? newNode : null;
      sleep(Duration(milliseconds: 150));

z+=0.0009;
    }i+=0.004;
      z=0;
    }
  }

  // void renderOrStop() {
  //   if(startOrStop){
  //     startMesuring();
  //   }
  //   else{
  //     renderAR();
  //   }
  // }
}
