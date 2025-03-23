import 'package:flutter/material.dart';
import 'package:practice/core/utils/textStyle.dart';
import 'package:practice/viewModels/post_view_model.dart';
import 'package:practice/views/widgets/appbar.dart';
import 'package:practice/views/widgets/loader.dart';
import 'package:provider/provider.dart';

/* A StatelessWidget that displays the list of posts.
It uses the PostViewModel to fetch the list of posts and display them.
It also shows a loader while the posts are being fetched.
It provides a refresh button to fetch the posts again.
*/
class PostView extends StatefulWidget {
  const PostView({super.key});

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PostViewModel>(context, listen: false).fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final postModel = Provider.of<PostViewModel>(context);
    return Scaffold(
      appBar: getAppBar(),
      body: postModel.isLoading == true
          ? loader()
          : ListView.builder(
              itemCount: postModel.posts.length,
              addAutomaticKeepAlives: true, // Already true by default
              addRepaintBoundaries: true, // Already true by default
              itemBuilder: (context, index) {
                final post = postModel.posts[index];
                return ListTile(
                  title: Text(
                    post.title.toString(),
                    style: Textstyle.title,
                  ),
                  subtitle: Text(post.body.toString()),
                );
              }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () => postModel.fetchPosts(),
          tooltip: 'Refresh',
          child: const Icon(
            Icons.refresh,
            color: Colors.white,
          )),
    );
  }
}
