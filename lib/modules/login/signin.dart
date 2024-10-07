import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tok/modules/login/signup/signup.dart';
import 'package:tok/modules/welcome.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class SignInWidget extends StatefulWidget {
  const SignInWidget({super.key});

  @override
  State<SignInWidget> createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  String? _emailError;
  String? _passwordError;

  Future<UserCredential?> signInWithGoogle() async {
    try {
      print("Starting Google Sign-In process");
      if (kIsWeb) {
        print("Running on Web platform");
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        print("Attempting to sign in with popup");
        return await FirebaseAuth.instance.signInWithPopup(googleProvider);
      } else {
        print("Running on Mobile platform");
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        if (googleUser == null) {
          print("Google Sign-In was cancelled by the user");
          return null;
        }

        print("Obtained GoogleSignInAccount");
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        print("Obtained GoogleSignInAuthentication");

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        print("Created GoogleAuthProvider credential");
        return await FirebaseAuth.instance.signInWithCredential(credential);
      }
    } catch (e) {
      print('Detailed error in signInWithGoogle: $e');
      return null;
    }
  }

  Future<void> signInWithEmail() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
      } on FirebaseAuthException catch (e) {
        setState(() {
          if (e.code == 'user-not-found') {
            _emailError = 'Incorrect Email';
            _passwordError = null;
          } else if (e.code == 'wrong-password') {
            _passwordError = 'Incorrect Password';
            _emailError = null;
          } else {
            _emailError = 'An error occurred. Please try again.';
            _passwordError = null;
          }
        });
      }
    }
  }

  Widget _buildHeaderRow() {
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildTitle("Welcome back"),
        Positioned(
          right: 0,
          child: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.close, size: 24),
          ),
        ),
      ],
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
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildSignInButton(String text, VoidCallback onPressed,
      {bool isGoogle = false}) {
    return Container(
      width: 400,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: isGoogle
                ? BorderSide(color: Colors.grey.shade300)
                : BorderSide.none,
          ),
          backgroundColor: isGoogle ? Colors.white : Colors.black,
          foregroundColor: isGoogle ? Colors.black : Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isGoogle)
              Image.asset('assets/images/google.jpeg', height: 20, width: 20),
            if (isGoogle) SizedBox(width: 10),
            Text(text),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, bool isPassword) {
    return Container(
      width: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextFormField(
            controller: isPassword ? _passwordController : _emailController,
            obscureText: isPassword ? _obscurePassword : false,
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(),
              errorText: isPassword ? _passwordError : _emailError,
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    )
                  : null,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              if (!isPassword &&
                  !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'Enter a valid email address';
              }
              return null;
            },
          ),
          if (isPassword)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: _buildForgotPassword(),
            ),
        ],
      ),
    );
  }

  Widget _buildSignUpPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't have an account?", style: TextStyle(color: Colors.grey)),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the current SignIn dialog
            showDialog(
              context: context,
              builder: (BuildContext context) => SignUpWidget(),
            );
          },
          child: Text('Sign Up',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
        )
      ],
    );
  }

  Widget _buildForgotPassword() {
    return TextButton(
      onPressed: () {
        // Implement forgot password functionality
      },
      child: Text('Forgot Password?', style: TextStyle(color: Colors.blue)),
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 1000,
        height: 600,
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeaderRow(),
              SizedBox(height: 16),
              _buildSubtitle("Sign In"),
              SizedBox(height: 32),
              _buildTextField("Email", false),
              SizedBox(height: 16),
              _buildTextField("Password", true),
              SizedBox(height: 32),
              _buildSignInButton("Sign In", signInWithEmail),
              SizedBox(height: 16),
              _buildSignInButton("Sign In with Google", () async {
                setState(() {
                  // Show loading indicator if needed
                });
                try {
                  print("Attempting Google Sign-In");
                  UserCredential? result = await signInWithGoogle();
                  if (result != null) {
                    print("Google Sign-In successful");
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => WelcomeScreen()));
                  } else {
                    print("Google Sign-In returned null result");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Google Sign-In was cancelled or failed. Please try again.')),
                    );
                  }
                } catch (e) {
                  print('Detailed error during Google Sign-In: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('An error occurred during Google Sign-In: $e')),
                  );
                } finally {
                  setState(() {
                    // Hide loading indicator if needed
                  });
                }
              }, isGoogle: true),
              Spacer(),
              _buildSignUpPrompt(),
            ],
          ),
        ),
      ),
    );
  }
}
