//import 'dart:html';
import 'dart:convert';
//import 'dart:html';
//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
//import 'loginscreen.dart';
import 'package:http/http.dart' as http;
import 'package:project/profile.dart';
import 'package:project/sleepb.dart';
import 'package:toast/toast.dart';
//import 'package:project/sleepbox.dart';
import 'sleepb.dart';
import 'boxdetails.dart';
import 'user.dart';
import 'package:progress_dialog/progress_dialog.dart';

class MainPage extends StatefulWidget {
  final User user;

  const MainPage({Key key, this.user}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List sleepbox;
  double screenHeight, screenWidth;
  String titlecenter = 'Loading...';
  List<String> _state = [
    'Kedah',
    'Kelantan',
    'Terengganu',
    'Perak',
    'Pulau Pinang',
    'Pahang',
    'Johor',
    'Selangor',
    'Melaka',
    'Negeri Sembilan',
    'Perlis',
    'Sabah',
    'Sarawak'
  ];
  String _currentState = 'Kedah';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    if (sleepbox == null) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Find Your SleepBox"),
            backgroundColor: Colors.blue[900],
          ),
          body: Center(
            child: CircularProgressIndicator(),
          ));
    } else {
      return Scaffold(
          drawer: mainDrawer(context),
          appBar: AppBar(
            title: Text("Find Your SleepBox"),
            backgroundColor: Colors.blue[900],
          ),
          body: RefreshIndicator(
            color: Color.fromRGBO(100, 150, 200, 50),
            onRefresh: () async {},
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: DropdownButton<String>(
                      items: _state.map((String dropdownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropdownStringItem,
                          child: Text(
                            dropdownStringItem,
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        );
                      }).toList(),
                      value: _currentState,
                      onChanged: (String _currentState) {
                        _onDropDownSelectedItem(_currentState);
                      },
                    ),
                  ),
                  Flexible(
                    child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 100 / 130,
                        children: List.generate(sleepbox.length, (index) {
                          return Container(
                              child: Card(
                                  elevation: 10,
                                  child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            GestureDetector(
                                                onTap: () =>
                                                    _loadBoxDetails(index),
                                                child: SingleChildScrollView(
                                                    child: Column(children: [
                                                  Stack(
                                                    children: [
                                                      Container(
                                                          height: screenHeight /
                                                              5.0,
                                                          width:
                                                              screenWidth / 3.0,
                                                          child: ClipOval(
                                                              child:
                                                                  CachedNetworkImage(
                                                            fit: BoxFit.fill,
                                                            imageUrl:
                                                                "http://jarfp.com/SleepBox2u/images/${sleepbox[index]['id']}.jpg",
                                                            placeholder: (context,
                                                                    url) =>
                                                                new CircularProgressIndicator(),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                new Icon(Icons
                                                                    .error),
                                                          ))),
                                                      Positioned(
                                                        child: Container(
                                                            margin:
                                                                EdgeInsets.all(
                                                                    5),
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(10))),
                                                            child: Row(
                                                              children:<Widget> [
                                                                Text(
                                                                  sleepbox[
                                                                          index]
                                                                      [
                                                                      'rating'],
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                                Icon(Icons.star,
                                                                    color: Colors
                                                                        .yellow),
                                                              ],
                                                            )),
                                                        bottom: 10,
                                                        right: 10,
                                                      )
                                                    ],
                                                  ),
                                                  Text(
                                                    sleepbox[index]['name'],
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                        color: Colors.black),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Text(
                                                    "State :" +
                                                        sleepbox[index]
                                                            ['state'],
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 11,
                                                        color: Colors.black),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Text(
                                                    "Price : RM " +
                                                        sleepbox[index]
                                                            ['price'],
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 11,
                                                        color: Colors.black),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Text(
                                                    "Phone :" +
                                                        sleepbox[index]
                                                            ['phone'],
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 11,
                                                        color: Colors.black),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ])))
                                          ]))));
                        })),
                  )
                ],
              ),
            ),
          ));
    }
  }

  void _loadData() async {
    String urlLoadJobs = "https://jarfp.com/SleepBox2u/php/load_box.php";
    await http.post(urlLoadJobs, body: {}).then((res) {
      if (res.body == "nodata") {
        setState(() {
          sleepbox = null;
        });
      } else {
        setState(() {
          var extractdata = json.decode(res.body);
          sleepbox = extractdata["hotel"];
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  _loadBoxDetails(int index) {
    print(sleepbox[index]['name']);
    Sleepb sleepb = new Sleepb(
        id: sleepbox[index]['id'],
        name: sleepbox[index]['name'],
        price: sleepbox[index]['price'],
        location: sleepbox[index]['location'],
        state: sleepbox[index]['state'],
        phone: sleepbox[index]['phone'],
        rating: sleepbox[index]['rating']);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => BoxDetails(box: sleepb)));
  }

  void _onDropDownSelectedItem(String currentState) {
    setState(() {
      this._currentState = currentState;
      _sortItem();
    });
  }

  void _sortItem() {
    try {
      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: true);
      pr.style(message: "Searching...");
      pr.show();
      String urlLoadJobs = "https://jarfp.com/SleepBox2u/php/load_box.php";
      http.post(urlLoadJobs, body: {
        'state': _currentState,
      }).then((res) {
        setState(() {
          var extractdata = json.decode(res.body);
          sleepbox = extractdata["hotel"];
          FocusScope.of(context).requestFocus(new FocusNode());
          pr.hide();
        });
      }).catchError((err) {
        print(err);
        pr.hide();
      });
      pr.hide();
    } catch (e) {
      Toast.show("Error", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  Widget mainDrawer(BuildContext context) {
    return Drawer(
        child: ListView(children: <Widget>[
      UserAccountsDrawerHeader(
        accountName: Text(widget.user.name),
        accountEmail: Text(widget.user.email),
        currentAccountPicture: CircleAvatar(
          backgroundColor: Theme.of(context).platform == TargetPlatform.android
              ? Colors.black
              : Colors.black,
          backgroundImage: NetworkImage(
              "http://jarfp.com/SleepBox2u/profile/${widget.user.email}.jpg?"),
        ),
        onDetailsPressed: () => {
          Navigator.pop(context),
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      Profile(user: widget.user)))
        },
      ),
      ListTile(
          title: Text(
            "SleepBox List",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          trailing: Icon(Icons.arrow_forward),
          onTap: () => {
                Navigator.pop(context),
                _loadData(),
              }),
      ListTile(
        title: Text(
          "User Profile",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        trailing: Icon(Icons.arrow_forward),
      ),
      ListTile(
        title: Text(
          "Payment History",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        trailing: Icon(Icons.arrow_forward),
      ),
      ListTile(
        title: Text(
          "Manage SleepBox",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        trailing: Icon(Icons.arrow_forward),
      ),
      ListTile(
        title: Text(
          "Customer Book",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        trailing: Icon(Icons.arrow_forward),
      ),
      ListTile(
        title: Text(
          "Report",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        trailing: Icon(Icons.arrow_forward),
      )
    ]));
  }
}
