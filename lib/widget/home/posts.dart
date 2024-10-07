import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widget/theme/theme_provider.dart';
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
    final themeProvider = Provider.of<ThemeProvider>(context); // Accessing ThemeProvider
    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
              color: themeProvider.themeData.colorScheme.background, // Use background color from theme
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
                      return themeProvider.themeData.colorScheme.background.withOpacity(0.1);
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
                        backgroundColor: themeProvider.themeData.colorScheme.primary,
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
                                color: themeProvider.themeData.colorScheme.onBackground, // Updated to use onBackground
                              ))),
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
                            color: themeProvider.themeData.colorScheme.secondary, // Updated to use secondary color
                            image: DecorationImage(
                                image: AssetImage("assets/images/tok.jpeg"),
                                fit: BoxFit.cover)),
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
                                color: themeProvider.themeData.colorScheme.onBackground), // Updated to use onBackground
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Know More About Tok App",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: themeProvider.themeData.colorScheme.onBackground), // Updated to use onBackground
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text("$_likeCount",
                                  style: TextStyle(
                                    color: themeProvider.themeData.colorScheme.onBackground, // Updated to use onBackground
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
                                    color: _isLiked ? Colors.red : themeProvider.themeData.colorScheme.onBackground, // Updated to use onBackground
                                  )),
                              Text("$_commentCount",
                                  style: TextStyle(
                                    color: themeProvider.themeData.colorScheme.onBackground, // Updated to use onBackground
                                  )),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isCommentSectionVisible = !_isCommentSectionVisible;
                                    });
                                  },
                                  icon: Icon(
                                    _isCommentSectionVisible ? Icons.message : Icons.message_outlined,
                                    color: _isCommentSectionVisible ? Colors.blue : themeProvider.themeData.colorScheme.onBackground, // Updated to use onBackground
                                  )),
                              Text("$_saveCount",
                                  style: TextStyle(
                                    color: themeProvider.themeData.colorScheme.onBackground, // Updated to use onBackground
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
                                    color: _isSaved ? Colors.green : themeProvider.themeData.colorScheme.onBackground, // Updated to use onBackground
                                  )),
                              Text(
                                "2 Weeks Ago",
                                style: TextStyle(
                                  color: themeProvider.themeData.colorScheme.onBackground, // Updated to use onBackground
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
            )),
            SizedBox(
              height: 10,
            ),
        // Repeat the same structure for the second post
        Container(
            decoration: BoxDecoration(
              color: themeProvider.themeData.colorScheme.background, // Use background color from theme
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
                      return themeProvider.themeData.colorScheme.background.withOpacity(0.1);
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
                        backgroundColor: themeProvider.themeData.colorScheme.primary,
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
                                color: themeProvider.themeData.colorScheme.onBackground, // Updated to use onBackground
                              ))),
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
                            color: themeProvider.themeData.colorScheme.secondary, // Updated to use secondary color
                            image: DecorationImage(
                                image: AssetImage("assets/images/tok.jpeg"),
                                fit: BoxFit.cover)),
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
                                color: themeProvider.themeData.colorScheme.onBackground), // Updated to use onBackground
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Know More About Tok App",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: themeProvider.themeData.colorScheme.onBackground), // Updated to use onBackground
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text("$_likeCount",
                                  style: TextStyle(
                                    color: themeProvider.themeData.colorScheme.onBackground, // Updated to use onBackground
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
                                    color: _isLiked ? Colors.red : themeProvider.themeData.colorScheme.onBackground, // Updated to use onBackground
                                  )),
                              Text("$_commentCount",
                                  style: TextStyle(
                                    color: themeProvider.themeData.colorScheme.onBackground, // Updated to use onBackground
                                  )),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isCommentSectionVisible = !_isCommentSectionVisible;
                                    });
                                  },
                                  icon: Icon(
                                    _isCommentSectionVisible ? Icons.message : Icons.message_outlined,
                                    color: _isCommentSectionVisible ? Colors.blue : themeProvider.themeData.colorScheme.onBackground, // Updated to use onBackground
                                  )),
                              Text("$_saveCount",
                                  style: TextStyle(
                                    color: themeProvider.themeData.colorScheme.onBackground, // Updated to use onBackground
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
                                    color: _isSaved ? Colors.green : themeProvider.themeData.colorScheme.onBackground, // Updated to use onBackground
                                  )),
                              Text(
                                "2 Weeks Ago",
                                style: TextStyle(
                                  color: themeProvider.themeData.colorScheme.onBackground, // Updated to use onBackground
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
            )),
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
                      style: TextStyle(color: themeProvider.themeData.colorScheme.onBackground), // Updated to use onBackground
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
