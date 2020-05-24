import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:localstorage/localstorage.dart';

import '../struct/fresh_item.dart';
import '../tabs/fresh/fresh_detail.dart';
import '../utils/CustomTextStyle.dart';



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
            price: postsData[i]['price'],
            price_unit: postsData[i]['price_unit'],
            show_price: postsData[i]['show_price'],
            tags: tags);
        fetchedPosts.add(item);
      }
      print("Recomment write to local storage start..");
      storage.setItem('recommend', json.encode(fetchedPosts));
      print("Recomment write to local storage end..");
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

  Widget buildTag(FreshTag e) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            e.name,
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'BalsamiqSans',
              color: CustomTextStyle.hexToColor(e.color),
              backgroundColor: CustomTextStyle.hexToColor(e.back_color),
            ),
          ),
        ),
      ],
    );
  }

  

  Widget buildTags(index) {
    
    var tags = new List<Widget>.generate(_posts[index].tags.length, (int i) {
      return buildTag(_posts[index].tags[i]);
    });
    return new Container(
      alignment: Alignment.centerLeft,
      child: GridView(
        // prevent scrollable
        physics: new NeverScrollableScrollPhysics(),
        controller: new ScrollController(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, //横轴三个子widget
            childAspectRatio: 2 //宽高比为1时，子widget
        ),
        children: tags,
      ),
      height:20,
    );
  }

  Widget buildPrice(FreshItem fresh)
  {
    return Container(
      alignment: Alignment.centerLeft,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new Container(
            padding: const EdgeInsets.only(bottom: 8, top: 7),
            child: new Text(
              fresh.show_price,
              style: new TextStyle(
                fontFamily: 'BalsamiqSans',
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
      //key: _refreshIndicatorKey,
      //margin: const EdgeInsets.only(bottom: 1, top: 1),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.grey[200]),
        ),
      ),
      child: ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: _posts.length+1,
        itemBuilder: (BuildContext context, int index) {
          index = index - 1;
          if (index == -1) {
            return Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, left: 10.0, bottom: 15.0),
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
          return Card(
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              leading: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {},
                child: Container(
                  width: 100,
                  height: 100,
                  padding: EdgeInsets.symmetric(vertical: 1.0),
                  alignment: Alignment.center,
                  child: Image(
                    image: NetworkImage(
                      _posts[index].cover_image,
                    ),
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
              title: Text(
                _posts[index].title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              dense: false,
              subtitle: Column(
                children: <Widget> [
                  buildTags(index),
                  buildPrice(_posts[index]),
              ]),
              trailing:
                  Icon(Icons.keyboard_arrow_right, size: 30.0),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => FreshDetailPage(int.parse(_posts[index].id))));
              },
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}
