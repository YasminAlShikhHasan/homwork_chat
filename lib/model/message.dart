// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MessageModel {
  String message;
  bool? isMe;
  MessageModel({
    required this.message,
    this.isMe,
     
  });

  MessageModel copyWith({
    String? message,
    bool? isMe,
  }) {
    return MessageModel(
      message: message ?? this.message,
    
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'isMe': isMe,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      message: map['message'] as String,
    
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Message(message: $message, isMe: $isMe)';

  @override
  bool operator ==(covariant MessageModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.message == message &&
      other.isMe == isMe;
  }

  @override
  int get hashCode => message.hashCode ^ isMe.hashCode;
}
