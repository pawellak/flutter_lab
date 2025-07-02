import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartPackageName: 'pigeon_message_api',
    dartOut: 'lib/pigeons/message_api.g.dart',
    dartOptions: DartOptions(),
    kotlinOut: 'android/app/src/main/kotlin/com/pawellak/platform_channel_with_pigeon/pigeons/MessageApi.g.kt',
    kotlinOptions: KotlinOptions(package: 'com.pawellak.platform_channel_with_pigeon.pigeons'),
    swiftOut: 'ios/Runner/MessageApi.g.swift',
    swiftOptions: SwiftOptions(),
  ),
)
@HostApi()
abstract class MessageApi {
  @async
  String getMessageFromNative(String message);
}

@FlutterApi()
abstract class ReverseMessageApi {
  @async
  String getMessageFromFlutter(String message);
}

@HostApi()
abstract class GreatApi {
  String greet(String message);
}
