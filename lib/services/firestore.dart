import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference questionsCollection =
      FirebaseFirestore.instance.collection('questions');
  
  final CollectionReference postsCollection =
      FirebaseFirestore.instance.collection('posts');
      
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('username'); // New collection

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

    Future<void> addPost(String title, String content, String senderId) {
    return postsCollection.add({
      'title': title,
      'content': content,
      'sender_id': senderId,
      'timestamp': Timestamp.now(),
    });
  }

      Future<void> addUser(String fullName, String emailAddress) {
    return postsCollection.add({
      'fullname': fullName,
      'emailaddress': emailAddress,
      'timestamp': Timestamp.now(),
    });
  }

}
