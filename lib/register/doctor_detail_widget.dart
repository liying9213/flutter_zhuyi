import 'package:flutter/material.dart';

class doctor_detail_widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var view = Scaffold(
      appBar: AppBar(
        title: Text("医生详情",style: TextStyle(color: Color(0xffffffff),fontSize: 18.0),),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Color(0xffffffff)), onPressed:(){
          Navigator.pop(context);
        }),
        backgroundColor: Color(0xff45C45A),
        centerTitle: true,
      ),
      body: null,
    );
    return view;
  }
}
