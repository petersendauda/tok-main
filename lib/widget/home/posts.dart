import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'reply.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({super.key});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  int _likeCount = 500;
  bool _isLiked = false;
  int _commentCount = 0;
  List<String> _comments = [];
  bool _isCommentSectionVisible = false;
  int _saveCount = 0;
  bool _isSaved = false;

  void _showSavedPopup() {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black.withOpacity(0.7),
          content: Text(
            "Saved",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        );
      },
    );

    // Automatically dismiss the popup after 1 second
    Future.delayed(Duration(seconds: 1), () {
      Navigator.of(context).pop();
    });
  }

  void _addComment(String comment) {
    setState(() {
      _comments.add(comment);
      _commentCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white, // Updated to a static color
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
                    return Colors.grey.withOpacity(0.1); // Updated to a static color
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
                      backgroundColor: Colors.blue, // Updated to a static color
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
                      child: Text("Sahr~Dauda",
                          style: TextStyle(
                            color: Colors.black, // Updated to a static color
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
                        color: Colors.grey, // Updated to a static color
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
                          "Take A Deep Dive On Tok Application And Its Distinctive Qualities",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black, // Updated to a static color
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Know More About Tok App",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: Colors.black, // Updated to a static color
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text("$_likeCount",
                                style: TextStyle(
                                  color: Colors.black, // Updated to a static color
                                )),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (_isLiked) {
                                      _likeCount--;
                                      _isLiked = false;
                                    } else {
                                      _likeCount++;
                                      _isLiked = true;
                                    }
                                  });
                                },
                                icon: Icon(
                                  _isLiked ? Icons.local_fire_department : Icons.local_fire_department_outlined,
                                  color: _isLiked ? Colors.red : Colors.black, // Updated to a static color
                                )),
                            Text("$_commentCount",
                                style: TextStyle(
                                  color: Colors.black, // Updated to a static color
                                )),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isCommentSectionVisible = !_isCommentSectionVisible;
                                  });
                                },
                                icon: Icon(
                                  _isCommentSectionVisible ? Icons.message : Icons.message_outlined,
                                  color: _isCommentSectionVisible ? Colors.blue : Colors.black, // Updated to a static color
                                )),
                            Text("$_saveCount",
                                style: TextStyle(
                                  color: Colors.black, // Updated to a static color
                                )),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (_isSaved) {
                                      _saveCount--;
                                      _isSaved = false;
                                    } else {
                                      _saveCount++;
                                      _isSaved = true;
                                      _showSavedPopup();
                                    }
                                  });
                                },
                                icon: Icon(
                                  _isSaved ? Icons.bookmark : Icons.bookmark_add_outlined,
                                  color: _isSaved ? Colors.green : Colors.black, // Updated to a static color
                                )),
                            Text(
                              "2 Weeks Ago",
                              style: TextStyle(
                                color: Colors.black, // Updated to a static color
                              ),
                            ),
                          ],
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
        if (_isCommentSectionVisible) ...[
          Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var comment in _comments)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      comment,
                      style: TextStyle(color: Colors.black), // Updated to a static color
                    ),
                  ),
              ],
            ),
          ),
          ReplyWidget(onReply: _addComment),
        ],
      ],
    );
  }
}