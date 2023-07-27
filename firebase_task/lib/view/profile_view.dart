// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_task/model/post_model.dart';
import 'package:firebase_task/model/user_model.dart';
import 'package:firebase_task/service/auth_service.dart';
import 'package:firebase_task/service/post_service.dart';
import 'package:firebase_task/service/remote_config_service.dart';
import 'package:firebase_task/service/storage_service.dart';
import 'package:firebase_task/service/user_service.dart';
import 'package:firebase_task/view/add_post_view.dart';
import 'package:firebase_task/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'link_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final PostService _postService = PostService();
  final UserService _userService = UserService();
  final AuthService _authService = AuthService();
  final StorageService _storageService = StorageService();
  final RemoteConfigService _remoteConfigService = RemoteConfigService();
  late final UserModel _userModel;
  bool isLoading = false;
  bool isPPSubmit = false;
  File? file;
  String userId = "";
  final picker = ImagePicker();
  bool showAddpost = true;

  final List<PostModel> posts = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    _remoteConfigService.init();
    _authService.init();
    _postService.init();
    _userService.init();
    _storageService.init();
    setState(() {
      isLoading = true;
    });
    await showAddPost();
    await getPostByUserId();
    await getUser();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> showAddPost() async {
    await _remoteConfigService.setupRemoteConfig();
    await _remoteConfigService.defaultSettings();
    await _remoteConfigService.fetchAndActivate();
    setState(() {
      showAddpost = _remoteConfigService.showAddPost();
    });
  }

  Future<void> putImage() async {
    if (file != null) {
      await _storageService.addImage(
          'users', _authService.currentUser!.uid, file);
    }
  }

  Future<void> submit() async {
    setState(() {
      isPPSubmit = true;
    });
    await putImage();
    setState(() {
      isPPSubmit = false;
    });
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }

  Future<void> getPostByUserId() async {
    var list = await _postService.getByUserId(_authService.currentUser!.uid);
    setState(() {
      posts.addAll(list);
    });
  }

  Future<void> getUser() async {
    _userModel = await _userService.getById(_authService.currentUser!.uid);
  }

  Future<String> getUserImage(String userId) {
    return _storageService.getImageProvider('users', userId);
  }

  Future<String> getPostImage(String postId) {
    return _storageService.getImageProvider('posts', postId);
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LinkView(),
                  ));
            },
            child: Text("links"),
          ),
          GestureDetector(
            onTap: () async {
              XFile? image =
                  await picker.pickImage(source: ImageSource.gallery);
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Submit"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () async {
                          if (image != null) {
                            setState(() {
                              file = File(image.path);
                            });
                          }
                          await submit();
                          Navigator.pop(context);
                        },
                        child: const Text("Okey"),
                      ),
                    ],
                  );
                },
              );
            },
            child: FutureBuilder(
                future: getUserImage(_authService.currentUser!.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white54,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("Error loading image: ${snapshot.error}");
                  }
                  return CircleAvatar(
                    backgroundImage: NetworkImage(snapshot.data != ""
                        ? snapshot.data!
                        : "https://exoffender.org/wp-content/uploads/2016/09/empty-profile.png"),
                    radius: 100,
                  );
                }),
          ),
          const SizedBox(height: 12),
          Text(
            _userModel.username!,
            style: textTheme.titleMedium,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.black87,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    fixedSize:
                        Size(MediaQuery.sizeOf(context).width * 0.38, 50),
                    shadowColor: Colors.transparent,
                  ),
                  child: Text(
                    "Profili düzenle",
                    style: textTheme.titleSmall,
                  ),
                ),
              ),
              showAddpost
                  ? Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.black87,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddPostView(),
                              ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          fixedSize:
                              Size(MediaQuery.sizeOf(context).width * 0.38, 50),
                          shadowColor: Colors.transparent,
                        ),
                        child: Text(
                          "Post ekle",
                          style: textTheme.titleSmall,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              IconButton(
                onPressed: () async {
                  await signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SplashView(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.exit_to_app_outlined,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          GridView.builder(
            shrinkWrap: true,
            itemCount: posts.length,
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            padding: const EdgeInsets.all(8),
            itemBuilder: (BuildContext context, int index) {
              var post = posts[index];
              return FutureBuilder(
                  future: getPostImage(post.id!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white54,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text("Error loading image: ${snapshot.error}");
                    }
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(snapshot.data!),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    );
                  });
            },
          )
        ],
      ),
    );
  }
}
