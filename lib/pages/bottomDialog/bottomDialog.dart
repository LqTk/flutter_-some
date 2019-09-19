import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dio/dio.dart';

class BottomDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _bottomDialog();
  }
}

class _bottomDialog extends State<BottomDialog>{

  var imagePath;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 1080,height: 1920)..init(context);
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: imagePath==null?Text('点击选择图片'):Image.file(imagePath),
          ),
          RaisedButton(
            child: Text('点击'),
            onPressed: (){
              ShowBottomChooes(context);
            },
          )
        ],
      ),
    );
  }

  Future ShowBottomChooes(context) async{
    final option = await showModalBottomSheet(
        context:context,
        builder: (context){
          return Container(
            height: ScreenUtil().setHeight(500),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text('相机',textAlign: TextAlign.center,),
                    onTap: (){
                      Fluttertoast.showToast(msg: '从相机选择',toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM);
                      _takePhoto();
                      Navigator.pop(context);
                    },
                  ),
                ),
                Expanded(
                  child: ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('相册',textAlign: TextAlign.center,),
                    onTap: (){
                      Fluttertoast.showToast(msg: '从相册选择',toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM);
                      _openGallery();
                      Navigator.pop(context);
                    },
                  ),
                ),
                Expanded(
                  child: ListTile(
                    leading: Icon(Icons.arrow_back_ios),
                    title: Text('取消',textAlign: TextAlign.center,),
                    onTap: (){
                      Fluttertoast.showToast(msg: '取消',toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          );
        }
    );
  }

  _openGallery() async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imagePath = image;
    });
  }

  _takePhoto() async{
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imagePath = image;
    });
  }

}
