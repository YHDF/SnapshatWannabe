import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:soup_chat/src/presentation/bootstrap.dart';
import '../../shared/variables.dart' as globals;
import 'package:soup_chat/src/presentation/shared/utils/device_dimensions.dart';

late List<CameraDescription>? _cameras;

/// CameraApp is the Main Application.
class CameraApp extends StatefulWidget {
  /// Default Constructor
  const CameraApp({Key? key}) : super(key: key);

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController controller;
  XFile? imageFile;
  late DeviceDimension _deviceDimension;


  Future<void> initializeCamera() async{
    _cameras = await availableCameras();
    controller = CameraController(_cameras![0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });
  }

  void onTakePictureButtonPressed() {
    takePicture().then((XFile? file) {
      if (mounted) {
        setState(() {
          imageFile = file;
        });
        if (file != null) {
          showInSnackBar('Picture saved to ${file.path}');
        }
      }
    });
  }

  void showInSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }

    if (cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      final XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }
  void _showCameraException(CameraException e) {
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  void goBack(){
    globals.Variables.selectedIndex = 1;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Bootstrap()));
  }

  @override
  Widget build(BuildContext context) {
    _deviceDimension = DeviceDimension(context);

    if (!controller.value.isInitialized) {
      return Container();
    }
    return Stack(
        children: [
          SizedBox(
              width: _deviceDimension.devWidth,
              height:  _deviceDimension.devHeight,
              child: CameraPreview(controller)),
          Align(
          alignment: const Alignment(-.1, .8),
            child: IconButton(
              icon: const Icon(IconData(0xe12f, fontFamily: 'MaterialIcons'), size: 75,),
              color: Colors.white,
              onPressed: controller != null &&
                  controller.value.isInitialized &&
                  !controller.value.isRecordingVideo
                  ? onTakePictureButtonPressed
                  : null,
            ),
          ),
          Align(
            alignment: const Alignment(-.95, -.95),
            child: IconButton(
              icon: const Icon(IconData(0xe354, fontFamily: 'MaterialIcons'), size: 35,),
              color: Colors.white,
              onPressed: goBack,
            ),
          ),
        ],
    );
  }
}