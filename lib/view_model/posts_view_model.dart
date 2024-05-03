import 'package:dio/dio.dart';
import 'package:test_project/models/post_model.dart';
import 'package:test_project/repositories/posts_repository/posts_repository.dart';
import 'package:test_project/view_model/post_view_model.dart';

class PostsViewModel{
  String title = "Posts Page";
  PostsRepository? postsRepository;
  PostsViewModel({this.postsRepository});
  Future<List<PostViewModel>> fetchAllPosts() async {
    List<PostModel> list = await postsRepository!.getAllPosts();
    return list.map((post) => PostViewModel(postModel: post)).toList();
  }
}