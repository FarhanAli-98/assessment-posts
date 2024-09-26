import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'post_provider.dart';


class MultiProviders extends StatelessWidget {
  const MultiProviders({required this.child, super.key});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider<ConnectionNotifier>(
        //   create: (BuildContext context) => ConnectionNotifier(),
        // ),

        ChangeNotifierProvider<PostProvider>(
          create: (BuildContext context) => PostProvider(
       ),
        ),
      ],
      child: child,
    );
  }
}
