import 'package:flutter/material.dart';

class ShopTab extends StatefulWidget {
  @override
  _ShopTabState createState() => _ShopTabState();
}

class _ShopTabState extends State<ShopTab> with AutomaticKeepAliveClientMixin<ShopTab> {
  @override
  void initState() {
    super.initState();
    print('initState Shop Tab');
  }

  @override
  Widget build(BuildContext context) {
    print('build Shop Tab');
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text(
          'This is content of Shop',
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}