import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ColorLoader extends StatefulWidget {
  const ColorLoader({Key? key}) : super(key: key);

  @override
  State<ColorLoader> createState() => _ColorLoaderState();
}

class _ColorLoaderState extends State<ColorLoader> {
  @override
  Widget build(BuildContext context) {
    return SpinKitRipple(
      color: Colors.white,
      size: 50.0,
    );
  }
}
