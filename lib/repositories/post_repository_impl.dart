import 'package:practice/models/post_model.dart';
import 'package:practice/repositories/post_repository.dart';
import 'package:practice/services/post_service.dart';

/// Implementation of the PostRepository interface.
/// This class is responsible for fetching posts from an API and caching them using Hive.
class PostRepositoryImpl implements PostRepository {
  final PostService _postService;
  PostRepositoryImpl(this._postService);
  @override
  Future<List<PostModel>> fetchPosts() async {
    // Fetch from API and store in cache
    final posts = await _postService.get();
    return posts;
  }
}
