import '../entities/user_entity.dart';

abstract class AuthRepository {
  Stream<UserEntity?> get authStateChanges;
  Future<UserEntity?> getCurrentUser();
  Future<void> signInWithEmail(String email, String password);
  Future<void> signUpWithEmail(
    String email,
    String password,
    String name,
    String phoneNumber, {
    String? profilePicPath,
  });
  Future<void> signOut();
  Future<void> signInWithGoogle();
  Future<void> verifyPhoneNumber(
    String phoneNumber, {
    required Function(String verificationId) onCodeSent,
    required Function(String error) onVerificationFailed,
  });
  Future<void> signInWithPhone(String verificationId, String smsCode);
}
