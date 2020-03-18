import 'package:flutter/material.dart';

class hospital_item_widget extends StatelessWidget {
  Map _hospitalMap;
  hospital_item_widget(Map hospitalMap){
    _hospitalMap = hospitalMap;
  }
  @override
  Widget build(BuildContext context) {
    var view = Container(
      padding: EdgeInsets.only(top: 10,bottom: 10,left: 16),
      child: Row(
        children: <Widget>[
          Image.network(_hospitalMap["imageUrl"],width: 80,height: 60,),
          Container(
            padding: EdgeInsets.only(left: 8,top: 2),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 8),
                  width: 300,
                  child: Text(_hospitalMap["hospitalName"],softWrap: false,style: TextStyle(color: Color(0xff333333),fontSize: 14),maxLines: 1,overflow: TextOverflow.ellipsis,),
                ),
                Container(
                    padding: EdgeInsets.only(left: 0,top: 2),
                    alignment: Alignment.topLeft,
                    width: 300,
                    height: 18,
                    child:Chip(
                      padding: EdgeInsets.only(top: -16,bottom: 0),
                      label: Text(_hospitalMap["hosRank"],style: TextStyle(color: Color(0xff45C45A),fontSize: 10)),
                      backgroundColor: Color(0xffE5F3E7),
                    ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 0,top: 2,right: 10),
                  width: 100,
                  alignment: Alignment.topLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("预约量：",style: TextStyle(color: Color(0xff999999),fontSize: 10),),
                      Text(_hospitalMap["appointNum"].toString(),style: TextStyle(color: Color(0xff45C45A),fontSize: 10)),
                      Text("  距离：",style: TextStyle(color: Color(0xff999999),fontSize: 10)),
                      Text("0.0km",style: TextStyle(color: Color(0xff45C45A),fontSize: 10)),
                      Text("  评分：",style: TextStyle(color: Color(0xff999999),fontSize: 10)),
                      Text(_hospitalMap["score"].toString(),style: TextStyle(color: Color(0xff45C45A),fontSize: 10)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
    return view;
  }
}
