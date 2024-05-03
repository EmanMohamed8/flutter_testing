import 'package:dio/dio.dart';
import 'package:test_project/models/post_model.dart';
import 'package:test_project/repositories/posts_repository/posts_repository.dart';


class PostsRepositoryImp extends PostsRepository{
  @override
  Future<List<PostModel>> getAllPosts() async {
    List<PostModel> posts = [];
    try{
      var response = await Dio().get("https://jsonplaceholder.typicode.com/posts");
      var list = response.data as List;
      posts = list.map((post) => PostModel.fromJson(post)).toList();
      print(posts);
    } catch(exception){
      print(exception);
    }
    return posts;
  }

  @override
  Future<PostModel> getPostById() {
    // TODO: implement getPostById
    throw UnimplementedError();
  }
}