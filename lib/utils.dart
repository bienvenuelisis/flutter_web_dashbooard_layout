import 'dart:html' as htmlfile;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_dashbooard_layout/constants/colors.dart';

class System {
  static Future<htmlfile.MediaStream> getUserMedia({
    bool audio: true,
    bool video: true,
  }) async {
    return htmlfile.window.navigator.getUserMedia(audio: audio, video: video);
  }

  static Future<bool> requestCameraAccess() async {
    return (await htmlfile.window.navigator.permissions?.query({
          "name": "camera",
        }))
            ?.state !=
        "denied";
  }
}

typedef CallbackForFilePicker = Function(List<dynamic> files);

class PlatformWebFilePicker {
  startWebFilePicker(CallbackForFilePicker pickerCallback) async {
    if (kIsWeb) {
      htmlfile.FileUploadInputElement uploadInput =
          htmlfile.FileUploadInputElement();
      uploadInput.click();

      uploadInput.onChange.listen((e) {
        // read file content as dataURL
        final files = uploadInput.files;
        //was just checking for single file but you can check for multiple one
        if ((files ?? []).length == 1) {
          final htmlfile.File? file = files?.first;
          if (file == null) {
          } else {
            final reader = htmlfile.FileReader();

            reader.onLoadEnd.listen((e) {
              //to upload file we will be needing file bytes as web does not work exactly like path thing
              //and to fetch file name we will be needing file object
              //so created custom class to hold both.
              pickerCallback(
                  [FlutterWebFile(file, reader.result as List<int>)]);
            });
            reader.readAsArrayBuffer(file);
          }
        }
      });
    } else {
      return null;
    }
  }

  getFileName(dynamic file) {
    if (kIsWeb) {
      return file.file.name;
    } else {
      return file.path.substring(file.lastIndexOf(Platform.pathSeparator) + 1);
    }
  }
}

class FlutterWebFile {
  htmlfile.File file;
  List<int> fileBytes;

  FlutterWebFile(this.file, this.fileBytes);
}


class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  }) : super(key: key);

// This size work fine on my design, maybe you need some customization depends on your design

  // This isMobile, isTablet, isDesktop helep us later
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 850;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 850;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    // If our width is more than 1100 then we consider it a desktop
    if (_size.width >= 1100) {
      return desktop;
    }
    // If width it less then 1100 and more then 850 we consider it as tablet
    else if (_size.width >= 850) {
      return tablet;
    }
    // Or less then that we called it mobile
    else {
      return mobile;
    }
  }
}


class CircularLoader extends StatelessWidget {
  const CircularLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Center(
        child: CircularProgressIndicator(
          color: primaryColor,
        ),
      ),
    );
  }
}

class LinearLoader extends StatelessWidget {
  const LinearLoader({Key?  key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Center(
        child: LinearProgressIndicator(
          color: primaryColor,
        ),
      ),
    );
  }
}


bool get isInDebugMode {
  // Assume you're in production mode.
  bool inDebugMode = false;

  // Assert expressions are only evaluated during development. They are ignored
  // in production. Therefore, this code only sets `inDebugMode` to true
  // in a development environment.
  assert(inDebugMode = true);

  return inDebugMode;
}

abstract class ErrorProps {
  String? _error = "";

  set error(dynamic error) {
    setState(() {
      if (error is bool) {
        if (error) {
          _error = "Une erreur s'est produite. Remplissez tous les champs.";
        } else {
          _error = "";
        }
      } else {
        _error = error;
      }
    });
  }

  bool get error => (_error ?? "").isNotEmpty;


  String get errorMessage => _error ?? "";

  void setState(VoidCallback fn);
}