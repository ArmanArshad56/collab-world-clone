import 'package:supabase_flutter/supabase_flutter.dart';

class SupaAuthService {
  final supabase = Supabase.instance.client;

  // ==========================
  // CURRENT USER
  // ==========================
  User? get currentUser => supabase.auth.currentUser;

  // Auth state stream (for splash screen)
  Stream<AuthState> get authStateChanges => supabase.auth.onAuthStateChange;

  // ==========================
  // SIGNUP
  // ==========================
  Future<String?> signUpUser({
    required String fullName,
    required String email,
    required String password,
    required String phone,
    required String dob,
    required String gender,
    required bool isCreator,
  }) async {
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      final user = response.user;

      if (user == null) {
        return "Signup failed";
      }

      // Save user data in database
      await supabase.from('users').insert({
        'id': user.id,
        'full_name': fullName,
        'email': email,
        'phone': phone,
        'dob': dob,
        'gender': gender,
        'is_creator': isCreator,
        'role': isCreator ? 'creator' : 'brand',
      });

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // ==========================
  // LOGIN
  // ==========================
  Future<String?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        return "Login failed";
      }

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // ==========================
  // LOGOUT
  // ==========================
  Future<void> logout() async {
    await supabase.auth.signOut();
  }

  // ==========================
  // GET USER DATA
  // ==========================
  Future<Map<String, dynamic>?> getUserData() async {
    final user = currentUser;

    if (user == null) return null;

    final data = await supabase
        .from('users')
        .select()
        .eq('id', user.id)
        .single();

    return data;
  }

  // ==========================
  // SEND OTP (FORGOT PASSWORD)
  // ==========================
  Future<String?> sendPasswordResetOtp({required String email}) async {
    try {
      await supabase.auth.signInWithOtp(email: email);

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // ==========================
  // VERIFY OTP
  // ==========================
  Future<String?> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await supabase.auth.verifyOTP(
        type: OtpType.email,
        email: email,
        token: otp,
      );

      if (response.user == null) {
        return "Invalid OTP";
      }

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // ==========================
  // UPDATE PASSWORD
  // ==========================
  Future<String?> updatePassword({required String newPassword}) async {
    try {
      await supabase.auth.updateUser(UserAttributes(password: newPassword));

      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
