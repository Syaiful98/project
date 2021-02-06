import 'package:flutter/material.dart';
import 'package:project/loginscreen.dart';
import 'package:http/http.dart' as http;
import 'loginscreen.dart';
import 'package:toast/toast.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _namecontroller = TextEditingController();
  String name = "";
  final TextEditingController _emcontroller = TextEditingController();
  String email = "";
  final TextEditingController _pscontroller = TextEditingController();
  String password = "";
  final TextEditingController _phcontroller = TextEditingController();
  String phone = "";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Registration'),
          backgroundColor: Colors.blue[900],
        ),
        body: Container(
            child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(children: [
                Image.asset(
                  'assets/images/logo.png',
                  scale: 1.5,
                ),
                TextField(
                    controller: _namecontroller,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: 'Name', icon: Icon(Icons.person))),
                TextField(
                    controller: _phcontroller,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        labelText: 'Phone', icon: Icon(Icons.phone))),
                TextField(
                    controller: _emcontroller,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: 'Email', icon: Icon(Icons.email))),
                TextField(
                    controller: _pscontroller,
                    decoration: InputDecoration(
                        labelText: 'Password', icon: Icon(Icons.lock))),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  minWidth: 300,
                  height: 50,
                  child: Text('Register'),
                  color: Colors.blue[900],
                  textColor: Colors.white,
                  elevation: 20,
                  onPressed: _onRegister,
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    onTap: _onAlready,
                    child: Text('Already Register',
                        style: TextStyle(fontSize: 16))),
              ])),
        )));
  }

  void _onRegister() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            title: new Text(
              "Registration Confirmation",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: new Container(
              height: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Are you sure you wants to register a new account?"),
                ],
              ),
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                  child: new Text("Yes"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _register();
                  }),
              new FlatButton(
                child: new Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ]);
      },
    );
  }

  void _register() {
    name = _namecontroller.text;
    phone = _phcontroller.text;
    email = _emcontroller.text;
    password = _pscontroller.text;
 http.post("http://jarfp.com/SleepBox2u/php/user_register.php", body: {
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
    }).then((res) {
      print("apakah" + res.body);
      if (res.body == "success") {
        _namecontroller.text = '';
        _emcontroller.text = '';
        _phcontroller.text = '';
        _pscontroller.text = '';
        Navigator.pop(context,
            MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
        Toast.show("Registration success", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      } else {
        Toast.show("Registration failed", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }).catchError((err) {
      print(err);
    });
  }


  void _onAlready() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
  }
}
