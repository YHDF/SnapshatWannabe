import 'package:flutter/material.dart';
class DeviceDimension {
  double? _devWidth;
  double? _devHeight;

  DeviceDimension(BuildContext context) {
    _devWidth = MediaQuery
        .of(context)
        .size
        .width;
    _devHeight= MediaQuery
        .of(context)
        .size
        .height;
  }

  double? get devHeight => _devHeight;

  double? get devWidth => _devWidth;
}