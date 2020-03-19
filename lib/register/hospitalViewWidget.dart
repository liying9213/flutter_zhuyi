import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class hospitalViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var view = Scaffold(
      appBar: AppBar(
        title: Text("医院详情",style: TextStyle(color: Color(0xff333333),fontSize: 18.0),),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          hospital_heade_widget(),
          Expanded(
            child: hospital_deparment_widget(),
          ),
        ],
      ),
    );
    return view;
  }
}

class hospital_heade_widget extends StatefulWidget {
  @override
  _hospital_heade_widgetState createState() => _hospital_heade_widgetState();
}

class _hospital_heade_widgetState extends State<hospital_heade_widget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Flex(
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 8,top: 8),
            child: CachedNetworkImage(
              imageUrl: "null",
              height: 60,
              width: 80,
              placeholder: (context,url)=>Image.asset("name",width: 80,height: 60,),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 8,top: 8),
            child: Column(
              children: <Widget>[
                Container(
                  child: Text("",style: TextStyle(color: Color(0xff333333),fontSize: 14),),
                ),
                Container(
                  padding: EdgeInsets.only(left: 0,top: 2),
                  alignment: Alignment.topLeft,
                  height: 18,
                  child: Chip(
                    padding: EdgeInsets.only(top: -16,bottom: 0),
                    label: Text("",style: TextStyle(color: Color(0xff45C45A),fontSize: 10),),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 0,top: 6,right: 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("预约量：",style: TextStyle(color: Color(0xff999999),fontSize: 10),),
                      Text("",style: TextStyle(color: Color(0xff45C45A),fontSize: 10)),
                      Text("  距离：",style: TextStyle(color: Color(0xff999999),fontSize: 10)),
                      Text("0.0km",style: TextStyle(color: Color(0xff45C45A),fontSize: 10)),
                      Text("  评分：",style: TextStyle(color: Color(0xff999999),fontSize: 10)),
                      Text("".toString(),style: TextStyle(color: Color(0xff45C45A),fontSize: 10)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class hospital_deparment_widget extends StatefulWidget {
  @override
  _hospital_deparment_widgetState createState() => _hospital_deparment_widgetState();
}

class _hospital_deparment_widgetState extends State<hospital_deparment_widget> {
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: <Widget>[

      ],
    );
  }
}



