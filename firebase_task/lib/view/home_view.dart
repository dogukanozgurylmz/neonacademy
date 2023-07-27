// ignore_for_file: use_build_context_synchronously

import 'package:firebase_task/model/comment_model.dart';
import 'package:firebase_task/model/post_model.dart';
import 'package:firebase_task/model/user_model.dart';
import 'package:firebase_task/service/auth_service.dart';
import 'package:firebase_task/service/comment_service.dart';
import 'package:firebase_task/service/post_service.dart';
import 'package:firebase_task/service/storage_service.dart';
import 'package:firebase_task/service/user_service.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final PostService _postService = PostService();
  final UserService _userService = UserService();
  final StorageService _storageService = StorageService();
  final CommentService _commentService = CommentService();
  final AuthService _authService = AuthService();
  List<PostModel> posts = [];
  bool isLoading = false;
  bool isImageLoading = false;
  List<CommentModel> comments = [];
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    _authService.init();
    _postService.init();
    _userService.init();
    _storageService.init();
    _commentService.init();
    await getPosts();
  }

  Future<String> getImage(String id) {
    return _storageService.getImageProvider('posts', id);
  }

  Future<void> getPosts() async {
    setState(() {
      isLoading = true;
    });
    var list = await _postService.getAll();
    setState(() {
      posts.addAll(list);
      isLoading = false;
    });
  }

  Future<UserModel> getUserById(String id) async {
    return await _userService.getById(id);
  }

  Future<void> getComments(String postId) async {
    comments.clear();
    List<CommentModel> list = await _commentService.getByPostId(postId);
    comments.addAll(list);
  }

  Future<void> createComment(String postId) async {
    var userModel = await getUserById(_authService.currentUser!.uid);
    CommentModel commentModel = CommentModel(
      id: '',
      username: userModel.username,
      commentText: commentController.text.trim(),
      createdAt: DateTime.now(),
      postId: postId,
    );
    await _commentService.create(commentModel);
    commentController.clear();
    setState(() {
      comments.add(commentModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          if (posts.isEmpty) {
            return const Center(
              child: Text("Gönderi yok"),
            );
          }
          if (isLoading) {
            return const CircularProgressIndicator();
          }
          var post = posts[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<String>(
                future: getImage(post.id!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      color: Colors.grey, // Placeholder color while loading
                    );
                  } else if (snapshot.hasError) {
                    return Text("Error loading image: ${snapshot.error}");
                  } else {
                    // The image URL is available in snapshot.data
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(snapshot.data!),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: FutureBuilder<UserModel>(
                        future: getUserById(post.userId!),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container();
                          } else if (snapshot.hasError) {
                            return Text("Hata oluştu: ${snapshot.error}");
                          } else {
                            final UserModel user = snapshot.data!;
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: GestureDetector(
                                      onTap: () => throw Exception(),
                                      child: Text(
                                        user.username!,
                                        style: textTheme.bodyLarge!
                                            .copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    await getComments(post.id!);
                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                          builder: (context, setState) {
                                            return Container(
                                              color: Colors.white,
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.5,
                                                      child: ListView.builder(
                                                        itemCount:
                                                            comments.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          var comment =
                                                              comments[index];
                                                          return ListTile(
                                                            title: Text(comment
                                                                .commentText!),
                                                            subtitle: Text(
                                                                comment
                                                                    .username!),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: TextField(
                                                            controller:
                                                                commentController,
                                                          ),
                                                        ),
                                                        IconButton(
                                                          onPressed: () async {
                                                            await createComment(
                                                                post.id!);
                                                            setState(() {});
                                                          },
                                                          icon: const Icon(
                                                              Icons.send),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: const Icon(
                                      Icons.comment_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 8),
              Text(post.content!, style: textTheme.titleMedium),
              Divider(
                color: Colors.grey.shade300,
                indent: 10,
                endIndent: 10,
              )
            ],
          );
        },
      ),
    );
  }
}
