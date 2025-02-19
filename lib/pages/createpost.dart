// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:weconnect/pages/post_service.dart';

class Createpostpage extends StatefulWidget {
  const Createpostpage({super.key});

  @override
  State<Createpostpage> createState() => _CreatepostpagState();
}

class _CreatepostpagState extends State<Createpostpage> {
  final _captionController = TextEditingController();
  final _contentController = TextEditingController();
  final postservice = PostService();
  File? _selectedImage;

  @override
  void dispose() {
    _captionController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void createPost() async {
    final caption = _captionController.text.trim();
    final content = _contentController.text.trim();

    if (content.isEmpty || _selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Post content and image can\'t be empty')),
      );
      return;
    }

    try {
      await postservice.createPost(content,_selectedImage, caption);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Post created successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Post'),
      centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: pickImage,
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: _selectedImage == null
                    ? Center(child: Text('Tap to select an image'))
                    : Image.file(_selectedImage!, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _captionController,
              decoration: InputDecoration(hintText: 'Enter image caption'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(hintText: 'Enter post content'),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: createPost,
              child: Text('Post'),
            ),
          ],
        ),
      ),
    );
  }
}
