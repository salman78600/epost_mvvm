import 'package:flutter/material.dart';
import 'package:practice/repositories/post_repository_impl.dart';
import 'package:practice/services/post_service.dart';
import 'package:practice/viewModels/post_view_model.dart';
import 'package:practice/views/post_view.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

/* 
  A StatelessWidget that initializes the PostViewModel and provides it to the PostView.
  The PostViewModel is created with a PostRepositoryImpl instance.
*/
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
          create: (context) => PostViewModel(PostRepositoryImpl(PostService())),
          child: const PostView()),
    );
  }
}
