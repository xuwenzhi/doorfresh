import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:localstorage/localstorage.dart';

import '../struct/fresh_item.dart';


class FreshRecommendList extends StatefulWidget{
  @override
 _FreshRecommendListState createState() => _FreshRecommendListState();
}

class _FreshRecommendListState extends State<FreshRecommendList> {
  List<FreshItem> _posts = [];

  final LocalStorage storage = new LocalStorage('doorFresh');

  // final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  //     new GlobalKey<RefreshIndicatorState>();

  bool _isLoading = false;

  @override
  initState() {
    super.initState();

    String s = storage.getItem('recommend') ?? "";
    if (s == "") {
      print("Recommend fresh list get from server.");
      fetchPosts();
    } else {
     _posts = (json.decode(s) as List).map((i) =>
              FreshItem.fromJson(i)).toList();
      print("Recommend fresh list get from local storage.");
    }
  }

  Future<dynamic> fetchPosts() {
    if (_isLoading) return null;
    _isLoading = true;

    return http
        .get('https://xuwenzhi.com/recommend.php')
        .then((http.Response response) {

      final List<FreshItem> fetchedPosts = [];
      final List<dynamic> postsData = json.decode(response.body);
      print("recommend response...");
      print(postsData);

      if (postsData == null) {
        print("recommend postsData == null.");
        setState(() {
          _isLoading = false;
        });
      }
      for (var i = 0; i < postsData.length;i++) {
        List<FreshTag> tags = new List<FreshTag>();
        for (var j=0;j<postsData[i]['tags'].length; j++) {
          tags.add(FreshTag(
            id: postsData[i]['tags'][j]['id'],
            name: postsData[i]['tags'][j]['name'],
            color: postsData[i]['tags'][j]['color'],
            back_color: postsData[i]['tags'][j]['back_color'],
          ));
        }
        final FreshItem item = FreshItem (
            id: postsData[i]['id'],
            title: postsData[i]['title'],
            cover_image: postsData[i]['cover_image'],
            tags: tags);
        fetchedPosts.add(item);
      }
      print("Recomment write to local storage start..");
      storage.setItem('recommend', json.encode(fetchedPosts));
      print("Recomment write to local storage end..");
      setState(() {
        _posts = fetchedPosts;
        //
        _isLoading = false;
      });
    }).catchError((Object error) {
      print(error);
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<dynamic> _onRefresh() {
    return fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
      //key: _refreshIndicatorKey,
      margin: const EdgeInsets.only(bottom: 6, top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 2.0, color: Colors.grey[200]),
        ),
      ),
      child: ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: _posts.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 10.0, bottom: 10.0),
                      child: Text(
                        'Guess you like..',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    )
                  ],
                ),
              ],
            );
          }
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(_posts[index].cover_image),
            ),
            title: Text(_posts[index].title),
            subtitle: Text(_posts[index].title),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              print('horse $index');
            },
          );
        },
      ),
    );
  }
}
