import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tacsflutter/tacsflutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _connectionStatus = "Connection Status";
  String _doorStatus = "Door Status";
  String _engineStatus = "Engine Status";
  String _locationStatus = "Location Status";
  String _telematicsStatus = "Telematics Status";

  @override
  void initState() {
    super.initState();
    _readKeyringJsonFromAssets();
  }

  /// When user pressed lock doors button
  lockDoors() {}

  /// When user pressed unlock doors button
  unlockDoors() {}

  /// When user pressed connect button
  connect() {}

  /// When user pressed disconnect button
  disconnect() {}

  /// When user pressed enable engine button
  enableEngine() {}

  /// When user pressed disable engine button
  disableEngine() {}

  /// When user pressed location button
  location() {}

  /// When user pressed telematics button
  telematics() {}

  Future<void> _readKeyringJsonFromAssets() async {
    String data = await rootBundle.loadString('assets/keyring.json');
    print(json.decode(data));

    bool keyringBuilt;

    try {
      keyringBuilt = await Tacsflutter.buildKeyring(json.decode(data));
    } on PlatformException {
      keyringBuilt = false;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      if (keyringBuilt) {
        _connectionStatus = "Ready to connect";
      } else {
        _connectionStatus = "Keyring failure";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: new AppBar(
            title: new Text("TACS Quick Start"),
          ),
          body: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Padding(padding: new EdgeInsets.all(20.0)),
                new Text(
                  '$_connectionStatus',
                  style: new TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20.0,
                    fontFamily: 'Roboto',
                  ),
                ),
                new Text(
                  '$_doorStatus',
                  style: new TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20.0,
                    fontFamily: 'Roboto',
                  ),
                ),
                new Text(
                  '$_engineStatus',
                  style: new TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20.0,
                    fontFamily: 'Roboto',
                  ),
                ),
                new Text(
                  '$_locationStatus',
                  style: new TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20.0,
                    fontFamily: 'Roboto',
                  ),
                ),
                new Text(
                  '$_telematicsStatus',
                  style: new TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20.0,
                    fontFamily: 'Roboto',
                  ),
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new RaisedButton(
                      padding: const EdgeInsets.all(8.0),
                      textColor: Colors.black,
                      color: Colors.white,
                      onPressed: connect,
                      child: new Text("Connect"),
                    ),
                    new RaisedButton(
                      padding: const EdgeInsets.all(8.0),
                      textColor: Colors.black,
                      color: Colors.white,
                      onPressed: disconnect,
                      child: new Text("Disconnect"),
                    ),
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new RaisedButton(
                      padding: const EdgeInsets.all(8.0),
                      textColor: Colors.black,
                      color: Colors.white,
                      onPressed: lockDoors,
                      child: new Text("Lock Doors"),
                    ),
                    new RaisedButton(
                      onPressed: unlockDoors,
                      textColor: Colors.black,
                      color: Colors.white,
                      padding: const EdgeInsets.all(8.0),
                      child: new Text("Unlock Doors"),
                    ),
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new RaisedButton(
                      padding: const EdgeInsets.all(8.0),
                      textColor: Colors.black,
                      color: Colors.white,
                      onPressed: enableEngine,
                      child: new Text("Enable Engine"),
                    ),
                    new RaisedButton(
                      onPressed: disableEngine,
                      textColor: Colors.black,
                      color: Colors.white,
                      padding: const EdgeInsets.all(8.0),
                      child: new Text("Disable Engine"),
                    ),
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new RaisedButton(
                      padding: const EdgeInsets.all(8.0),
                      textColor: Colors.black,
                      color: Colors.white,
                      onPressed: location,
                      child: new Text("Location"),
                    ),
                    new RaisedButton(
                      onPressed: telematics,
                      textColor: Colors.black,
                      color: Colors.white,
                      padding: const EdgeInsets.all(8.0),
                      child: new Text("Telematics"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
