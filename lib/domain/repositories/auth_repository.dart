


abstract class AuthRepository {
  Future<void> loginAnonnymously();
  Future<void> logout();
  bool get isSigned;
  String? get uid;
}
