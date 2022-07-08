import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:excel_localization/excel_localization.dart';

void main() {
  const MethodChannel channel = MethodChannel('excel_localization');

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
    expect(await ExcelLocalization.platformVersion, '42');
  });
}
