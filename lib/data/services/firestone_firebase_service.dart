import 'package:chat/core/utils/result.dart';
import 'package:chat/data/domain/contract/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoneFirebaseService extends Service{
  final db = FirebaseFirestore.instance; 

  Future<Result<String, Exception>> addUser(Map<String, dynamic> user)async{
    try{
      return db.collection('Users').add(user).then((value) => Success(value.id),);
      
    } on FirebaseException catch (e){
      return Failure(e);
    }
  }

  Future<Result<QuerySnapshot, Exception>> getUsers() async{
    try{
      final users = await db.collection('Users').get();

      return Success(users);
      
    } on FirebaseException catch (e){
      return Failure(e);
    }
  }

  
}