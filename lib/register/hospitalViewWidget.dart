import 'package:flutter/material.dart';

class hospitalViewWidget extends StatefulWidget {
  @override
  _hospitalViewWidgetState createState() => _hospitalViewWidgetState();
}

class _hospitalViewWidgetState extends State<hospitalViewWidget> {
  @override
  Widget build(BuildContext context) {
    var view = Scaffold(
      appBar: AppBar(
        title: Text("医院详情",style: TextStyle(color: Color(0xff333333),fontSize: 18.0),),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
    );
    return view;
  }
}
