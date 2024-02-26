import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class SendNotification {
  void sendNotification({
    required String body,
    required String title,
    required String token,
    required String notificationCategory,
    String? societyId,
    String? societyName,
    String? societyHostId,
  }) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAe4lKZm8:APA91bG7lhCdbI7zcK7oFLaBJP33C3jC4KqiIpQVhmBeEzOpnL3YDRIokqhF_is7tVMOt4ZJwwmYQjqVyN1M_UIpm4uQE9mm7VBDgbIWv7JWIq9dDIA4DL3itwavQXgE4HbKdWdOxxZo'
        },
        body: jsonEncode(
          {
            'priority': 'high',
            'data': {
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title,
              'notificationCategory': notificationCategory,
              'societyId': societyId,
              'societyName': societyName,
              'societyHostId': societyHostId,
            },
            'notification': {
              'title': title,
              'body': body,
            },
            'to': token,
          },
        ),
      );
    } catch (e) {
      log(e.toString());
    }
  }
}
