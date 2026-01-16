import 'package:cloud_firestore/cloud_firestore.dart';

class MessagerModel {
  final String senderUserId;
  final String senderEmail;
  final String receiverUserId;
  final String receiverEmail;
  final Timestamp timestamp;
  final String message;
  

  MessagerModel({required this.senderUserId, required this.senderEmail, required this.message, required this.receiverUserId, required this.timestamp, required this.receiverEmail});

  

  Map<String, dynamic> toJson(){
    return {
      "sendUserId": senderUserId,
      "sendEmail": senderEmail,
      "receiverUserId": receiverUserId,
      "receiverEmail": receiverEmail,
      "mensage": message,
      "timestamp": timestamp
    };
  }
}