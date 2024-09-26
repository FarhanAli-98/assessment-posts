import 'package:flutter/material.dart';

import 'app/provider/multi_providers.dart';
import 'presentation/post/post_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProviders(
      child: MaterialApp(
        title: 'Assessment',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const PostListScreen(),
      ),
    );
  }
}

