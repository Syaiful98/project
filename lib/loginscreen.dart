import 'package:flutter/material.dart';
import 'registerpage.dart';
import 'mainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'user.dart';
import 'package:progress_dialog/progress_dialog.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emcontroller = TextEditingController();
  String _email = "";
  TextEditingController _pscontroller = TextEditingController();
  String _password = "";
  bool _rememberMe = false;
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    loadpref();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SleepBox2U',
        home: Scaffold(
            appBar: AppBar(
              title: Text('Login'),
              backgroundColor: Colors.blue[900],
            ),
            body: Center(
                child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(40),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        scale: 1.2,
                      ),
                      TextField(
                          controller: _emcontroller,
                          decoration: InputDecoration(
                              labelText: 'Email', icon: Icon(Icons.email))),
                      TextField(
                        controller: _pscontroller,
                        decoration: InputDecoration(
                            labelText: 'Password', icon: Icon(Icons.lock)),
                        obscureText: true,
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (bool value) {
                              _onChange(value);
                            },
                          ),
                          Text(
                            'Remember me',
                            style: TextStyle(fontSize: 14),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        minWidth: 300,
                        height: 50,
                        child: Text('Login'),
                        color: Colors.blue[900],
                        textColor: Colors.white,
                        elevation: 20,
                        onPressed: _onLogin,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: _onRegister,
                        child: Text('Register New Account',
                            style: TextStyle(fontSize: 16)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: _onForgot,
                        child: Text('Forgot password',
                            style: TextStyle(fontSize: 16)),
                      )
                    ]),
              ),
            ))));
  }

  Future<void> _onLogin() async {
    _email = _emcontroller.text;
    _password = _pscontroller.text;

    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Login...");
    await pr.show();

    http.post("http://jarfp.com/SleepBox2u/php/user_login.php", body: {
      "email": _email,
      "password": _password,
    }).then((res) {
      print("apakah" + res.body);

      List userdata = res.body.split(",");
      if (userdata[0] == "success") {
        Toast.show(
          "Login Succes",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
        User user = new User(
          name: userdata[1],
          email: _email,
          password: _password,
          phone: userdata[3],
        );
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => MainPage(user: user)));
      } else {
        Toast.show(
          "Login failed",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
      }
    }).catchError((err) {
      print(err);
    });
    await pr.hide();
  }

  void _onRegister() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegisterPage()));
  }

  void _onForgot() {
    print('Forgot');
  }

  void _onChange(bool value) {
    setState(() {
      _rememberMe = value;
      savepref(value);
    });
  }

  Future<void> loadpref() async {
    var prefs = await SharedPreferences.getInstance();
    _email = (prefs.getString('email')) ?? '';
    _password = (prefs.getString('password')) ?? '';
    _rememberMe = (prefs.getBool('rememberme')) ?? false;
    if (_email.length > 0) {
      setState(() {
        _emcontroller.text = _email;
        _pscontroller.text = _password;
        _rememberMe = _rememberMe;
      });
    }
  }

  void savepref(bool value) async {
    prefs = await SharedPreferences.getInstance();
    _email = _emcontroller.text;
    _password = _pscontroller.text;

    if (value) {
      if (_email.length < 5 && _password.length < 3) {
        print("EMAIL/PASSWORD EMPTY");
        _rememberMe = false;
        Toast.show(
          "Email/password empty!!!",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
        );
        return;
      } else {
        await prefs.setString('email', _email);
        await prefs.setString('password', _password);
        await prefs.setBool('rememberme', value);
        Toast.show(
          "Preferences saved",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
        );
        print("SUCCESS");
      }
    } else {
      await prefs.setString('email', '');
      await prefs.setString('password', '');
      await prefs.setBool('rememberme', false);
      setState(() {
        _emcontroller.text = "";
        _pscontroller.text = "";
        _rememberMe = false;
      });
      Toast.show(
        "Preferences removed",
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
      );
    }
  }
}
