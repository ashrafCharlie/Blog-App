import 'package:cloud_firestore/cloud_firestore.dart';

class DisplayDataModel {
  final String blogText;
  final String sender;
  final String senderId;
  final DateTime? createdAt;
  DisplayDataModel({
    required this.blogText,
    required this.sender,
    required this.senderId,
    required this.createdAt,
  });
  factory DisplayDataModel.fromMap(Map<String, dynamic> map) {
    return DisplayDataModel(
      blogText: map['blogText'] ?? '',
      sender: map['sender'] ?? '',
      senderId: map['sendId'] ?? '',
      createdAt: map['createdAt'] != null 
    ? (map['createdAt'] as Timestamp).toDate() 
    : null,
    );
  }
}
