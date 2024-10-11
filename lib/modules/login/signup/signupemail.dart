import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tok/modules/login/signup/interest.dart';
import 'package:tok/modules/login/signup/user_info.dart' as user_info; // Use a prefix for your import

class SignUpEmailWidget extends StatefulWidget {
  @override
  _SignUpEmailWidgetState createState() => _SignUpEmailWidgetState();
}

class _SignUpEmailWidgetState extends State<SignUpEmailWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

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

  Widget _buildInputField(String label, TextEditingController controller, bool isPassword) {
    return Container(
      width: 400,
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      width: 400,
      child: TextFormField(
        controller: _passwordController,
        obscureText: _obscurePassword,
        decoration: InputDecoration(
          labelText: 'Password',
          hintText: 'Enter your password',
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a password';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildSignUpButton() {
    return Container(
      width: 400,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ElevatedButton(
        onPressed: _signUpWithEmail,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(
          "Sign Up",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  void _signUpWithEmail() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Navigate to UserInfo after successful sign up, passing the user ID and email
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => user_info.UserInfo(userId: userCredential.user!.uid, email: _emailController.text)), // Pass user ID and email
      );
    } on FirebaseAuthException catch (e) {
      // Handle sign up errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "An error occurred during sign up")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1000,
      height: 600,
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildHeader(),
          SizedBox(height: 60),
          _buildTitle("Sign Up with Email"),
          SizedBox(height: 32),
          _buildInputField("Email", _emailController, false),
          SizedBox(height: 16),
          _buildPasswordField(),
          SizedBox(height: 32),
          _buildSignUpButton(),
          Spacer(),
          // Add any additional widgets you want at the bottom
        ],
      ),
    );
  }
}
