import 'package:pixel_place/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:firebase_auth/firebase_auth.dart';

@Injectable(as: AuthRepository)
class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthRepository(this._firebaseAuth);
  @override
  bool get isSigned => _firebaseAuth.currentUser != null;

  @override
  Future<void> loginAnonnymously() => _firebaseAuth.signInAnonymously();

  @override
  Future<void> logout() => _firebaseAuth.signOut();

  @override
  String? get uid => _firebaseAuth.currentUser!.uid;
}
