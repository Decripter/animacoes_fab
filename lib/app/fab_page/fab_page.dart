import 'package:flutter/material.dart';

import 'components/custom_floating_animation_button.dart';

class FabPage extends StatefulWidget {
  const FabPage({Key? key}) : super(key: key);

  @override
  State<FabPage> createState() => _FabPageState();
}

class _FabPageState extends State<FabPage> with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late Animation<Alignment> alignAnimation;
  late Animation<double> widthAnimation;
  late Animation<BorderRadius> borderAnimation;
  late Animation<RotatedBox> iconAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    controller.addListener(() {
      setState(() {});
    });
    //Alignment
    alignAnimation = Tween<Alignment>(
      begin: MyFloatingActionButton.circular().alignment,
      end: MyFloatingActionButton.rectangle().alignment,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.0,
          0.6,
          curve: Curves.decelerate,
        ),
      ),
    );
    //Width
    widthAnimation = Tween<double>(
      begin: MyFloatingActionButton.circular().width,
      end: MyFloatingActionButton.rectangle().width,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.5,
          1,
          curve: Curves.ease,
        ),
      ),
    );

    //Border
    borderAnimation = Tween<BorderRadius>(
      begin: MyFloatingActionButton.circular().borderRadius,
      end: MyFloatingActionButton.rectangle().borderRadius,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.5,
          0.7,
          curve: Curves.ease,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Desafio do botão flutuante'),
      ),
      body: GestureDetector(
        onTap: changeState,
        child: Align(
          alignment: alignAnimation.value, //bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Container(
              width: widthAnimation.value,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: borderAnimation.value,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void changeState() {
    if (controller.isCompleted) {
      controller.reverse();
    } else {
      controller.forward();
    }
  }
}
