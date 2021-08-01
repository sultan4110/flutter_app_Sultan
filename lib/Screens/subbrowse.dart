import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/signin.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/services/firebase_storage_methods.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SubBrowse extends StatefulWidget {
  const SubBrowse({Key? key}) : super(key: key);

  @override
  _SubBrowseState createState() => _SubBrowseState();
}

class _SubBrowseState extends State<SubBrowse> {
  late Future<List<FirebaseFile>> futureFiles;
  int _currentIndex = 0;
  AuthMethods authMethods = new AuthMethods();

  @override
  void initState() {
    futureFiles = FirebaseStorageMethods.listAll('Images/');

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: AppBar(
            title: Text("Home"),
            centerTitle: true,
            actions: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35),
                  child: IconButton(icon: Icon(Icons.logout), onPressed: () {
                    authMethods.signOut();

                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => SignIn()));

                  }))
            ],
          ),
        ),
        body: FutureBuilder<List<FirebaseFile>>(
          future: futureFiles,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Center(child: Text('Some error occurred!'));
                } else {
                  final files = snapshot.data!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // buildHeader(files.length),
                      const SizedBox(height: 12),
                      Expanded(
                        child: StaggeredGridView.countBuilder(
                          staggeredTileBuilder: (index) => index % 7 == 0
                              ? StaggeredTile.count(2, 2)
                              : StaggeredTile.count(1, 1),
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 4,
                          crossAxisCount: 3,
                          itemCount: files.length,
                          itemBuilder: (context, index) {
                            final file = files[index];
                            return buildImageCard(context, file);
                          },
                        ),
                      ),
                    ],
                  );
                }
            }
          },
        ),
      );

  Widget buildImageCard(BuildContext context, FirebaseFile file) => Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
            margin: EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(file.url, width: 100, height: 100, fit: BoxFit.cover,),)),);



  Widget buildVideoCard(BuildContext context, FirebaseFile file) => Card(
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: Container(
        margin: EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child:

          Image.network(file.url, width: 100, height: 100, fit: BoxFit.cover,),)),);










  Widget buildHeader(int length) => ListTile(
        tileColor: Colors.blue,
        leading: Container(
          width: 52,
          height: 52,
          child: Icon(
            Icons.home,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Demo',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      );
}
