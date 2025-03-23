import 'dart:convert';
import 'package:practice/core/constants/constant.dart';
import 'package:practice/models/post_model.dart';
import 'package:http/http.dart' as http;

/// A service class responsible for fetching posts from the API.
class PostService {
  Future<List<PostModel>> get() async {
    try {
      final url = Uri.parse('${Constant.baseUrl}/posts');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<PostModel> result =
            data.map((post) => PostModel.fromJson(post)).toList();
        return result;
      } else {
        throw Exception('Failed to fetch posts: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to fetch posts');
    }
  }
}
