import 'package:flutter/material.dart';

enum FabShape { circle, rectangle }

class MyFloatingActionButton {
  final Alignment alignment;
  final double width;
  final double height;
  final FabShape shape;
  final BorderRadius borderRadius;

  MyFloatingActionButton({
    required this.alignment,
    required this.borderRadius,
    required this.width,
    required this.height,
    required this.shape,
  });

  ///MyFloatingutton on Circular Shape already done
  ///this include all properties that this object will need
  ///to make a Circle
  factory MyFloatingActionButton.circular() {
    return MyFloatingActionButton(
      alignment: Alignment.bottomRight,
      width: 60.0,
      height: 60.0,
      shape: FabShape.circle,
      borderRadius: BorderRadius.circular(50),
    );
  }

  ///MyFloatingutton on Rectangle Shape already done
  ///this include all properties that this object will need
  ///to make a Rectangle

  factory MyFloatingActionButton.rectangle() {
    return MyFloatingActionButton(
      alignment: Alignment.topCenter,
      width: 250.0,
      height: 60.0,
      shape: FabShape.rectangle,
      borderRadius: BorderRadius.circular(0),
    );
  }
}
