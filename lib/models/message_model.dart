import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String content;
  final Timestamp timestamp;
  final String imgUrl;
  final String audioUrl;
  final String duration;

  Message({
    required this.audioUrl,
    required this.senderId,
    required this.content,
    required this.timestamp,
    required this.imgUrl,
    required this.duration,
  });

  factory Message.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Message(
      senderId: data['senderId'],
      content: data['content'],
      timestamp: data['timestamp'],
      imgUrl: data['imageUrl'],
      audioUrl: data['audioUrl'],
      duration: data['duration'],
    );
  }
}
