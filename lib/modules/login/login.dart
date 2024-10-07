import 'package:flutter/material.dart';
import 'package:tok/modules/login/question.dart';
import 'package:tok/modules/login/signin.dart';
import 'package:tok/modules/login/signup/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tok/const/color.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBarBackground,
      appBar: _buildAppBar(context),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: _buildBody(context, constraints),
              ),
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appBarBackground,
      title: Row(
        children: [
          Expanded(
            child: Text(
              'Blogging Platform With Content Management System',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 25,
                fontWeight: FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      actions: [
        _buildTokButton(context),
        SizedBox(width: 8),
        _buildSignInButton(context),
        SizedBox(width: 8),
        _buildGetStartedButton(context),
      ],
    );
  }

  Widget _buildTokButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _showSignUpDialog(context),
      style: _transparentButtonStyle(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('TOK', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)),
          SizedBox(width: 6),
          Icon(Icons.note_alt_outlined, color: AppColors.white),
        ],
      ),
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _showSignInDialog(context),
      child: Text('Sign In', style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildGetStartedButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _showSignUpDialog(context),
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(AppColors.black)),
      child: Text('Get Started', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildBody(BuildContext context, BoxConstraints constraints) {
    double maxWidth = constraints.maxWidth;
    double maxHeight = constraints.maxHeight;

    return Column(
      children: [
        Divider(color: AppColors.black87),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: maxWidth * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBlogTitle(maxWidth),
                SizedBox(height: maxHeight * 0.04),
                _buildJourneyText(maxWidth),
                SizedBox(height: maxHeight * 0.04),
                _buildButtons(context, maxWidth),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBlogTitle(double maxWidth) {
    return Text(
      'Blog',
      style: TextStyle(
        shadows: [Shadow(color: AppColors.black, blurRadius: 2.0, offset: Offset(2.0, 2.0))],
        fontSize: maxWidth * 0.15,
        color: AppColors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildJourneyText(double maxWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Join us on a journey of discovery,',
          style: _journeyTextStyle(maxWidth),
        ),
        Text(
          'inspiration, and meaningful dialogue.',
          style: _journeyTextStyle(maxWidth),
        ),
      ],
    );
  }

  TextStyle _journeyTextStyle(double maxWidth) {
    return TextStyle(
      shadows: [Shadow(color: AppColors.black, blurRadius: 1.0, offset: Offset(1.0, 1.0))],
      fontSize: maxWidth * 0.03,
      color: AppColors.white,
      fontWeight: FontWeight.bold,
    );
  }

  Widget _buildButtons(BuildContext context, double maxWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: maxWidth * 0.18,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ElevatedButton(
            onPressed: () {
              showDialog(context: context, builder: (context) => SignUpWidget());
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(AppColors.black),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))
              ),
            ),
            child: Text(
              'Tok',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.02,
                color: AppColors.white,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
        SizedBox(width: 16),
        Container(
          width: 40,
          height: 40,
          child: ElevatedButton(
            onPressed: () {
              showDialog(context: context, builder: (context) => QuestionWidget());
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(AppColors.red),
              shape: MaterialStateProperty.all<CircleBorder>(CircleBorder()),
              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
            ),
            child: Icon(Icons.question_mark, size: 20, color: AppColors.white),
          ),
        ),
      ],
    );
  }

  ButtonStyle _transparentButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: AppColors.white)),
      ),
      backgroundColor: MaterialStateProperty.all<Color>(AppColors.transparent),
      elevation: MaterialStateProperty.all<double>(0),
      overlayColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) return AppColors.white.withOpacity(0.2);
        return AppColors.appBarBackground;
      }),
    );
  }

  Future<void> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      // Navigate to home screen or handle successful login
    } catch (e) {
      // Handle login errors
      print('Login error: $e');
    }
  }

  void _showSignUpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => SignUpWidget(),
    );
  }

  void _showSignInDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => SignInWidget(),
    );
  }
}
