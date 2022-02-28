//import 'package:woodtracking_web/firebase/plugins/crash/crashlytics.dart';

extension Log on Object {
  void log() {
    //debugPrint(toString());
  }
}

extension IntUtils on int {
  Duration get milliseconds => Duration(milliseconds: this);

  Duration get seconds => Duration(seconds: this);

  Duration get minutes => Duration(seconds: this);
}

Future<void> waitDuration(Duration duration) async {
  await Future.delayed(duration);
}

extension DurationsUtils on Duration {
  Future<void> get wait => waitDuration(this);
}
