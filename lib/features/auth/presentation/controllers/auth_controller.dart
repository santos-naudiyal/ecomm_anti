import 'dart:async';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/user_entity.dart';
import '../../data/repositories/auth_repository_impl.dart';

part 'auth_controller.g.dart';

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  Stream<UserEntity?> build() {
    final repo = ref.watch(authRepositoryProvider);
    return repo.authStateChanges;
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(authRepositoryProvider);
      await repo.signInWithEmail(email, password);
    } on FirebaseAuthException catch (e) {
      state = AsyncValue.error(_handleAuthError(e), StackTrace.current);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> signUp(
    String email,
    String password,
    String name,
    String phoneNumber,
    String? profilePicPath,
  ) async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(authRepositoryProvider);
      await repo.signUpWithEmail(
        email,
        password,
        name,
        phoneNumber,
        profilePicPath: profilePicPath,
      );
    } on FirebaseAuthException catch (e) {
      state = AsyncValue.error(_handleAuthError(e), StackTrace.current);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(authRepositoryProvider);
      await repo.signInWithGoogle();
    } on FirebaseAuthException catch (e) {
      state = AsyncValue.error(_handleAuthError(e), StackTrace.current);
    } on PlatformException catch (e) {
      if (e.code == 'sign_in_failed' ||
          e.code == '10' ||
          e.message?.contains('10') == true) {
        state = AsyncValue.error(
          'Google Sign-In failed. Please check your SHA-1 fingerprint configuration in Firebase Console.',
          StackTrace.current,
        );
      } else {
        state = AsyncValue.error(e, StackTrace.current);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> verifyPhoneNumber(
    String phoneNumber, {
    required Function(String) onCodeSent,
    required Function(String) onVerificationFailed,
  }) async {
    final repo = ref.read(authRepositoryProvider);
    // Repository handles callbacks, but we might want to wrap the error callback
    // However, the repo calls onVerificationFailed with e.message.
    // Let's rely on the repo for now or update it?
    // The previous implementation was just forwarding calls.
    await repo.verifyPhoneNumber(
      phoneNumber,
      onCodeSent: onCodeSent,
      onVerificationFailed: (msg) {
        // Try to map known error messages if they come as strings
        // But better to handle this in the UI or leave as is if it's just a string.
        // If msg contains "BILLING_NOT_ENABLED", we can replace it.
        if (msg.contains('BILLING_NOT_ENABLED')) {
          onVerificationFailed(
            'Phone authentication is not enabled or billing is inactive. Please contact support.',
          );
        } else {
          onVerificationFailed(msg);
        }
      },
    );
  }

  Future<void> signInWithPhone(String verificationId, String smsCode) async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(authRepositoryProvider);
      await repo.signInWithPhone(verificationId, smsCode);
    } on FirebaseAuthException catch (e) {
      state = AsyncValue.error(_handleAuthError(e), StackTrace.current);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> signOut() async {
    final repo = ref.read(authRepositoryProvider);
    await repo.signOut();
  }

  String _handleAuthError(FirebaseAuthException e) {
    if (e.code == 'network-request-failed') {
      return 'Network error. Please check your internet connection.';
    } else if (e.code == 'wrong-password') {
      return 'Invalid password. Please try again.';
    } else if (e.code == 'user-not-found') {
      return 'No user found with this email.';
    } else if (e.code == 'email-already-in-use') {
      return 'Email is already in use.';
    } else if (e.code == 'invalid-verification-code') {
      return 'Invalid or expired verification code.';
    } else if (e.message != null &&
        e.message!.contains('BILLING_NOT_ENABLED')) {
      return 'Phone authentication requires billing to be enabled. Please contact support.';
    }
    return e.message ?? 'An unknown error occurred.';
  }
}
