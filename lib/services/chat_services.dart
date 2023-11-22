import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:pillowtalk/models/message_model.dart';

// Function to send a message
class ChatServices {
  int messageCount = 9;
  Stream<List<Message>> getMessages(String user1Id, String user2Id) {
    return Stream.fromFuture(getOrCreateChatId(user1Id, user2Id))
        .asyncExpand((chatId) {
      return FirebaseFirestore.instance
          .collection('messages')
          .doc(chatId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .snapshots()
          .map((querySnapshot) {
        List<Message> messages = querySnapshot.docs
            .map((doc) => Message.fromFirestore(doc))
            .toList();
        print("the total messages are ${messages.length}");
        return messages;
      });
    });
  }

  Widget buildStreakMessage(int streakCount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Center(
        child: Text(
          '🎉 $streakCount messages streak. Keep it up!',
          style: TextStyle(
            fontSize: 14,
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Future<void> sendMessage(
    String currentUserUid,
    String partnerUid, {
    String? content,
    String? imageUrl,
    String? audioUrl,
    var duration,
  }) async {
    try {
      String chatId = await getOrCreateChatId(currentUserUid, partnerUid);

      await FirebaseFirestore.instance
          .collection('messages')
          .doc(chatId)
          .collection('messages')
          .add({
        'senderId': currentUserUid,
        'content': content ?? "",
        'imageUrl': imageUrl ?? "",
        'audioUrl': audioUrl ?? "",
        'duration': duration ?? '',
        'timestamp': Timestamp.now(),
      });

      // _messageController.clear();
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  Future<String?> uploadImageToStorage(File imageFile) async {
    try {
      // Convert image to bytes
      List<int> imageBytes = await imageFile.readAsBytes();

      // Convert List<int> to Uint8List
      Uint8List uint8List = Uint8List.fromList(imageBytes);

      // Upload image to Firebase Storage in JPEG format
      firebase_storage.UploadTask uploadTask = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg')
          .putData(uint8List,
              firebase_storage.SettableMetadata(contentType: 'image/jpeg'));

      return await (await uploadTask).ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<String> getOrCreateChatId(String user1Id, String user2Id) async {
    List<String> participants = [user1Id, user2Id]..sort();
    String chatId = participants.join('_'); // Create a unique identifier

    try {
      // Check if a chat with this identifier already exists
      DocumentSnapshot chatSnapshot = await FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId)
          .get();

      if (chatSnapshot.exists) {
        // Return existing chat ID
        return chatId.toString();
      } else {
        // If no chat exists, create a new chat
        await FirebaseFirestore.instance.collection('chats').doc(chatId).set({
          'participants': participants,
          // Additional metadata if needed
        });

        // Return the newly created chat ID
        return chatId;
      }
    } catch (e) {
      print('Error getting or creating chat: $e');
      return '';
    }
  }
}
