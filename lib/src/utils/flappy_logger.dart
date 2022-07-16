import 'dart:io';

var isTestingEnvironment = false;

/// Flappy logger to show error below
class FlappyLogger {
  static void logError(String text) {
    print('[ERROR] $text\n');
    if (!isTestingEnvironment) {
      exit(0);
    }
  }

  static void logProgress(String text) {
    print('[PROGRESS] $text');
  }

  static void logWarning(String text) {
    print('[WARNING] $text');
  }
}
