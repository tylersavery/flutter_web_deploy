import 'package:flutter_web_plugins/flutter_web_plugins.dart';

class CustomPathUrlStrategy extends HashUrlStrategy {
  CustomPathUrlStrategy([super.platformLocation])
    : _platformLocation = platformLocation;

  final PlatformLocation _platformLocation;

  @override
  String getPath() {
    final path = _platformLocation.pathname + _platformLocation.search;
    return ensureLeadingSlash(path);
  }

  @override
  String prepareExternalUrl(String internalUrl) {
    if (internalUrl.isEmpty) {
      internalUrl = '/';
    }
    assert(
      internalUrl.startsWith('/'),
      "When using PathUrlStrategy, all route names must start with '/' because "
      "the browser's pathname always starts with '/'. "
      "Found route name: '$internalUrl'",
    );
    return internalUrl;
  }
}
