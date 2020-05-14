import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with AutomaticKeepAliveClientMixin<Profile> {
  @override
  void initState() {
    super.initState();
    print('initState Profile');
  }

  @override
  Widget build(BuildContext context) {
    print('build Profile Tab');
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text(
          'This is content of Profile',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => false;
}