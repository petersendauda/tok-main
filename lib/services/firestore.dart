import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference questionsCollection =
      FirebaseFirestore.instance.collection('questions');
  
  final CollectionReference postsCollection =
      FirebaseFirestore.instance.collection('posts');
      
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('User'); // Ensure this is the correct collection

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

      Future<void> addUser(String fullName, String email, String userId) {
    return usersCollection.doc(userId).set({ // Use userId as the document ID
      'full_name': fullName,
      'email': email,
      'timestamp': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true)); // Merge to avoid overwriting existing data
  }

  Stream<QuerySnapshot> getPostsStream() {
    return postsCollection
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

}
