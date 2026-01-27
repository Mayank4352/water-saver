import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:water_saver/models/firebase_model.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  final FlutterSecureStorage prefs = GetIt.I<FlutterSecureStorage>();

  Future<User?> signInWithGoogle() async {
    await _googleSignIn.initialize();
    try {
      final GoogleSignInAccount googleUser =
          await _googleSignIn.authenticate(scopeHint: [
        'profile',
        'email',
        'openid',
      ]);

      final authClient = _googleSignIn.authorizationClient;
      final authorization = await authClient.authorizationForScopes([
        'profile',
        'email',
        'openid',
      ]);
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: authorization?.accessToken,
        idToken: googleUser.authentication.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      return userCredential.user;
    } catch (e) {
      log('Error during Google Sign-In: $e');
      return null;
    }
  }

  Future<bool> checkIfUserExists(String email) async {
    try {
      QuerySnapshot query = await FBCollections.userProfile
          .where('Email', isEqualTo: email)
          .get();
      if (query.docs.isNotEmpty) {
        final userDoc = query.docs.first;

        await prefs.write(key: 'deviceId', value: userDoc.id);
        String id = await prefs.read(key: 'deviceId') ?? '';
        log("DEVICE ID IS HERE$id");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('Error checking if user exists: $e');
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      await prefs.delete(key: 'deviceId');
      return true;
    } catch (e) {
      log('Error signing out: $e');
      return false;
    }
  }
}
