import 'package:jiffy/jiffy.dart';
import 'package:url_launcher/url_launcher.dart';

String convertToBangla(String string) {
  String bengali = '';
  for (int i = 0; i < string.length; i++) {
    switch (string[i]) {
      case '1':
        bengali = bengali + '১';
        break;
      case '2':
        bengali = bengali + '২';
        break;
      case '3':
        bengali = bengali + '৩';
        break;
      case '4':
        bengali = bengali + '৪';
        break;
      case '5':
        bengali = bengali + '৫';
        break;
      case '6':
        bengali = bengali + '৬';
        break;
      case '7':
        bengali = bengali + '৭';
        break;
      case '8':
        bengali = bengali + '৮';
        break;
      case '9':
        bengali = bengali + '৯';
        break;
      case '0':
        bengali = bengali + '০';
        break;
      default:
        bengali = bengali + string[i];
    }
  }
  return bengali;
}

String formatTime(int seconds) {
  int sec = seconds % 60;
  int min = (seconds / 60).floor();
  String minute = min.toString().length <= 1 ? "0$min" : "$min";
  String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
  final t = "$minute : $second";

  // final t = (seconds % 60).toString().padLeft(2, '0');
  // '${(Duration(seconds: seconds)).inMinutes.}';
  return convertToBangla(t);
}

timeConverter(seconds) {
  final t = DateTime.fromMillisecondsSinceEpoch(int.parse(seconds) * 10000,
      isUtc: false);
  final time = Jiffy(t).format("mm:ss");

  return time;
}

launchURL(String url) async {
  try {
    await launch(url);
  } catch (e) {}
}
