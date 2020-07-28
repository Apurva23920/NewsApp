import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:News/screens/article_view.dart';

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, articleUrl;
  final DateTime publishedAt;
  BlogTile({
    @required this.imageUrl,
    @required this.title,
    @required this.desc,
    @required this.articleUrl,
    this.publishedAt,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ArticleView(
                          articleUrl: articleUrl,
                        )));
          },
          child: Column(
            children: <Widget>[
              Card(
                elevation: 4,
                child: Container(
                  margin: EdgeInsets.only(bottom: 16),
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: CachedNetworkImage(
                            imageUrl: imageUrl,
                          )),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Text(
                          title,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8, left: 8),
                        child: Text(
                          desc,
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.end,
                      //   children: <Widget>[
                      //     Text(
                      //       DateFormat.yMMMd().format(publishedAt),
                      //       style: TextStyle(fontSize: 14),
                      //     ),
                      //     Container(
                      //       child: PlayerWidget(body: title),
                      //     )
                      //   ],
                      // )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
