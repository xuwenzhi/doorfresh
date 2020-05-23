import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:localstorage/localstorage.dart';

class Post {
  final int id;
  final String title;
  final String image;

  Post({
    @required this.id, 
    @required this.title,
    @required this.image});
  
  toJSONEncodable() {
    Map<String, dynamic> m = new Map();

    m['id'] = id;
    m['title'] = title;
    m['image'] = image;
    return m;
  }

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        title: json["title"],
        image: json["image"],
    );
}


class FreshTypeList extends StatefulWidget{

  @override
 _FreshTypeListState createState() => _FreshTypeListState();
}

class _FreshTypeListState extends State<FreshTypeList> {
  final LocalStorage storage = new LocalStorage('doorFresh');
  List<Post> _posts = [];

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  // After requesting data, should not update it to false.
  bool _isLoading = false;

  @override
  initState() {
    super.initState();

    String s = storage.getItem('types') ?? "";
    if (s == "") {
      print("Fresh types get from server.");
      fetchPosts();
    } else {
     _posts = (json.decode(s) as List).map((i) =>
              Post.fromJson(i)).toList();

      print("Fresh types get from local storage.");
    }
  }

  Future<dynamic> fetchPosts() {
    if (_isLoading) return null;
    _isLoading = true;

    return http
        .get('https://xuwenzhi.com/types.php')
        .then((http.Response response) {
      final List<Post> fetchedPosts = [];

      final List<dynamic> postsData = json.decode(response.body);
      print(postsData);
      if (postsData == null) {
        setState(() {
          _isLoading = false;
        });
      }
      for (var i = 0; i < postsData.length; i++) {
        final Post post = Post(
            id: postsData[i]['id'],
            title: postsData[i]['title'],
            image: postsData[i]['image']);
        fetchedPosts.add(post);
      }

      var data = jsonEncode(fetchedPosts.map((e) => e.toJSONEncodable()).toList());
      print("to json : "+data);
      storage.setItem('types', data);

      setState(() {
        _posts = fetchedPosts;
        _isLoading = false;
      });
    }).catchError((Object error) {
      print(error.toString());
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<dynamic> _onRefresh() {
    return fetchPosts();
  }


  Column _buildButtonColumn(Color color, String icon, String label) {
    return Column(
      textDirection: TextDirection.ltr,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
          icon, 
          width: 25,
        ), 
        Container(
          margin: const EdgeInsets.only(top: 1),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              fontFamily: 'BalsamiqSans',
              color: color,
            ),
          ),
        ),
      ],
    );
  }
  
  List<Widget> _createChildren() {
    return new List<Widget>.generate(_posts.length, (int index) {
      return _buildButtonColumn(Colors.green, _posts[index].image, _posts[index].title);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
      margin: const EdgeInsets.only(bottom: 3, top: 0),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(bottom: 5, top: 5),
      child: GridView(
        // prevent scrollable
        physics: new NeverScrollableScrollPhysics(),
        controller: new ScrollController(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5, //横轴三个子widget
            childAspectRatio: 1.4 //宽高比为1时，子widget
        ),
        children: _createChildren(),
      ),
      height: 120,
    );
  }
}
