import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

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

//for game easteregg
  late Ticker _ticker;
  bool xPositivo = false;
  bool yPositivo = false;
  bool isPlayng = false;
  double xBall = 0.0;
  double yBall = 0.0;
  double sizeBall = 60.0;
  double racketPosX = 0.0;
  double velocityBall = 5.0;

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
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isPlayng) {
      xBall = MediaQuery.of(context).size.width - sizeBall - 15;
      yBall = MediaQuery.of(context).size.height - sizeBall - 70;
    }
    return Scaffold(
      appBar: isPlayng
          ? null
          : AppBar(
              title: const Text('Desafio do botão flutuante'),
            ),
      body: Stack(
        children: [
          //controls
          if (isPlayng)
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onDoubleTap: () {
                      setState(() {
                        if (racketPosX > 0) {
                          racketPosX = racketPosX - 50;
                        }
                      });
                    },
                    onTap: () {
                      setState(() {
                        if (racketPosX > 0) {
                          racketPosX = racketPosX - 10;
                        }
                      });
                    },
                    child: Container(
                      color: Colors.transparent,
                      // width: MediaQuery.of(context).size.width / 2,
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onDoubleTap: () {
                      setState(() {
                        if (racketPosX <
                            MediaQuery.of(context).size.width -
                                MediaQuery.of(context).size.width * 0.3) {
                          racketPosX = racketPosX + 50;
                        }
                      });
                    },
                    onTap: () {
                      setState(() {
                        if (racketPosX <
                            MediaQuery.of(context).size.width -
                                MediaQuery.of(context).size.width * 0.3) {
                          racketPosX = racketPosX + 10;
                        }
                      });
                    },
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
          if (!isPlayng)
            GestureDetector(
              onLongPress: () {
                playGame(MediaQuery.of(context).size);
              },
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

          //Game ball
          if (isPlayng)
            Transform.translate(
              offset: Offset(xBall, yBall),
              child: Container(
                height: sizeBall,
                width: sizeBall,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
              ),
            ),

          //Bar racket
          if (isPlayng)
            Positioned(
              left: racketPosX,
              top: MediaQuery.of(context).size.height - 76,
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(100))),
              ),
            ),
        ],
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

  void playGame(Size size) {
    isPlayng = true;
    gameLoop(size.height, size.width);
  }

  void endGame() {
    xPositivo = false;
    yPositivo = false;
    isPlayng = false;
    _ticker.stop();
    setState(() {});
  }

  void gameLoop(double height, double width) {
    _ticker = Ticker((now) {
      setState(() {
        if (xPositivo) {
          if (xBall < width - sizeBall) {
            xBall = xBall + velocityBall;
          } else {
            xPositivo = false;
          }
        } else if (!xPositivo) {
          if (xBall > 0) {
            xBall = xBall - velocityBall;
          } else {
            xPositivo = true;
          }
        }
        if (yPositivo) {
          if (yBall < height + sizeBall) {
            yBall = yBall + velocityBall;

            if (yBall + sizeBall >= height - 70 &&
                (xBall >= racketPosX &&
                    xBall - sizeBall <=
                        racketPosX + width * 0.3 - sizeBall * 2)) {
              yPositivo = false;
            } else if (yBall + sizeBall > height - 105) {
              if (yBall + sizeBall > height) {
                endGame();
              }
            }
          } else {
            yPositivo = false;
          }
        } else if (!yPositivo) {
          if (yBall > 0) {
            yBall = yBall - velocityBall;
          } else {
            yPositivo = true;
          }
        }
      });
    });
    _ticker.start();
  }
}
