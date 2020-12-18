import 'dart:async';
import 'dart:io';

import 'package:deep_panel_flutter/deep_panel_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as ImageUtils;
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey,
        body: ListView(children: [
          PanelsDemo(asset: "assets/sample1.png"),
          PanelsDemo(asset: "assets/sample2.png"),
        ]),
      ),
    );
  }
}

class PanelsDemo extends StatefulWidget {
  final String asset;

  const PanelsDemo({Key key, this.asset}) : super(key: key);

  @override
  _PanelsDemoState createState() => _PanelsDemoState();
}

class _PanelsDemoState extends State<PanelsDemo> {
  List<Widget> _panels = [];

  @override
  void initState() {
    _extractPanelsInfo(widget.asset);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        color: Colors.grey[200],
        child: Column(
          children: [
            AppBar(title: Text(widget.asset)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Original asset"),
            ),
            Image.asset(widget.asset),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Extracted panels"),
            ),
            Container(
              height: 300,
              child: ListView.builder(
                itemCount: _panels.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) => _panels[index],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _extractPanelsInfo(String asset) async {
    await Future.delayed(Duration(seconds: 1));
    try {
      final bytes = await rootBundle.load(asset);

      final file = File('${(await getTemporaryDirectory()).path}/${asset.split("/").last}');
      await file.writeAsBytes(bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));

      final panels = await DeepPanel.extractPanelsInfo(file.path);

      final children = <Widget>[];

      for (final info in panels.panelsInfo) {
        children.add(Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Panel ${info.panelNumberInPage} ->\n" +
                      "top: ${info.top}, bottom: ${info.bottom}\n" +
                      "left: ${info.left}, right: ${info.right}\n" +
                      "width: ${info.width} height: ${info.height}",
                ),
                Image.memory(
                  ImageUtils.encodeJpg(crop(file, info.left, info.top, info.width, info.height)),
                  height: 200,
                ),
              ],
            ),
          ),
        ));
      }

      setState(() {
        _panels.clear();
        _panels.addAll(children);
      });
    } on PlatformException {
      // Manage errors here
      print("hello");
    }
  }

  /// Returns a cropped copy of [src].
  ImageUtils.Image crop(File src, int x, int y, int w, int h) {
    final original = ImageUtils.decodeImage(src.readAsBytesSync());
    ImageUtils.Image dst =
        ImageUtils.Image(w, h, channels: original.channels, exif: original.exif, iccp: original.iccProfile);

    for (int yi = 0, sy = y; yi < h; ++yi, ++sy) {
      for (int xi = 0, sx = x; xi < w; ++xi, ++sx) {
        dst.setPixel(xi, yi, original.getPixel(sx, sy));
      }
    }

    return dst;
  }
}
