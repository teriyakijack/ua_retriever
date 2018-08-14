import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:ua_retriever/ua_retriever.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _uaString = 'N/A';

  @override
  void initState() {
    super.initState();
    getUAString();
  }


  Future<void> getUAString() async {
    String uaString;
    // Platform messages may fail, so we use a try/catch PlatformException.
    UaRetriever uaRetriever = new UaRetriever();
    try {
      uaString = await uaRetriever.getUAString();
    } on PlatformException {
      uaString = 'Failed to get platform version.';
    }

    setState(() {
      _uaString = uaString;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await UaRetriever.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new Center(
          child: new Text('Running on: $_uaString\n'),
        ),
      ),
    );
  }
}
