import 'package:logger/logger.dart';

class LoggerUtil {
  static final Logger _logger = Logger(
    filter: DevelopmentFilter(),
    // printer: PrefixPrinter(PrettyPrinter(
    //   stackTraceBeginIndex: 5,
    //   methodCount: 1,
    // )),
  );

  static void trace(dynamic message) {
    _logger.t(message);
  }

  static void debug(dynamic message) {
    _logger.d(message);
  }

  static void info(dynamic message) {
    _logger.i(message);
  }

  static void warning(dynamic message) {
    _logger.w(message);
  }

  static void error(dynamic message) {
    _logger.e(message);
  }

  static void fatal(dynamic message) {
    _logger.f(message);
  }
}
