import 'package:News/helper/data.dart';
import 'package:News/helper/news.dart';
import 'package:News/model/article_model.dart';
import 'package:News/model/category_model.dart';
import 'package:News/widgets/blogTile.dart';
import 'package:flutter/material.dart';
import 'package:News/widgets/categoryTile.dart';
import 'package:News/Auth/Welcome/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;

  
  

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              ' Newz',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Text(
              'Buzz',
              style:
                  TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: <Widget>[
                  IconButton(icon: Icon(Icons.exit_to_app,color: Colors.black,),
                   onPressed: ()async{

                     FirebaseAuth.instance.signOut().then((onValue){
          Navigator.push(context, MaterialPageRoute(builder: (_) => WelcomeScreen() ));

          });

                   }
                  ),
                  

                      //code for returning to login page
                   
                ],
      ),
      body: _loading
          ? Center(
              child: Container(
              child: CircularProgressIndicator(),
            ))
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 70,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return CategoryTile(
                              imageUrl: categories[index].imageUrl,
                              categoryName: categories[index].categoryName,
                            );
                          }),
                    ),
                    //articles
                    Container(
                      padding: EdgeInsets.only(top: 16),
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: ClampingScrollPhysics(),
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            return BlogTile(
                                imageUrl: articles[index].urlToImage,
                                title: articles[index].title,
                                desc: articles[index].description,
                                articleUrl: articles[index].url,
                                publishedAt: articles[index].publishedAt,
                               
                                );
                                
                          }),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}




