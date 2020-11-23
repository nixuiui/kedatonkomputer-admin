import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image/image.dart' as IMG;
import 'package:kedatonkomputer/ui/widget/box.dart';
import 'package:kedatonkomputer/ui/widget/button.dart';
import 'package:kedatonkomputer/ui/widget/text.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CameraPage extends StatefulWidget {

  CameraPage({
    Key key,
    this.selectedCameraIdx = 0,
    this.flipable = false,
    this.usePersonFrame = false,
    this.useKtpFrame = false,
    this.subtitle = "",
    this.description = "",
    this.scale
  });

  final int selectedCameraIdx;
  final String subtitle;
  final String description;
  final bool usePersonFrame;
  final bool useKtpFrame;
  final bool flipable;
  final double scale;

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> with WidgetsBindingObserver {

  List<CameraDescription> cameras;
  CameraController controller;
  bool isCameraReady = false;
  bool showCapturedPhoto = false;
  String imagePath;
  int selectedCameraIdx;
  bool isTakingPicture = false;

  @override
  void initState() {
    setCamera();
    super.initState();
  }

  Future<void> setCamera() async {
    cameras = await availableCameras();
    if(cameras.length > 0) {
      controller = CameraController(cameras[widget.selectedCameraIdx], ResolutionPreset.veryHigh);
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        } else {
        }
        setState(() {
          selectedCameraIdx = widget.selectedCameraIdx;
          isCameraReady = true;
        });
      });
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text(widget.subtitle),
        iconTheme: IconThemeData(
          color: Colors.black87
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            !isCameraReady ?  Container() : Container(
              child: AspectRatio(
                aspectRatio: widget.scale ?? 1,
                child: showCapturedPhoto ? Image.file(
                  File(imagePath), 
                  fit: BoxFit.cover
                ) : Stack(
                  children: <Widget>[
                    ClipRect(
                      child: Transform.scale(
                        scale: 1 / controller.value.aspectRatio,
                        child: Center(
                          child: AspectRatio(
                            aspectRatio: controller.value.aspectRatio,
                            child: CameraPreview(controller),
                          ),
                        ),
                      ),
                    ),
                    widget.useKtpFrame ? Align(
                      alignment: Alignment.center,
                      child: AspectRatio(
                        aspectRatio: widget.scale ?? 1,
                        child: Image.asset("assets/ktp_frame.png", fit: BoxFit.cover),
                      )
                    ) : Container(),
                    widget.usePersonFrame ? Align(
                      alignment: Alignment.center,
                      child: AspectRatio(
                        aspectRatio: widget.scale ?? 1,
                        child: Image.asset(
                          "assets/camera_frame_person.png",
                          fit: BoxFit.fill,
                        )
                      )
                    ) : Container()
                  ],
                ),
              )
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SmallText(widget.description),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: widget.flipable || (widget.flipable && !showCapturedPhoto) ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Box(
                                width: 60,
                                height: 60,
                                child: RaisedButtonCustom(
                                  onPressed: () => onSwitchCamera(),
                                  icon: Icons.autorenew,
                                  radius: 50,
                                  padding: 0,
                                  color: Colors.white,
                                  iconColor: Colors.black45,
                                  fontSize: 32,
                                )
                              ),
                            ],
                          ) : Container(),
                        ),
                        Box(
                          width: 60,
                          height: 60,
                          child: RaisedButtonPrimary(
                            onPressed: isTakingPicture ? null : () => (showCapturedPhoto ? acceptImage(context) : onCaptureButtonPressed()),
                            icon: isTakingPicture ? Icons.fiber_manual_record : (showCapturedPhoto ? Icons.check_circle : Icons.fiber_manual_record),
                            radius: 50,
                            padding: 0,
                            fontSize: 40,
                          )
                        ),
                        Expanded(
                          flex: 1,
                          child: Visibility(
                            visible: showCapturedPhoto,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Box(
                                  width: 60,
                                  height: 60,
                                  child: RaisedButtonCustom(
                                    onPressed: () => setState(() => showCapturedPhoto = false),
                                    icon: Icons.refresh,
                                    radius: 50,
                                    padding: 0,
                                    color: Colors.white,
                                    iconColor: Colors.black45,
                                    fontSize: 32,
                                  )
                                ),
                              ],
                            )
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }

  acceptImage(BuildContext context) {
    Navigator.of(context).pop({'data': File(imagePath)});
  }

  Future _initCameraController(CameraDescription cameraDescription) async {
    if (controller != null) await controller.dispose();
    controller = CameraController(cameraDescription, ResolutionPreset.high);
    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError)
        print('Camera error ${controller.value.errorDescription}');
    });
    try {
      await controller.initialize();
    } on CameraException catch (e) {
      print(e.toString());
    }
    if (mounted) setState(() {});
  }

  void onSwitchCamera() {
    selectedCameraIdx =
    selectedCameraIdx < cameras.length - 1 ? selectedCameraIdx + 1 : 0;
    CameraDescription selectedCamera = cameras[selectedCameraIdx];
    _initCameraController(selectedCamera);
  }

  void onCaptureButtonPressed() async {
    setState(() {
      isTakingPicture = true;
    });
    try {
      var pathString = join((await getTemporaryDirectory()).path, 'image-${DateTime.now()}.png');
      await controller.takePicture(pathString);
      
      var fileImage = await FlutterImageCompress.compressWithFile(
        pathString, 
        quality: 100,
        rotate: 0
      );
      
      IMG.Image image = IMG.decodeJpg(fileImage);
      IMG.Image thumbnail = IMG.copyResizeCropSquare(image, 800);
      if(selectedCameraIdx == 1) thumbnail = IMG.flipHorizontal(thumbnail);
      File(pathString).writeAsBytesSync(IMG.encodePng(thumbnail));

      imagePath = pathString;

      setState(() {
        showCapturedPhoto = true;
        isTakingPicture = false;
      });
    } catch (e) {
      print(e);
    }
  }
}