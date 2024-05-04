// import 'dart:html';
//
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
//
// class CameraScreen extends StatefulWidget {
//   const CameraScreen({Key? key}) : super(key: key);
//   @override
//   _CameraScreenState createState() => _CameraScreenState();
// }
//
// class _CameraScreenState extends State<CameraScreen> {
//   late CameraApp cameraApp;
//   CameraController? controller;
//
//   @override
//   void initState() {
//     super.initState();
//     cameraApp = CameraApp();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return cameraApp;
//   }
//
//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }
//
// class CameraApp extends StatefulWidget {
//   const CameraApp({super.key});
//
//   @override
//   _AppBodyState createState() => _AppBodyState();
// }
//
// class _AppBodyState extends State<CameraApp> {
//   bool cameraAccess = false;
//   String? error;
//   List<CameraDescription>? cameras;
//   CameraController? controller;
//
//
//   @override
//   void initState() {
//     getCameras();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
//
//   Future<void> getCameras() async {
//     try {
//       await window.navigator.mediaDevices!.getUserMedia({'video': true});
//       setState(() {
//         cameraAccess = true;
//       });
//       final cameras = await availableCameras();
//       setState(() {
//         this.cameras = cameras;
//       });
//     } on DomException catch (e) {
//       setState(() {
//         error = '${e.name}: ${e.message}';
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (error != null) {
//       return Center(child: Text('Error: $error'));
//     }
//     if (!cameraAccess) {
//       return Center(child: Text('Camera access not granted yet.'));
//     }
//     if (cameras == null) {
//       return Center(child: Text('Reading cameras'));
//     }
//     return CameraView(cameras: cameras!);
//   }
// }
//
// class CameraView extends StatefulWidget {
//   final List<CameraDescription> cameras;
//
//   const CameraView({Key? key, required this.cameras}) : super(key: key);
//
//   @override
//   _CameraViewState createState() => _CameraViewState();
// }
//
// class _CameraViewState extends State<CameraView> {
//   String? error;
//   CameraController? controller;
//   late CameraDescription cameraDescription = widget.cameras[0];
//
//   Future<void> initCam(CameraDescription description) async {
//     controller = CameraController(description, ResolutionPreset.max);
//
//     try {
//       await controller!.initialize();
//     } catch (e) {
//       error = e.toString();
//     }
//
//     setState(() {});
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     initCam(cameraDescription);
//   }
//
//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (error != null) {
//       return Center(
//         child: Text('Initializing error: $error\nCamera list:'),
//       );
//     }
//     if (controller == null) {
//       return const Center(child: Text('Loading controller...'));
//     }
//     if (!controller!.value.isInitialized) {
//       return const Center(child: Text('Initializing camera...'));
//     }
//
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Spacer(),
//         Center(
//           child: Container(
//             width: 300,
//             height: 400,
//             child: AspectRatio(aspectRatio: 4 / 3, child: CameraPreview(controller!)),
//           ),
//         ),
//         const Spacer(),
//         IconButton(
//           icon: const Icon(Icons.camera_alt),
//           onPressed: controller == null
//               ? null
//               : () async {
//             final file = await controller!.takePicture();
//             final bytes = await file.readAsBytes();
//             processImage(bytes);
//           },
//         ),
//         const Spacer(),
//       ],
//     );
//   }
//
//   void processImage(List<int> imageBytes) {
//     // Process the image here
//   }
// }

import 'package:flutter/material.dart';


class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live Translation')),
      body: const Center(
        child: Text('Camera Screen'),
      ),
    );
  }
}