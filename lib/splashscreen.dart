//import 'package:project/splashscreen.dart';
import 'package:flutter/material.dart';
import 'loginscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(    
      title: 'SleepBox2U',
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/logo.png",
                  height: 200.0, fit: BoxFit.cover),
              new ProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}

class ProgressIndicator extends StatefulWidget {
  ProgressIndicator({Key key}) : super(key: key);

  @override
  _ProgressIndicatorState createState() => _ProgressIndicatorState();
}

class _ProgressIndicatorState extends State<ProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          if (animation.value > 0.9) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          }
          //     Navigator.pushReplacement(
          //         context,
          //       MaterialPageRoute(
          //         builder: (BuildContext context) => LoginScreen()));
        });
      });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      value: animation.value,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[900]),
    );
  }
}