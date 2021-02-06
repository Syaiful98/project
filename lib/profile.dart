import 'package:flutter/material.dart';
import 'package:project/user.dart';

void main() => runApp(Profile());

class Profile extends StatelessWidget {
      final User user;
  const Profile({Key key, this.user}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: Text('Hello World'),
          ),
        ),
      ),
    );
  }
}
