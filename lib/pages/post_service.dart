import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class PostService {
  final supabase = Supabase.instance.client;

  Future<void> createPost(String content, File? imageUrl, String caption)async{
    final userId = supabase.auth.currentUser?.id;

    if(userId == null) throw Exception('User not logged in');

      await supabase.from('post').insert({
        'user_Id': userId,
        'content': content,
        'image':'',
        'caption': '',
        'imageUrl': imageUrl
      });
    }
  }
