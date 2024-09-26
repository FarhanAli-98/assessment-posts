// services/post_service.dart
import 'package:dio/dio.dart';
import '../models/post.dart';

class PostService {
  final Dio _dio = Dio();

  // Fetch posts from API
  Future<List<Post>> fetchPosts() async {
    final response = await _dio.get('https://jsonplaceholder.typicode.com/posts');
    List<dynamic> data = response.data;
    return data.map((json) => Post.fromJson(json)).toList();
  }
}
