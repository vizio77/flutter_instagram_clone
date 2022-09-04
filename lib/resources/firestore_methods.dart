import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_flutter/models/post.dart';
import 'package:instagram_flutter/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String postUrl, String profileImage) async {
    String res = "Some error occurred";

    try {
      String photoUrl =
          await StorageMethods().uploadImateToStorage("posts", file, true);

      String postId = const Uuid().v1();
      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: postUrl,
        profileImage: profileImage,
        likes: [],
      );

      _firestore.collection("posts").doc(postId).set(
            post.toJson(),
          );
      res = "siccess";
    } catch (err) {
      res = err.toString();
    }

    return res;
  }
}
