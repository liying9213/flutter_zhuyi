import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

typedef clickCallback = void Function(String hospitalId);

class hospital_item_widget extends StatelessWidget {
  Map _hospitalMap;
  clickCallback _callback;
  hospital_item_widget(Map hospitalMap,{clickCallback callback}){
    _hospitalMap = hospitalMap;
    _callback = callback;
  }
  @override
  Widget build(BuildContext context) {
    var view = Container(
      padding: EdgeInsets.only(top: 10,bottom: 10,left: 16),
      child:GestureDetector(
        onTap: (){
          _callback(_hospitalMap["id"].toString());
        },
        child:  Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: _hospitalMap["imageUrl"],
              width: 80,height: 60,
              placeholder: (context, url)=>Image.asset("image/hospitalDefault.png",width: 80,height: 60,),
            ),
            Expanded(
              child:Container(
                padding: EdgeInsets.only(left: 8,right: 8),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        _hospitalMap["hospitalName"],
                        softWrap: false,
                        style: TextStyle(color: Color(0xff333333),fontSize: 14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 0,top: 2),
                      alignment: Alignment.topLeft,
                      height: 18,
                      child:Chip(
                        padding: EdgeInsets.only(top: -16,bottom: 0),
                        label: Text(_hospitalMap["hosRank"],style: TextStyle(color: Color(0xff45C45A),fontSize: 10)),
                        backgroundColor: Color(0xffE5F3E7),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 0,top: 6,right: 0),
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
            ),
          ],
        ),
      ),
    );
    return view;
  }
}
