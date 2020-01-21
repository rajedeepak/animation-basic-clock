import 'package:flutter/material.dart';
import 'dart:math';
//
//class HomePage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return null;
//  }
//}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin {
  _currentTime() => "${DateTime.now().hour} : ${DateTime.now().minute}";

  _absoluteValue(value) => value > 0? value : value * -1;

  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    animationController.addListener((){
      setState(() {
        if(animationController.isCompleted){
          animationController.reverse();
        }else if(animationController.isDismissed){
          animationController.forward();
        }
      });
    });
    animationController.forward();
  }


  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    animation = CurvedAnimation(parent: animationController, curve: Curves.elasticInOut);
    animation = Tween(begin: -0.5, end: 0.5,).animate(animationController);


    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Clock',
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.white60,
        elevation: 0.0,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Material(
                borderRadius: BorderRadius.all(Radius.circular((animation.value) * (animation.value* 1000) )),
                elevation: 10.0,
                color: Colors.blue,
                child: Container(
                  width: 350.0,
                  height: 350.0,
                  child: Center(
                    child: Text(
                      _currentTime(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 70.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Transform(
//                alignment: Alignment(0.5, 0.1),
                alignment: FractionalOffset(0.5, 0.1),
                transform: Matrix4.rotationZ(animation.value),
                child: Container(
                  child: Image.asset(
                    'assets/images/pendulum.png',
                    width: 100,
                    height: 250,
                  ),
                ),
              ),
              Text(animation.value.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
