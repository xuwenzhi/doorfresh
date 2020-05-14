import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomeSwiper extends StatefulWidget {
  HomeSwiper({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeSwiperState createState() => new _HomeSwiperState();
}

class _HomeSwiperState extends State<HomeSwiper> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.red,
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body:  new Swiper(
        itemBuilder: (BuildContext context,int index){
          return new Image.network("http://via.placeholder.com/350x150", fit: BoxFit.fill,);
        },
        autoplay: true,
        itemWidth: 300.0,
        itemHeight: 400.0,
        // layout: SwiperLayout.CUSTOM,
        // customLayoutOption: new CustomLayoutOption(
        //     startIndex: -1,
        //     stateCount: 3
        // ).addRotate([
        //   -45.0/180,
        //   0.0,
        //   45.0/180
        // ]).addTranslate([
        //   new Offset(-370.0, -40.0),
        //   new Offset(0.0, 0.0),
        //   new Offset(370.0, -40.0)
        // ]),
        itemCount: 3,
        pagination: new SwiperPagination(),
        control: new SwiperControl(),
      ),
    );
  }
}