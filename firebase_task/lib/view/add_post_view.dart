// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_task/model/post_model.dart';
import 'package:firebase_task/service/auth_service.dart';
import 'package:firebase_task/service/post_service.dart';
import 'package:firebase_task/service/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPostView extends StatefulWidget {
  const AddPostView({super.key});

  @override
  State<AddPostView> createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  final PostService _postService = PostService();
  final StorageService _storageService = StorageService();
  final TextEditingController _contentController = TextEditingController();
  final AuthService _authService = AuthService();
  File? file;
  String postId = "";
  final picker = ImagePicker();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _postService.init();
    _storageService.init();
    _authService.init();
  }

  Future<void> putImage() async {
    if (file != null) {
      await _storageService.addImage('posts', postId, file);
    }
  }

  Future<void> createPost() async {
    PostModel postModel = PostModel(
      id: '',
      content: _contentController.text.trim(),
      userId: _authService.currentUser!.uid,
      photoUrl: '',
      createdAt: DateTime.now(),
    );
    String id = await _postService.create(postModel);
    postId = id;
  }

  Future<void> submit() async {
    setState(() {
      isLoading = true;
    });
    await createPost();
    await putImage();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Post"),
      ),
      body: SingleChildScrollView(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  const SizedBox(height: 16),
                  file != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.file(
                            file!,
                            height: 300,
                            width: 300,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const SizedBox.shrink(),
                  IconButton(
                    onPressed: () async {
                      XFile? image =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        setState(() {
                          file = File(image.path);
                        });
                      }
                    },
                    icon: const Icon(Icons.add_a_photo_outlined),
                  ),
                  TextField(
                    controller: _contentController,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        await submit();
                        Navigator.pop(context);
                      },
                      child: const Text("Submit"))
                ],
              ),
      ),
    );
  }
}
