// screens/post_list_screen.dart
import 'package:assessment/app/provider/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class PostListScreen extends StatelessWidget {
  const PostListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: RefreshIndicator(
        onRefresh: postProvider.refreshPosts,
        child: Consumer<PostProvider>(
          builder: (context, provider, child) {
            // Show loading spinner when data is being fetched
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            // Handle no internet connection
            if (!provider.isConnected) {
              return Center(
                child: Text(
                  provider.errorMessage ?? 'No internet connection. Please check your connection.',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            // Handle error state and show the error message if needed
            if (provider.errorMessage != null && provider.posts.isEmpty) {
              return Center(child: Text(provider.errorMessage!));
            }

            // Display the list of posts in a ListView
            return ListView.builder(
              itemCount: provider.posts.length,
              itemBuilder: (context, index) {
                final post = provider.posts[index];
                return ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.body),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
