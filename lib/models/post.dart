// models/post.dart
class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  // Constructor to initialize the post fields.
  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  // Factory method to create a Post instance from JSON data.
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
