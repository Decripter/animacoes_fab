import 'package:flutter/material.dart';

class FabPage extends StatefulWidget {
  const FabPage({Key? key}) : super(key: key);

  @override
  State<FabPage> createState() => _FabPageState();
}

class _FabPageState extends State<FabPage> {
  MyFloatingActionButton fabState = MyFloatingActionButton.circular();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Desafio do botão flutuante'),
      ),
      body: GestureDetector(
        onTap: changeState,
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 300),
          alignment: fabState.alignment, //bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: fabState.width,
              height: fabState.height,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: fabState.borderRadius,
              ),
              child: (fabState.icon),
            ),
          ),
        ),
      ),
    );
  }

  void changeState() {
    setState(() {
      if (fabState.shape == FabShape.circle) {
        fabState = MyFloatingActionButton.rectangle();
      } else {
        fabState = MyFloatingActionButton.circular();
      }
    });
  }
}

enum FabShape { circle, rectangle }

class MyFloatingActionButton {
  final Alignment alignment;
  final double width;
  final double height;
  final FabShape shape;
  final BorderRadius borderRadius;
  final Icon icon;

  MyFloatingActionButton({
    required this.alignment,
    required this.borderRadius,
    required this.width,
    required this.height,
    required this.shape,
    required this.icon,
  });

  factory MyFloatingActionButton.circular() {
    return MyFloatingActionButton(
      alignment: Alignment.bottomRight,
      width: 60.0,
      height: 60.0,
      shape: FabShape.circle,
      borderRadius: BorderRadius.circular(50),
      icon: const Icon(
        Icons.arrow_circle_up_outlined,
        color: Colors.white,
      ),
    );
  }
  factory MyFloatingActionButton.rectangle() {
    return MyFloatingActionButton(
      alignment: Alignment.topCenter,
      width: 250.0,
      height: 50.0,
      shape: FabShape.rectangle,
      borderRadius: BorderRadius.circular(0),
      icon: const Icon(
        Icons.arrow_drop_down_circle_outlined,
        color: Colors.white,
      ),
    );
  }
}
