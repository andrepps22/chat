import 'package:chat/core/utils/result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoneFirebaseService {
  final db = FirebaseFirestore.instance; 

  Future<Result<String, Exception>> addUser(Map<String, dynamic> user)async{
    try{
      final doc = await db.collection('Users').add(user);
      return Success(doc.id);
    } on FirebaseException catch (e){
      return Failure(e);
    }
  }
}