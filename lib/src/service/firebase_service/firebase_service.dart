// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // ==========================
//   // Current User
//   // ==========================
//   User? get currentUser => _auth.currentUser;

//   // ==========================
//   // Auth State Stream (for Splash / Auto Login)
//   // ==========================
//   Stream<User?> get authStateChanges => _auth.authStateChanges();

//   // ==========================
//   // SIGN UP (Email + Password)
//   // ==========================
//   Future<String?> signUpUser({
//     required String fullName,
//     required String email,
//     required String phone,
//     required String dob,
//     required String gender,
//     required bool isCreator,
//     required String password,
//   }) async {
//     try {
//       // 1. Create user in Firebase Auth
//       UserCredential credential = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       User user = credential.user!;

//       // 2. Send Email Verification
//       // await user.sendEmailVerification();
//       await user.sendEmailVerification();
//       print("Verification email sent ${user.email}");

//       // 3. Save user data in Firestore
//       await _firestore.collection("users").doc(user.uid).set({
//         "uid": user.uid,
//         "fullName": fullName,
//         "email": email,
//         "phone": phone,
//         "dob": dob,
//         "gender": gender,
//         "isCreator": isCreator,
//         "role": isCreator ? "creator" : "brand",
//         "emailVerified": false,
//         "createdAt": FieldValue.serverTimestamp(),
//       });

//       return null; // success
//     } on FirebaseAuthException catch (e) {
//       return e.message;
//     } catch (e) {
//       return "Signup failed. Please try again.";
//     }
//   }

//   // ==========================
//   // LOGIN
//   // ==========================
//   Future<String?> loginUser({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       UserCredential credential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       User user = credential.user!;

//       // Check Email Verification
//       if (!user.emailVerified) {
//         await _auth.signOut();
//         return "Please verify your email before login.";
//       }

//       // Update Firestore emailVerified = true
//       await _firestore.collection("users").doc(user.uid).update({
//         "emailVerified": true,
//       });

//       return null; // success
//     } on FirebaseAuthException catch (e) {
//       return e.message;
//     } catch (e) {
//       return "Login failed.";
//     }
//   }

//   // ==========================
//   // RESEND VERIFICATION EMAIL
//   // ==========================
//   Future<String?> resendVerificationEmail() async {
//     try {
//       User? user = _auth.currentUser;
//       if (user != null && !user.emailVerified) {
//         await user.sendEmailVerification();
//         return null;
//       }
//       return "User not found or already verified.";
//     } catch (e) {
//       return "Failed to resend email.";
//     }
//   }

//   // ==========================
//   // CHECK EMAIL VERIFIED (Reload)
//   // ==========================
//   Future<bool> checkEmailVerified() async {
//     User? user = _auth.currentUser;
//     if (user != null) {
//       await user.reload();
//       user = _auth.currentUser;
//       return user!.emailVerified;
//     }
//     return false;
//   }

//   // ==========================
//   // LOGOUT
//   // ==========================
//   Future<void> logout() async {
//     await _auth.signOut();
//   }

//   // ==========================
//   // GET USER DATA FROM FIRESTORE
//   // ==========================
//   Future<DocumentSnapshot> getUserData() async {
//     return await _firestore
//         .collection("users")
//         .doc(_auth.currentUser!.uid)
//         .get();
//   }
// }

// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _db = FirebaseDatabase.instance
      .ref(); // Root reference

  // ==========================
  // Current User
  // ==========================
  User? get currentUser => _auth.currentUser;

  // ==========================
  // Auth State Stream (for Splash / Auto Login)
  // ==========================
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // ==========================
  // SIGN UP (Email + Password)
  // ==========================
  Future<String?> signUpUser({
    required String fullName,
    required String email,
    required String phone,
    required String dob,
    required String gender,
    required bool isCreator,
    required String password,
  }) async {
    try {
      // 1. Create user in Firebase Auth
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User user = credential.user!;

      // 2. Send Email Verification
      await user.sendEmailVerification();
      print("Verification email sent ${user.email}");

      // 3. Save user data in Realtime Database
      await _db.child("users/${user.uid}").set({
        "uid": user.uid,
        "fullName": fullName,
        "email": email,
        "phone": phone,
        "dob": dob,
        "gender": gender,
        "isCreator": isCreator,
        "role": isCreator ? "creator" : "brand",
        "emailVerified": false,
        "createdAt": DateTime.now().toIso8601String(),
      });

      return null; // success
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return "Signup failed. Please try again.";
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
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User user = credential.user!;

      // Check Email Verification
      if (!user.emailVerified) {
        await _auth.signOut();
        return "Please verify your email before login.";
      }

      // Update Realtime Database emailVerified = true
      await _db.child("users/${user.uid}/emailVerified").set(true);

      return null; // success
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return "Login failed.";
    }
  }

  // ==========================
  // RESEND VERIFICATION EMAIL
  // ==========================
  Future<String?> resendVerificationEmail() async {
    try {
      User? user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        return null;
      }
      return "User not found or already verified.";
    } catch (e) {
      return "Failed to resend email.";
    }
  }

  // ==========================
  // CHECK EMAIL VERIFIED (Reload)
  // ==========================
  Future<bool> checkEmailVerified() async {
    User? user = _auth.currentUser;
    if (user != null) {
      await user.reload();
      user = _auth.currentUser;
      return user!.emailVerified;
    }
    return false;
  }

  // ==========================
  // PASSWORD RESET EMAIL
  // ==========================

  Future<String?> sendPasswordResetEmail({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      print("✅ Password reset email sent to $email");
      return null; // Success
    } on FirebaseAuthException catch (e) {
      print("❌ Password reset failed: ${e.message}");
      return e.message; // Return Firebase error
    } catch (e) {
      print("⚠️ Password reset exception: $e");
      return "An error occurred. Please try again.";
    }
  }

  // ==========================
  // LOGOUT
  // ==========================
  Future<void> logout() async {
    await _auth.signOut();
  }

  // ==========================
  // GET USER DATA FROM Realtime Database
  // ==========================
  Future<Map<String, dynamic>?> getUserData() async {
    User? user = _auth.currentUser;
    if (user == null) return null;

    final snapshot = await _db.child("users/${user.uid}").get();
    if (snapshot.exists) {
      return Map<String, dynamic>.from(snapshot.value as Map);
    }
    return null;
  }
}
