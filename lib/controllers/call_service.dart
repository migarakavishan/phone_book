import 'package:url_launcher/url_launcher.dart';

class CallService {
  Future<void> startCall(String number) async {
    Uri uri = Uri(scheme: 'tel', path: number);

    await launchUrl(uri);
  }
}
