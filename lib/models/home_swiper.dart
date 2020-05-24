import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:localstorage/localstorage.dart';
import '../struct/swiper.dart';



class HomeSwiper extends StatefulWidget{
  @override
 _HomeSwiperState createState() => _HomeSwiperState();
}

class _HomeSwiperState extends State<HomeSwiper> {
  List<SwiperItem> _posts = [];

  final LocalStorage storage = new LocalStorage('doorFresh');

  // final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  //     new GlobalKey<RefreshIndicatorState>();

  bool _isLoading = false;

  @override
  initState() {
    super.initState();
    String s = storage.getItem('homeswiper') ?? "";
    if (s == "") {
      print("Home swiper list get from server.");
      fetchPosts();
    } else {
     _posts = (json.decode(s) as List).map((i) =>
              SwiperItem.fromJson(i)).toList();
      print("Home swiper list get from local storage.");
    }
  }

  Future<dynamic> fetchPosts() {
    if (_isLoading) return null;
    _isLoading = true;

    return http
        .get('https://xuwenzhi.com/swiper.php')
        .then((http.Response response) {

      final List<SwiperItem> fetchedPosts = [];
      final List<dynamic> postsData = json.decode(response.body);
      print("home swiper response...");
      print(postsData);

      if (postsData == null) {
        print("home swiper postsData == null.");
        setState(() {
          _isLoading = false;
        });
      }
      for (var i = 0; i < postsData.length;i++) {
        final SwiperItem item = SwiperItem (
            id: postsData[i]['id'],
            image: postsData[i]['image'],
          );
        fetchedPosts.add(item);
      }
      print("HomeSwiper write to local storage start..");
      storage.setItem('homeswiper', json.encode(fetchedPosts));
      print("HomeSwiper write to local storage end..");
      setState(() {
        _posts = fetchedPosts;
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
      margin: const EdgeInsets.only(top:0),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: new Swiper(
        itemBuilder: (BuildContext context,int index){
          return Image.network(_posts[index].image, fit: BoxFit.fill);
        },
        autoplay: true,
        itemCount: _posts.length,
        pagination: new SwiperPagination(),
        control: new SwiperControl(
          size: 0,
        ),
        outer: false,
      ),
      height: 200,
    );
  }
}
