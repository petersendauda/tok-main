import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        // border:
        // color: Colors.black
      ),
      child: TextFormField(
        style: TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
        validator: (Value) {
          if (Value!.isEmpty) {
            return 'This Field is Required';
          }
          return null;
        },
        // controller: _emailaddress,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.5),
            ),
            labelText: "Search"),
        onFieldSubmitted: (value) {
          // if (value.isNotEmpty) {
          //   setState(() {
          //     _emailaddress;
          //   });
          // }
        },
      ),
    );
  }
}
