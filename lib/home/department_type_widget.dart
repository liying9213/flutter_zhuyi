import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef clickCallback = void Function(String disease);


class department_type_widget extends StatelessWidget {
  List _array = [
    {"image":"image/department_0.png","name":"高血压"},
    {"image":"image/department_1.png","name":"心律失常"},
    {"image":"image/department_2.png","name":"颈椎"},
    {"image":"image/department_3.png","name":"帕金森"},
    {"image":"image/department_4.png","name":"乳腺"},
    {"image":"image/department_5.png","name":"湿疹"},
    {"image":"image/department_6.png","name":"头晕"},
    {"image":"image/department_7.png","name":"肿瘤"}
    ];
  clickCallback _callback;
  department_type_widget( {clickCallback callback}){
    _callback = callback;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 176,
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 16,bottom:16),
            alignment: Alignment.topLeft,
            child: Text("常见疾病",style: TextStyle(color: Color(0xff333333),fontSize: 16),textAlign: TextAlign.start,),
          ),
          contentView(_array,callback:(index){
            _callback(index);
          }),
        ],
      ),
    );
  }
}

class contentView extends StatelessWidget {
  List _array;
  clickCallback _callback;
  contentView(List array ,{clickCallback callback}){
    _array = array;
    _callback = callback;
  }
  @override
  Widget build(BuildContext context) {
    var gridView = GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio:1.5,
      ),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: getItem(callback: (index){
        _callback(index);
      }),
//      padding: EdgeInsets.only(top: 16),
    );
    return gridView;
  }

  List <Widget> getItem({clickCallback callback}){
    List<Widget> array = [];
    for(int i = 0; i < _array.length; i++){
      var item =  department_item_Widget(_array[i]["name"], _array[i]["image"],i,
        callback: (index){
          callback(index);
        },
      );
      array.add(item);
    }
    return array;
  }
}

class department_item_Widget extends StatelessWidget {
  String _imagePath;
  String _title;
  int _index;
  clickCallback _callback;

  @override
  department_item_Widget(String title,String imagePath,int index, {clickCallback callback}){
    _imagePath = imagePath;
    _title = title;
    _index = index;
    _callback= callback;
  }
  @override
  Widget build(BuildContext context) {
    var _view = Column(
      children: <Widget>[
        Image.asset(
          _imagePath,
          width: 30,
          height: 30,
        ),
        Text(
          _title,
          style:TextStyle(fontSize: 12,color:Color(0xff333333)),
        ),
      ],
    );
    var _supView = GestureDetector(
      onTap:(){
        _callback(_title);
      },
      child: _view,
    );
    return _supView;
  }
}

