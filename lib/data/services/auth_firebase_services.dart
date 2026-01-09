import 'package:chat/core/utils/result.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<Result<User?, Exception>> signIn({
    required Map<String, dynamic> userJson
  }) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
         email: userJson['email'],
        password: userJson['password'],
      );
      return Success(result.user);
    } on FirebaseAuthException catch (e) {
      return Failure(e);
    }
  }

  Future<Result<UserCredential, Exception>> signUp({
    required Map<String, dynamic> userJson
  }) async {
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: userJson['email'],
        password: userJson['password'],
      );
      return Success(result);
    } on FirebaseException catch (e) {
      return Failure(e);
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  User? get currentUser => _firebaseAuth.currentUser;
}
