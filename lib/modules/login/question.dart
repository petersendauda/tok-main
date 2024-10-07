import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({super.key});

  @override
  State<QuestionWidget> createState() => QuestionWidgetState();
}

class QuestionWidgetState extends State<QuestionWidget> {
  final TextEditingController _emailaddress = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phonenumber = TextEditingController();
  final TextEditingController _subject = TextEditingController();
  String? _issuecategory = "";

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

    return AlertDialog(
      content: Container(
        width: screenSize.width * 0.8,
        height: screenSize.height * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How can we assist you?',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: screenSize.width * 0.02,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenSize.height * 0.01),
            buildFormField('Name', _name, screenSize),
            buildFormField('Email', _emailaddress, screenSize),
            buildFormField('Phone Number', _phonenumber, screenSize),
            buildDropdown(screenSize),
            buildFormField('Description', _subject, screenSize),
            SizedBox(height: screenSize.height * 0.01),
            Row(
              mainAxisAlignment: isSmallScreen
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceBetween,
              children: [
                buildButton('Cancel', Icons.cancel_outlined, () {
                  Navigator.of(context).pop();
                }, screenSize, isPrimary: false),
                SizedBox(width: screenSize.width * 0.01),
                buildButton('Raise Issue', null, () {}, screenSize,
                    isPrimary: true),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFormField(
      String label, TextEditingController controller, Size screenSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: screenSize.width * 0.015),
        ),
        TextFormField(
          controller: controller,
          style: TextStyle(fontSize: screenSize.width * 0.012),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          ),
        ),
        SizedBox(height: screenSize.height * 0.01),
      ],
    );
  }

  Widget buildDropdown(Size screenSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What kind of issues are you facing',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: screenSize.width * 0.015),
        ),
        FormBuilderDropdown(
          name: 'Issue Category',
          decoration: InputDecoration(
            labelText: 'Issue Category',
            labelStyle: TextStyle(fontSize: screenSize.width * 0.012),
            hintStyle: TextStyle(fontSize: screenSize.width * 0.012),
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            setState(() {
              _issuecategory = value.toString();
            });
          },
          items: [
            DropdownMenuItem(child: Text('Select'), value: ''),
            DropdownMenuItem(
                child: Text('Login Issues'), value: 'Login Issues'),
            DropdownMenuItem(child: Text('Option 2'), value: 'Option 2'),
            DropdownMenuItem(child: Text('Option 3'), value: 'Option 3'),
          ],
        ),
        SizedBox(height: screenSize.height * 0.01),
      ],
    );
  }

  Widget buildButton(
      String text, IconData? icon, VoidCallback onPressed, Size screenSize,
      {bool isPrimary = false}) {
    final buttonStyle = ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.hovered)) {
            return Color(0xFF6D1813);
          }
          return isPrimary ? Color(0xFF6D1813) : Colors.transparent;
        },
      ),
      foregroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.hovered) || isPrimary) {
            return Colors.white;
          }
          return Color(0xFF6D1813);
        },
      ),
      side: MaterialStateProperty.all(
        BorderSide(color: Color(0xFF6D1813)),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );

    final buttonWidget = isPrimary
        ? ElevatedButton(
            onPressed: onPressed,
            style: buttonStyle,
            child: _buildButtonContent(text, icon, screenSize),
          )
        : OutlinedButton(
            onPressed: onPressed,
            style: buttonStyle,
            child: _buildButtonContent(text, icon, screenSize),
          );

    return buttonWidget;
  }

  Widget _buildButtonContent(String text, IconData? icon, Size screenSize) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) Icon(icon, size: screenSize.width * 0.015),
          if (icon != null) SizedBox(width: 4),
          Text(text, style: TextStyle(fontSize: screenSize.width * 0.012)),
        ],
      ),
    );
  }
}
