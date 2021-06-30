import 'package:flutter/material.dart';
import 'package:pharmacie/screens/camera.dart';
import 'package:pharmacie/screens/commandeForm.dart';
import 'package:pharmacie/screens/qrscan.dart';

class Category extends StatelessWidget {
  Category();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
            Widget>[
      Row(
        //ROW 1
        children: <Widget>[
          Container(
            margin:
                EdgeInsets.only(left: 50, top: 8.0, bottom: 8.0, right: 12.0),
            width: 15.0,
            height: 15.0,
          ),
          Image(
            image: AssetImage('images/form.png'),
            height: 65.0,
            width: 65.0,
          ),
          SizedBox(
            width: 20.0,
          ),
          Column(
            children: <Widget>[
              Text(
                'Formulaire ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            ],
          ),
          SizedBox(
            width: 22,
          ),
          Column(
            children: <Widget>[
              new IconButton(
                icon: new Icon(Icons.navigate_next_rounded),
                highlightColor: Colors.pink,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FormScreen()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      SizedBox(
        height: 20.0,
      ),
      Row(
        //ROW 2
        children: <Widget>[
          Container(
            margin:
                EdgeInsets.only(left: 50, top: 8.0, bottom: 8.0, right: 12.0),
            width: 15.0,
            height: 15.0,
          ),
          Image(
            image: AssetImage('images/camera.png'),
            height: 65.0,
            width: 65.0,
          ),
          SizedBox(
            width: 20.0,
          ),
          Column(
            children: <Widget>[
              Text(
                'Camera',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            ],
          ),
          SizedBox(
            width: 50,
          ),
          Column(
            children: <Widget>[
              new IconButton(
                icon: new Icon(Icons.navigate_next_rounded),
                highlightColor: Colors.pink,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CameraPage()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      SizedBox(
        height: 20.0,
      ),
      Row(
        children: <Widget>[
          Container(
            margin:
                EdgeInsets.only(left: 50, top: 8.0, bottom: 8.0, right: 12.0),
            width: 15.0,
            height: 15.0,
          ),
          Image(
            image: AssetImage('images/scan.png'),
            height: 65.0,
            width: 65.0,
          ),
          SizedBox(
            width: 20.0,
          ),
          Column(
            children: <Widget>[
              Text(
                'Scan',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            ],
          ),
          SizedBox(
            width: 70,
          ),
          Column(
            children: <Widget>[
              new IconButton(
                icon: new Icon(Icons.navigate_next_rounded),
                highlightColor: Colors.pink,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QRCodePage()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ]));
  }
}
