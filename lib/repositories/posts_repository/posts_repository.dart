import 'package:test_project/models/post_model.dart';

abstract class PostsRepository{
  Future<List<PostModel>> getAllPosts();
  Future<PostModel> getPostById();
}