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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showQuestionDialog(context),
        backgroundColor: AppColors.red,
        label: Text(
          'Complain',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        icon: Icon(Icons.report_problem, color: AppColors.white),
      ),
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
                color: AppColors.black,
                fontSize: 25,
                fontWeight: FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      actions: [
        _buildSignInButton(context),
        SizedBox(width: 8),
        _buildGetStartedButton(context),
      ],
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Divider(color: AppColors.black87),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: maxWidth * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: maxHeight * 0.15),
                _buildBlogTitle(maxWidth),
                SizedBox(height: maxHeight * 0.03),
                _buildJourneyText(maxWidth),
                SizedBox(height: maxHeight * 0.03),
                _buildButtons(maxWidth),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtons(double maxWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(AppColors.black),
            padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: maxWidth * 0.02, vertical: 16),
            ),
          ),
          child: Text(
            'Start Reading',
            style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: maxWidth * 0.02),
        ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(AppColors.white),
            padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: maxWidth * 0.02, vertical: 16),
            ),
          ),
          child: Text(
            'Start Writing',
            style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildBlogTitle(double maxWidth) {
    return Text(
      'Tell us what you think',
      style: TextStyle(
        shadows: [Shadow(color: AppColors.black, blurRadius: 2.0, offset: Offset(2.0, 2.0))],
        fontSize: maxWidth * 0.04,
        color: AppColors.black,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildJourneyText(double maxWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Create, publish, and share your ideas with our powerful blogging platform. Join our community of writers and readers today.',
          style: _journeyTextStyle(maxWidth),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  TextStyle _journeyTextStyle(double maxWidth) {
    return TextStyle(
      shadows: [Shadow(color: AppColors.black, blurRadius: 1.0, offset: Offset(1.0, 1.0))],
      fontSize: maxWidth * 0.019,
      color: AppColors.black,
      fontWeight: FontWeight.bold,
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

  void _showQuestionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => QuestionWidget(),
    );
  }
}
