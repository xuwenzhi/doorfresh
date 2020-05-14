import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';

class Post {
  final String title;
  final String body;

  Post(this.title, this.body);
}

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with AutomaticKeepAliveClientMixin<HomeTab> {
  @override
  void initState() {
    super.initState();
    print('initState Home');
  }
  
  @override
  Widget build(BuildContext context) {
    Widget titleSection = new Container(
      margin: const EdgeInsets.only(bottom: 6, top: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.grey[200]),
        ),
      ),
      padding: const EdgeInsets.all(10.0),
      child: new Row(
        children: [
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Container(
                  padding: const EdgeInsets.only(bottom: 8, top: 7),
                  child: new Text(
                    'COVID-19 | 我们的响应',
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                new Text(
                  '疫情期间我们将全力满足客户的需求及保障客户的安全。',
                  style: new TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          new Icon(
            Icons.room_service,
            color: Colors.red[500],
          ),
        ],
      ),
    );

    Widget textSection = Container(
      margin: const EdgeInsets.only(bottom: 1, top: 3),
      decoration: new BoxDecoration(
        color: Colors.white
      ),
      padding: const EdgeInsets.all(32),
      child: Text(
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
            'Alps. Situated 1,578 meters above sea level, it is one of the '
            'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
            'half-hour walk through pastures and pine forest, leads you to the '
            'lake, which warms to 20 degrees Celsius in the summer. Activities '
            'enjoyed here include rowing, and riding the summer toboggan run.',
        softWrap: true,
      ),
      
    );

    Column _buildButtonColumn(Color color, IconData icon, String label) {
      return Column(
        textDirection: TextDirection.ltr,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          Container(
            margin: const EdgeInsets.only(top: 1),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
        ],
      );
    }
    Color color = Theme.of(context).primaryColor;
    Widget buttonSection = Container(
      margin: const EdgeInsets.only(bottom: 5, top: 0),
      decoration: new BoxDecoration(
        color: Colors.white,
      ),
      height: 70,
      child: Row (
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(color, Icons.free_breakfast, '满35免运费'),
          _buildButtonColumn(color, Icons.local_shipping, '7天送货上门'),
          _buildButtonColumn(color, Icons.money_off, '无理由退换货'),
        ],
      ),
    );

    // Swiper Images
    Widget innerSwiper = Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: new Swiper(
        itemBuilder: (BuildContext context,int index){
          return new Image.asset('assets/images/b4.png', fit: BoxFit.fill,);
        },
        autoplay: true,
        itemCount: 3,
        // itemWidth: 300,
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
        pagination: new SwiperPagination(),
        control: new SwiperControl(
          size: 0,
        ),
        outer: false,
      ),
      height: 200,
    );

    // Image Tip
    Widget imageTip = Container(
      margin: const EdgeInsets.only(bottom: 8, top: 4),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Image.asset('assets/images/b4.png', fit: BoxFit.fill),
      height: 150,
    );

    Widget categories = Container(
      margin: const EdgeInsets.only(bottom: 5, top: 0),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(bottom: 8, top: 8),
      child: GridView(
        controller: new ScrollController(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5, //横轴三个子widget
            childAspectRatio: 1.4 //宽高比为1时，子widget
        ),
        children:<Widget>[
          _buildButtonColumn(Colors.green, Icons.public, '水果'),
          _buildButtonColumn(Colors.green, Icons.public, '蔬菜'),
          _buildButtonColumn(Colors.green, Icons.public, '肉类'),
          _buildButtonColumn(Colors.green, Icons.public, '海鲜'),
          _buildButtonColumn(Colors.green, Icons.public, '餐馆菜'),
          _buildButtonColumn(Colors.green, Icons.public, '面食点心'),
          _buildButtonColumn(Colors.green, Icons.public, '方便食品'),
          _buildButtonColumn(Colors.green, Icons.public, '烘焙'),
          _buildButtonColumn(Colors.green, Icons.public, '零食饮料'),
          _buildButtonColumn(Colors.green, Icons.public, '蛋奶豆制'),
        ]
      ),
      height: 140,
    );
    return MaterialApp(
      home: Scaffold (
        backgroundColor: Colors.grey[100],
        appBar: new AppBar(
          backgroundColor: Colors.green,
          title: Text('DoorFresh'),
          leading: Builder(builder: (context) {
            return IconButton(
              icon: Icon(Icons.restaurant, color: Colors.white), //自定义图标
              onPressed: () {
              },
            );
          }),
          
        ),
        body: ListView(
          children:<Widget> [
            innerSwiper,
            buttonSection,
            titleSection,
            categories,
            imageTip,
            textSection,
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}