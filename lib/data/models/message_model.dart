import 'package:cloud_firestore/cloud_firestore.dart';

class MessagerModel {
  final String senderUserId;
  final String senderEmail;
  final String receiverUserId;
  final Timestamp timestamp;
  final String message;
  

  MessagerModel({required this.senderUserId, required this.senderEmail, required this.message, required this.receiverUserId, required this.timestamp});

  

  Map<String, dynamic> toJson(){
    return {
      "sendUserId": senderUserId,
      "sendEmail": senderEmail,
      "receiverUserId": receiverUserId,
      "mensage": message,
      "timestamp": timestamp
    };
  }
}