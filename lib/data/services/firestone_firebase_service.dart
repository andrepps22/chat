import 'package:chat/core/utils/result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoneFirebaseService {
  final db = FirebaseFirestore.instance; 

  Future<Result<String, Exception>> addUser(Map<String, dynamic> user)async{
    try{
      return db.collection('Users').add(user).then((value) => Success(value.id),);
      
    } on FirebaseException catch (e){
      return Failure(e);
    }
  }

  Future<Result<List, Exception>> getUsers() async{
    try{
      final users = await db.collection('Users').get();

      return Success(users.docs);
      
    } on FirebaseException catch (e){
      return Failure(e);
    }
  }
}