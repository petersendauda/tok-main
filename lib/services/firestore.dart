import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference questionsCollection =
      FirebaseFirestore.instance.collection('questions');

  // CREATE ADD A NEW QUESTION
  Future<void> addQuestion(String name, String email, String phoneNumber, String issueCategory, String description) {
    return questionsCollection.add({
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'issue_category': issueCategory,
      'description': description,
      'timestamp': Timestamp.now(),
    });
  }
}


class FirestoreService2 {
  final CollectionReference postsCollection =
      FirebaseFirestore.instance.collection('posts');

  // CREATE ADD A TO ADD TITLE AND CONTENT
  Future<void> addPost(String title, String content, String senderId) {
    return postsCollection.add({
      'title': title,
      'content': content,
      'sender_id': senderId,
      'timestamp': Timestamp.now(),
    });
  }
}
