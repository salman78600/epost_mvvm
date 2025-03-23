import '../models/post_model.dart';

/// An abstract class that defines the methods that a PostRepository class must implement.
abstract interface class PostRepository {
  Future<List<PostModel>> fetchPosts();
}
