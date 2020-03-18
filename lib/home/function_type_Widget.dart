import 'package:flutter/material.dart';
import 'hospital_item_widget.dart';
import '../register/hospitalViewWidget.dart';

typedef clickCallback = void Function(int index);

class function_type_Widget extends StatelessWidget {
  clickCallback _callback;

  function_type_Widget ({clickCallback callback}){
    _callback = callback;
}

  @override
  Widget build(BuildContext context) {
    var _view = Container(
      height: 100,
      padding: EdgeInsets.only(top: 16,bottom: 16),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: function_type_item_Widget("按医院挂号", "image/hospital.png",0,
              callback: (index){
              _callback(index);
            },
            ),
          ),
          Expanded(
            flex: 1,
            child: function_type_item_Widget("专家咨询", "image/department.png",1,
              callback: (index){
                _callback(index);
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: function_type_item_Widget("名医讲堂", "image/disease.png",2,
              callback: (index){
                _callback(index);
              },
            ),
          ),
        ],
      ),
    );
    return _view;
  }
}

class function_type_item_Widget extends StatelessWidget {
  String _imagePath;
  String _title;
  int _index;
  clickCallback _callback;

  @override
  function_type_item_Widget(String title,String imagePath,int index, {clickCallback callback}){
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
          width: 40,
          height: 40,
        ),
        Text(
          _title,
          style:TextStyle(fontSize: 14,color:Color(0xff333333)),
        ),
      ],
    );
    var _supView = GestureDetector(
      onTap:(){
        _callback(_index);
      },
      child: _view,
    );
    return _supView;
  }
}

