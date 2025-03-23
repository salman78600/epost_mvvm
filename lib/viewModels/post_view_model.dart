import 'package:flutter/material.dart';
import 'package:practice/models/post_model.dart';
import 'package:practice/repositories/post_repository.dart';

/// A ChangeNotifier class that provides the list of posts and the loading state.
/// This class is responsible for fetching posts from the PostRepository.
/// It notifies its listeners when the list of posts or the loading state changes.
/// It also provides an error message in case of an error.
class PostViewModel extends ChangeNotifier {
  final PostRepository _postRepository;
  PostViewModel(this._postRepository);
  List<PostModel> _posts = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<PostModel> get posts => _posts;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchPosts() async {
    _isLoading = true;
    notifyListeners();
    try {
      _posts = await _postRepository.fetchPosts();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
