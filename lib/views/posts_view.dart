import 'package:flutter/material.dart';
import 'package:test_project/repositories/posts_repository/posts_repository_im.dart';
import 'package:test_project/view_model/post_view_model.dart';
import 'package:test_project/view_model/posts_view_model.dart';

class PostsView extends StatelessWidget {
  PostsView({Key? key}) : super(key: key);
  //Dependency Injection
  var postsViewModel = PostsViewModel(postsRepository: PostsRepositoryImp());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(postsViewModel.title),
      ),
      body: Center(
        //FutureBuilder => take the data from server based on the speed of server
        child: FutureBuilder<List<PostViewModel>>(
          future: postsViewModel.fetchAllPosts(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const CircularProgressIndicator();
            }
            else{
              var posts = snapshot.data;
              return ListView.builder(
                itemCount: posts?.length,
                itemBuilder: (context, index) =>
                    ListTile(
                      title: Text(
                        posts![index].title,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                      tileColor: Colors.red,
                      leading: Image.network(
                        "https://t3.ftcdn.net/jpg/05/74/64/82/360_F_574648286_hRDp33jO9ZzvFZNS7JaTLBK695HGgfaW.jpg"
                      )
                    ),

              );
            }
          },
        )
      ),
    );
  }
}
