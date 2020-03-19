import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

typedef clickCallback = void Function(String doctorId);

class doctor_item_widget extends StatelessWidget {
  Map _doctormap;
  clickCallback _callback;
  doctor_item_widget(Map doctormap,{clickCallback callback}){
    _doctormap = doctormap;
    _callback = callback;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8,top: 4,bottom: 4),
      child: GestureDetector(
        onTap: (){
          _callback(_doctormap["id"].toString());
        },
        child: Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CachedNetworkImage(
              alignment: Alignment.topCenter,
              imageUrl: _doctormap["picture"],
              width: 42,
              height: 42,
              placeholder: (context, url)=>Image.asset("image/doctorDefault.png",width: 42,height: 42,),
            ),
            Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Text(_doctormap["name"],style: TextStyle(color: Color(0xff333333),fontSize: 14),),
                            Text(" ",style: TextStyle(color: Color(0xff333333),fontSize: 14),),
                            Text(_doctormap["level"],style: TextStyle(color: Color(0xff6C7671),fontSize: 12),),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 2),
                        child: Text(
                          "医院："+_doctormap["hospitalName"],
                          style: TextStyle(color: Color(0xff6C7671),fontSize: 12),
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 2),
                        child: Text(
                          "擅长："+_doctormap["expert"],
                          maxLines: 1,
                          style: TextStyle(color: Color(0xff6C7671),fontSize: 12),
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 2,bottom: 4),
                        child: Row(
                          children: <Widget>[
                            Text("预约量：",style: TextStyle(color: Color(0xff6C7671),fontSize: 11),),
                            Text(_doctormap["count"].toString(),style: TextStyle(color: Color(0xff45C45A),fontSize: 11),),
                            Text("    评分：",style: TextStyle(color: Color(0xff6C7671),fontSize: 11),),
                            Text(_doctormap["score"].toString(),style: TextStyle(color: Color(0xff45C45A),fontSize: 11),),
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        color: Color(0xffeeeeee),
                      ),
                    ],
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
