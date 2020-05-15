import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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
  
  // title secontion
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
                    'COVID-19 | Our Response',                    
                    style: new TextStyle(
                      fontFamily: 'BalsamiqSans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                new Text(
                  'During the epidemic, we will do our best to meet customer needs and ensure customer safety.',
                  style: new TextStyle(
                    fontFamily: 'BalsamiqSans',
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
        style: new TextStyle(
          fontFamily: 'BalsamiqSans',
          color: Colors.grey[500],
        ),
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
                fontFamily: 'BalsamiqSans',
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
          _buildButtonColumn(color, Icons.free_breakfast, 'Free ship over \$35'),
          _buildButtonColumn(color, Icons.local_shipping, 'Delivery within 7 days'),
          _buildButtonColumn(color, Icons.money_off, 'No reason to return'),
        ],
      ),
    );

    Widget innerSwiper = Container(
      margin: const EdgeInsets.only(top:0),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: new Swiper(
        itemBuilder: (BuildContext context,int index){
          return new Image.asset('assets/images/b5.png', fit: BoxFit.fill,);
        },
        autoplay: true,
        itemCount: 6,
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
      child: Image.asset('assets/images/b5.png', fit: BoxFit.fill),
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
          _buildButtonColumn(Colors.green, Icons.public, 'fruit'),
          _buildButtonColumn(Colors.green, Icons.public, 'vegetable'),
          _buildButtonColumn(Colors.green, Icons.public, 'meat'),
          _buildButtonColumn(Colors.green, Icons.public, 'seafood'),
          _buildButtonColumn(Colors.green, Icons.public, 'dish food'),
          _buildButtonColumn(Colors.green, Icons.public, 'snack'),
          _buildButtonColumn(Colors.green, Icons.public, 'Micro food'),
          _buildButtonColumn(Colors.green, Icons.public, 'baking'),
          _buildButtonColumn(Colors.green, Icons.public, 'beverage'),
          _buildButtonColumn(Colors.green, Icons.public, 'milk'),
        ]
      ),
      height: 140,
    );
    return MaterialApp(
      home: Scaffold (
        resizeToAvoidBottomInset:false,
        backgroundColor: Colors.grey[100],
        appBar: new AppBar(
          backgroundColor: Colors.green,
          title: Text('DoorFresh',
            style: TextStyle(
              fontFamily: 'BalsamiqSans',
            ),
          ),
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
            Container(
              margin: const EdgeInsets.only(),
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: "Search some staff...",
                  enabled: true,
                  filled: true,
                ),
              ),
            ),
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