import 'package:flutter/material.dart';

void main() => runApp(Booking());

class Booking extends StatefulWidget {
  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 50.0),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    onPressed: () => print('Menu'),
                    icon: Icon(Icons.menu),
                    color: Colors.black,
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              Text(
                'Enjoy new experiences with SLEEPBOX',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40.0),
              TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Name',
                  icon: Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Color(0xFFEEF8FF),
                    ),
                    child: Icon(
                      Icons.person,
                      size: 25.0,
                      color: Color(
                        0xFF309DF1,
                      ),
                    ),
                  ),
                ),
              ),
              Divider(height: 40.0),
              TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Check-in-Check-out',
                  icon: Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Color(0xFFEEF8FF),
                    ),
                    child: Icon(
                      Icons.calendar_today,
                      size: 25.0,
                      color: Color(
                        0xFF309DF1,
                      ),
                    ),
                  ),
                ),
              ),
              Divider(height: 40.0),
              TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '1 Adult, 0 Children, 1 Room',
                  icon: Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Color(0xFFEEF8FF),
                    ),
                    child: Icon(
                      Icons.person,
                      size: 25.0,
                      color: Color(
                        0xFF309DF1,
                      ),
                    ),
                  ),
                ),
              ),
              Divider(height: 40.0),
              FlatButton(
                padding: EdgeInsets.symmetric(vertical: 25.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Colors.blue[900],
                child: Text(
                  'Search',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () => print('Search'),
              ),
            ]));
  }
}
