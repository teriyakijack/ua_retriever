import 'dart:async';

import 'package:flutter/services.dart';

class UaRetriever {
  static const MethodChannel _channel = const MethodChannel('ua_retriever');

  static UaRetriever _instance;

  factory UaRetriever() => _instance ??= new UaRetriever._();

  UaRetriever._();

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<String> getUAString() async {
    return await _channel.invokeMethod('UAString');
  }
}
