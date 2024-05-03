import 'package:flutter/material.dart';
import 'package:test_project/helper/database_helper.dart';
import 'package:test_project/models/user_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<UserModel> userList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
      ),
      body: getAllUsers(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  getAllUsers() {
    return FutureBuilder(
        future: _getData(),
        builder: (context, snapshot){
      return createListView(context, snapshot);
    });
  }

  Future<List<UserModel>> _getData() async{
    var dbHelper = DataBaseHelper.db;
    await dbHelper.getAllUsers().then((value) {
      // print(value);
      if(value != null) userList = value;
    });
    // return await dbHelper.getAllUsers();
    return userList;
  }

  createListView(BuildContext context, AsyncSnapshot snapshot) {
    userList = snapshot.data;
    if(snapshot.hasData && userList != null){
      return ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index){
          return Container();
        });
    }else{
      return Container();
    }
  }

  _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () => openAlertBox,
      backgroundColor: Colors.red,
      child: const Icon(Icons.add),
    );
  }
  openAlertBox(){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Container(
          width: 300,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Add Photo",
                  fillColor: Colors.grey,
                  border: InputBorder.none,

                )
              )
            ],
          ),
        ),
      );
    });
  }
}



// import 'package:flutter/material.dart';
// import 'package:test_project/helper/database_helper.dart';
// import 'package:test_project/models/user_model.dart';
//
// class HomeView extends StatefulWidget {
//   const HomeView({Key? key});
//
//   @override
//   State<HomeView> createState() => _HomeViewState();
// }
//
// class _HomeViewState extends State<HomeView> {
//   List<UserModel> userList = [];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Contacts"),
//       ),
//       body: getAllUsers(),
//       floatingActionButton: _buildFloatingActionButton(),
//     );
//   }
//
//   Widget getAllUsers() {
//     return FutureBuilder<List<UserModel>>(
//       future: _getData(),
//       builder: (context, snapshot) {
//         return createListView(context, snapshot);
//       },
//     );
//   }
//
//   Future<List<UserModel>> _getData() async {
//     var dbHelper = DataBaseHelper.db;
//     userList = await dbHelper.getAllUsers();
//     return userList;
//   }
//
//   Widget createListView(BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//       return const Center(child: CircularProgressIndicator());
//     } else if (snapshot.hasData && snapshot.data != null) {
//       userList = snapshot.data!;
//       return ListView.builder(
//         itemCount: userList.length,
//         itemBuilder: (context, index) {
//           return Container(); // Placeholder, replace with actual list item widget
//         },
//       );
//     } else if (snapshot.hasError) {
//       return Center(child: Text("Error: ${snapshot.error}"));
//     } else {
//       return const Center(child: Text("No data available"));
//     }
//   }
//
//   Widget _buildFloatingActionButton() {
//     return FloatingActionButton(
//       onPressed: openAlertBox,
//       backgroundColor: Colors.red,
//       child: const Icon(Icons.add),
//     );
//   }
//
//   void openAlertBox() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           content: Container(
//             width: 300,
//             child: Column(
//               children: [
//                 TextFormField(
//                   decoration: const InputDecoration(
//                     hintText: "Add Photo",
//                     fillColor: Colors.grey,
//                     border: InputBorder.none,
//                   ),
//                 )
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
