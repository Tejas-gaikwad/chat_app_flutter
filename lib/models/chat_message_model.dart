// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChatMessages {
  String idFrom;
  String idTo;
  DateTime timestamp;
  String content;
  String type;

  ChatMessages({
    required this.idFrom,
    required this.idTo,
    required this.timestamp,
    required this.content,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idFrom': idFrom,
      'idTo': idTo,
      'timestamp': timestamp,
      'content': content,
      'type': type,
    };
  }

  factory ChatMessages.fromMap(Map<String, dynamic> map) {
    return ChatMessages(
      content: map['content'] as String,
      idFrom: map['idFrom'] as String,
      idTo: map['idTo'] as String,
      timestamp: map['timestamp'] as DateTime,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessages.fromJson(String source) =>
      ChatMessages.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatMessages(idFrom: $idFrom, idTo: $idTo, timestamp: $timestamp, content: $content, type: $type)';
  }

  @override
  bool operator ==(covariant ChatMessages other) {
    if (identical(this, other)) return true;

    return other.idFrom == idFrom &&
        other.idTo == idTo &&
        other.timestamp == timestamp &&
        other.content == content &&
        other.type == type;
  }

  @override
  int get hashCode {
    return idFrom.hashCode ^
        idTo.hashCode ^
        timestamp.hashCode ^
        content.hashCode ^
        type.hashCode;
  }
}
