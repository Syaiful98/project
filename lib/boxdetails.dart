import 'package:flutter/material.dart';
import 'sleepb.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'user.dart';
import 'booking.dart';

class BoxDetails extends StatefulWidget {
  final Sleepb box;
  final User user;

  const BoxDetails({Key key, this.box, this.user}) : super(key: key);

  @override
  _BoxDetailsState createState() => _BoxDetailsState();
}

class _BoxDetailsState extends State<BoxDetails> {
  double screenHeight, screenWidth;
  @override
  void initState() {
    super.initState();
    print("sleepbox");
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.box.name),
          backgroundColor: Colors.blue[900],
        ),
        body: Center(
            child: Column(children: [
          Container(
            height: screenHeight / 4,
            width: screenWidth / 0.3,
            child: CachedNetworkImage(
                imageUrl:
                    "http://jarfp.com/SleepBox2u/images/${widget.box.id}.jpg",
                fit: BoxFit.cover,
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(
                      Icons.broken_image,
                      size: screenWidth / 3,
                    )),
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.phone),
                  iconSize: 32,
                  onPressed: () {
                    setState(() {});
                  },
                ),
                IconButton(
                  icon: Icon(Icons.map),
                  iconSize: 32,
                  onPressed: () {
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 6),
          Container(
            child: Card(
              elevation: 6,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Table(
                      defaultColumnWidth: FlexColumnWidth(1),
                      children: [
                        TableRow(children: [
                          TableCell(
                              child: Container(
                            alignment: Alignment.centerLeft,
                            height: 30,
                            child: Text("Name:  " + widget.box.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                )),
                          ))
                        ]),
                        TableRow(children: [
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: 30,
                              child: Text("Address: " + widget.box.location,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  )),
                            ),
                          )
                        ]),
                        TableRow(children: [
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: 30,
                              child:
                                  Text("Price per night: RM" + widget.box.price,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      )),
                            ),
                          )
                        ]),
                        TableRow(children: [
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: 30,
                              child: Text("Phone: " + widget.box.phone,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  )),
                            ),
                          )
                        ]),
                      ],
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      minWidth: 300,
                      height: 50,
                      child: Text('Book Now'),
                      color: Colors.blue[900],
                      textColor: Colors.white,
                      elevation: 20,
                      onPressed: _onBooking,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ])));
  }

  void _onBooking() async{
      Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => Booking()));
  }
}
