import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:camera/camera.dart';

class ScanTab extends StatefulWidget {
  @override
  _ScanTabState createState() => _ScanTabState();
}
class _ScanTabState extends State<ScanTab> {
  late CameraController _controller;
  late List<CameraDescription> _cameras;

  @override
  void initState() {
    super.initState();
    checkCameraPermission();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Ask for camera permission
    await Permission.camera.request();
    if (await Permission.camera.isDenied) {
      // The user has denied camera permission
      return;
    }

    // Get available cameras
    _cameras = await availableCameras();

    // Initialize the camera controller
    _controller = CameraController(_cameras[0], ResolutionPreset.high);

    // If the controller is initialized, start the preview
    if (_controller != null) {
      await _controller.initialize();
      if (!mounted) {
        return;
      }
      setState(() {});
    }
  }

  Future<void> checkCameraPermission() async {
    final PermissionStatus status = await Permission.camera.request();
    if (status != PermissionStatus.granted) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Camera Permission Required'),
            content: Text(
                'Please grant camera permission to use the scanning feature.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller.value.isInitialized) {
      return Container();
    }

    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: CameraPreview(_controller),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height * 0.15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.camera_alt_rounded,
                    color: Colors.white,
                    size: 32.0,
                  ),
                  onPressed: () {
                    // Handle taking picture
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
