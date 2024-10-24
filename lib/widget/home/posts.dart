import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'reply.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class PostWidget extends StatelessWidget {
  final String username;
  final String title;
  final String content;
  final DateTime timestamp;

  const PostWidget({
    Key? key,
    required this.username,
    required this.title,
    required this.content,
    required this.timestamp,
  }) : super(key: key);

  String _timeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 1) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 1) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 1) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
              elevation: MaterialStateProperty.all<double>(0),
              overlayColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.grey.withOpacity(0.1);
                  }
                  return Colors.transparent;
                },
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Image.asset(
                        'assets/images/profile.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(username,
                          style: TextStyle(
                            color: Colors.black,
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 120,
                      width: 130,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        image: DecorationImage(
                          image: AssetImage("assets/images/tok.jpeg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          content.length > 30
                              ? content.substring(0, 30) + '...'
                              : content,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          _timeAgo(timestamp),
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
