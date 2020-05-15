import 'package:flutter/material.dart';

class CategoryTab extends StatefulWidget {
  @override
  _CategoryTabState createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> with AutomaticKeepAliveClientMixin<CategoryTab> {
  @override
  void initState() {
    super.initState();
    print('initState Category Tab');
  }

  @override
  Widget build(BuildContext context) {
    print('build Category Tab');
    return Scaffold(
      appBar: AppBar(
        title: Text('Category'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text(
          'This is content of Category',
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}