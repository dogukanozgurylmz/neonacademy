import 'package:basketballapp/services/post_service.dart';
import 'package:flutter/material.dart';

import '../model/post_model.dart';

class UsersView extends StatefulWidget {
  const UsersView({super.key});

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  final List<PostModel> _posts = [];
  final PostService _postService = PostService();
  final TextEditingController _titleContoller = TextEditingController();
  final TextEditingController _bodyContoller = TextEditingController();

  Future<void> getAllPosts() async {
    var list = await _postService.getAll();
    setState(() {
      _posts.addAll(list);
    });
  }

  Future<void> createPost(PostModel model) async {
    await _postService.create(model);
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() async => await getAllPosts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              bool isLoading = false;
              return StatefulBuilder(builder: (context, setState) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: _titleContoller,
                        decoration: const InputDecoration(label: Text("Title")),
                      ),
                      TextField(
                        controller: _bodyContoller,
                        decoration: const InputDecoration(label: Text("Body")),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          PostModel postModel = PostModel(
                            id: null,
                            userId: 1,
                            title: _titleContoller.text,
                            body: _bodyContoller.text,
                          );
                          await createPost(postModel);
                          setState(() {
                            _titleContoller.clear();
                            _bodyContoller.clear();
                            isLoading = true;
                          });
                        },
                        child: const Text("Submit"),
                      ),
                    ],
                  ),
                );
              });
            },
          );
        },
      ),
      body: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          var post = _posts[index];
          return ListTile(
            title: Text("${post.title}"),
            subtitle: Text("${post.body}"),
          );
        },
      ),
    );
  }
}
