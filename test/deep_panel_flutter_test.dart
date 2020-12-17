import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:deep_panel_flutter/deep_panel_flutter.dart';

void main() {
  const MethodChannel channel = MethodChannel('deep_panel_flutter');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await DeepPanelFlutter.platformVersion, '42');
  });
}