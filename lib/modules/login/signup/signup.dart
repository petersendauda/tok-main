import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tok/modules/login/signin.dart';
import 'package:tok/modules/login/signup/signupemail.dart';
import 'package:tok/modules/welcome.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({super.key});

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  Future<UserCredential?> signUpWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Store user data in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'email': userCredential.user!.email,
        'name': userCredential.user!.displayName,
        'photoUrl': userCredential.user!.photoURL,
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      return userCredential;
    } catch (e) {
      print('Error signing up with Google: $e');
      return null;
    }
  }

  Widget _buildHeader() {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: Icon(Icons.close, grade: 100),
      ),
    );
  }

  Widget _buildTitle(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildSubtitle(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildSignUpButton(String text, IconData? icon, VoidCallback onPressed,
      {bool isGoogle = false}) {
    return Container(
      width: 400,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          padding: EdgeInsets.symmetric(vertical: 16),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isGoogle)
              Image.asset('assets/images/google.jpeg', height: 20, width: 20)
            else if (icon != null)
              Icon(icon, size: 20),
            SizedBox(width: 10),
            Text(text),
          ],
        ),
      ),
    );
  }

  void _showSignUpEmailDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: 1000,
            height: 600,
            child: SignUpEmailWidget(),
          ),
        );
      },
    );
  }

  Widget _buildSignInPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Already have an account?", style: TextStyle(color: Colors.grey)),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the current SignUp dialog
            showDialog(
              context: context,
              builder: (BuildContext context) => SignInWidget(),
            );
          },
          child: Text('Sign In',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
        )
      ],
    );
  }

  Widget _buildTermsAndPrivacy() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 4,
      children: [
        Text('Click "Sign Up" to agree to our', style: TextStyle(fontSize: 12)),
        TextButton(
          onPressed: () {},
          child: Text('Terms of Service',
              style: TextStyle(fontSize: 12, color: Colors.blue)),
          style: TextButton.styleFrom(
              padding: EdgeInsets.zero, minimumSize: Size.zero),
        ),
        Text('and acknowledge that our', style: TextStyle(fontSize: 12)),
        TextButton(
          onPressed: () {},
          child: Text('Privacy Policy',
              style: TextStyle(fontSize: 12, color: Colors.blue)),
          style: TextButton.styleFrom(
              padding: EdgeInsets.zero, minimumSize: Size.zero),
        ),
        Text('applies to you', style: TextStyle(fontSize: 12)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 1000,
        height: 600,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildHeader(),
            SizedBox(height: 60),
            _buildTitle("Join our platform"),
            SizedBox(height: 8),
            _buildSubtitle("Sign Up"),
            SizedBox(height: 32),
            _buildSignUpButton(
                "Sign Up with Email", Icons.email, _showSignUpEmailDialog),
            SizedBox(height: 16),
            _buildSignUpButton("Sign Up with Google", null, () async {
              UserCredential? result = await signUpWithGoogle();
              if (result != null) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Google Sign-Up failed')),
                );
              }
            }, isGoogle: true),
            Spacer(),
            _buildSignInPrompt(),
            SizedBox(height: 24),
            _buildTermsAndPrivacy(),
          ],
        ),
      ),
    );
  }
}
