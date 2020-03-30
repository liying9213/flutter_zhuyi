import 'package:flutter/material.dart';

class mineWidget extends StatelessWidget {
  List _itemList = [
    {"image":"image/mine_doctor.png","title":"关注的医生"},
    {"image":"image/mine_system.png","title":"系统设置"},
    {"image":"image/mine_help.png","title":"帮助中心"},
    {"image":"image/mine_opinion.png","title":"我的建议"}
    ];
  @override
  Widget build(BuildContext context) {
    var scrollview = CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Stack(
            children: <Widget>[
              Container(
                height: 250,
                color: Color(0xfff5f5f5),
              ),
              Container(
                height: 180,
                color: Color(0xff45C45A),
              ),
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 60),
                    height: 80,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: (){
                        print("===========");
                      },
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Image.asset("image/user_default.png",width: 60,height: 60,),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text("点击登录",style: TextStyle(fontSize: 16,color: Colors.white),),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10,left: 20,right: 20),
                    height: 70,
                    color: Colors.white,
                    child: Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: functionItem("image/mine_patient.png", "我的就诊人",callback: (){
                            print("===========");
                          }),
                        ),
                        Expanded(
                          flex: 1,
                          child: functionItem("image/mine_appointment.png", "我的预约",callback: (){
                            print("===========");
                          }),
                        ),
                        Expanded(
                          flex: 1,
                          child: functionItem("image/mine_order.png", "我的订单",callback: (){
                            print("===========");
                          }),
                        ),
                        Expanded(
                          flex: 1,
                          child: functionItem("image/mine_consult.png", "我的咨询",callback: (){
                            print("===========");
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ]),
        ),
        SliverFixedExtentList(
          delegate: SliverChildBuilderDelegate(
            listItem,
            childCount: _itemList.length,
          ),
          itemExtent: 60,
        ),
      ],
    );

    var _scaffold = Scaffold(
//      appBar: AppBar(
//        backgroundColor: Color(0xff45C45A),
//        title: Text("我的",style: TextStyle(color: Colors.white,fontSize: 18.0),),
//    ),
      body: scrollview,
    );
    return _scaffold;
  }

  Widget listItem(BuildContext context, int index){
    var tap = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: (){

      },
      child:Container(
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left:16),
            child: Image.asset(_itemList[index]["image"],width: 25,height: 25,),
          ),
          Container(
            margin: EdgeInsets.only(left:8),
            child: Text(_itemList[index]["title"],style: TextStyle(color: Color(0xff666666),fontSize: 13),),
          )
        ],
      ),
      ),
    );
    return tap;
  }

  Widget functionItem(String imagePath,String title,{void Function() callback}){
    var tap = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: (){
        callback();
      },
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top:8),
            child: Image.asset(imagePath,width: 21,height: 21,),
          ),
          Container(
            margin: EdgeInsets.only(top:8),
            child: Text(title,style: TextStyle(color: Color(0xff666666),fontSize: 13),),
          )
        ],
      ),
    );
    return tap;
  }
}