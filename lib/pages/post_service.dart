// ignore_for_file: unnecessary_nullable_for_final_variable_declarations

import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class PostService {
  final SupabaseClient _supabase = Supabase.instance.client;

Future<String?> uploadImageToSupabase(File imageFile) async {
  try {
    final storagePath = 'post_images/${const Uuid().v4()}.jpg'; // Generate a unique file path

    // 🔥 Upload the image to Supabase Storage
    final String? uploadedPath = await _supabase.storage.from('posts').upload(storagePath, imageFile);

    if (uploadedPath == null) {
      throw Exception("Image upload failed");
    }

    // 🔥 Get the public URL of the uploaded image
    return _supabase.storage.from('posts').getPublicUrl(storagePath);
  } catch (e) {
    print('Error uploading image: $e');
    return null;
  }
}

  // /// **🔥 Uploads image to Supabase Storage and returns the URL**
  // Future<String?> uploadImageToSupabase(File imageFile) async {
  //   try {
  //     final storagePath = 'post_images/${const Uuid().v4()}.jpg'; // Unique filename

  //     // Upload to Supabase Storage
  //     final StorageUploadResponse response = await _supabase.storage.from('posts').upload(storagePath, imageFile);

  //     if (response.error != null) {
  //       throw Exception(response.error!.message);
  //     }

  //     // Get public URL of the uploaded image
  //     return _supabase.storage.from('posts').getPublicUrl(storagePath);
  //   } catch (e) {
  //     print('Error uploading image: $e');
  //     return null;
  //   }
  // }

  /// **🔥 Stores post data (content, caption, image URL) in Supabase**
  Future<void> createPost(String content, String imageUrl, String caption) async {
    try {
      await _supabase.from('posts').insert({
        'content': content,
        'image_url': imageUrl,
        'caption': caption,
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Failed to create post: $e');
    }
  }
}
