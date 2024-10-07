import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tok/modules/welcome.dart';

class SignUpGoogleWidget extends StatelessWidget {
  const SignUpGoogleWidget({Key? key}) : super(key: key);

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      
      // Store user data in Firestore
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'email': userCredential.user!.email,
        'name': userCredential.user!.displayName,
        'photoUrl': userCredential.user!.photoURL,
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      return userCredential;
    } catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up with Google')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            UserCredential? result = await signInWithGoogle();
            if (result != null) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Google Sign-In failed')),
              );
            }
          },
          child: Text('Sign Up with Google'),
        ),
      ),
    );
  }
}
