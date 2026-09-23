import 'package:flutter/foundation.dart';
import 'package:storypad/core/services/error_reporting/adaptors/base_error_reporting_adaptor.dart';

class NoneErrorReportingAdaptor extends BaseErrorReportingAdaptor {
  @override
  Future<void> recordError(Object error, StackTrace? stack, {bool fatal = false}) {
    debugPrint('⚠️ ${fatal ? 'Fatal' : 'Non-fatal'} error (local only): $error\n$stack');
    return Future.value();
  }

  @override
  Future<void> recordFlutterFatalError(FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    return Future.value();
  }

  @override
  Future<void> log(String message) => Future.value();
}
