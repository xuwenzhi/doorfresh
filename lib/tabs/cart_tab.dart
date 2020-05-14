import 'package:flutter/material.dart';

class CartTab extends StatefulWidget {
  @override
  _CartTabState createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> with AutomaticKeepAliveClientMixin<CartTab> {
  @override
  void initState() {
    super.initState();
    print('initState Cart Tab');
  }

  @override
  Widget build(BuildContext context) {
    print('build Cart Tab');
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Tab'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text(
          'This is content of Cart Tab',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}