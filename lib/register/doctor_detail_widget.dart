import 'package:flutter/material.dart';

class doctor_detail_widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var view = Scaffold(
      appBar: AppBar(
        title: Text("医生详情",style: TextStyle(color: Color(0xff333333),fontSize: 18.0),),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
    );
    return view;
  }
}
