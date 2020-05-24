import 'package:flutter/material.dart';
import '../../utils/CustomTextStyle.dart';

class FreshDetailPage extends StatefulWidget {
  int fresh_id;
  FreshDetailPage(int id) {
    fresh_id = id;
  }
  @override
  _FreshDetailPageState createState() => _FreshDetailPageState();
}

class _FreshDetailPageState extends State<FreshDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Fresh Detail",
          style: CustomTextStyle.textFormFieldBold.copyWith(fontSize: 18),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(8),
          child: Text(
            "Fresh Id : " + widget.fresh_id.toString(),
            style: CustomTextStyle.textFormFieldMedium
                .copyWith(fontSize: 16, color: Colors.grey.shade800),
          ),
        ),
      ),
    );
  }
}
