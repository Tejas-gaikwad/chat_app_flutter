class UserDataModel {
  final String? uid;
  final String username;
  final String email;
  final String? imagePath;
  final List<String>? chatRoomId;

  UserDataModel({
    this.uid,
    required this.username,
    required this.email,
    this.imagePath,
    this.chatRoomId,
  });
}
