import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/notification_api.dart';
import 'package:twitter_clone/core/enums/notification_type_enum.dart';
import 'package:twitter_clone/models/notification_model.dart';

final notificationControllerProvider =
    StateNotifierProvider<NotificationController, bool>((ref) {
  return NotificationController(
      notificationAPI: ref.watch(notificationAPIProvider));
});

class NotificationController extends StateNotifier<bool> {
  final NotificationAPI _notificationAPI;
  NotificationController({
    required NotificationAPI notificationAPI,
  })  : _notificationAPI = notificationAPI,
        super(false);

  void createNotification({
    required String text,
    required String postId,
    required NotificationType notificationType,
    required String uid,
  }) async {
    final notification = Notification(
      text: text,
      postId: postId,
      id: '',
      notificationType: notificationType,
      uid: uid,
    );
    final res = await _notificationAPI.createNotification(notification);
    res.fold(
      (l) => print(l.message),
      (r) => null,
    );
  }
}
