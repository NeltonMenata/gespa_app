// ignore_for_file: prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

abstract class Back4app {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    final keyApplicationId = "42Hc3VIP3jMcCSiwGD7cLFtaRIQqBN9saBV1SPsP";
    final keyClientKey = "kzwc07AQ4Y6XDqADcQHw6FKjzlzeROiB32PlpBnY";
    final keyParseServerUrl = "https://parseapi.back4app.com";
    final liveQueryUrl = "https://apupueventos.b4a.io";

    await Parse().initialize(
      keyApplicationId,
      keyParseServerUrl,
      clientKey: keyClientKey,
      autoSendSessionId: true,
      liveQueryUrl: liveQueryUrl,
    );
  }
}
