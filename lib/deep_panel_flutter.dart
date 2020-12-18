import 'dart:async';
import 'dart:convert';

import 'package:deep_panel_flutter/Panels.dart';
import 'package:flutter/services.dart';

class DeepPanel {
  static const MethodChannel _channel = const MethodChannel('deeppanel');

  // static StreamController<String> _controller = StreamController.broadcast();

  // static Stream get stream => _controller.stream;

  static Future<Panels> extractPanelsInfo(String file) async {
    var result = await _channel.invokeMethod("extractPanelsInfo", {'file': file});
    return Panels.fromJson(jsonDecode(result));
  }
}
