import 'package:flutter/cupertino.dart';

class PhotoViewDataProvider with ChangeNotifier{

  String imageUrl="";

  void setImageUrl(String url){
    imageUrl=url;
    notifyListeners();
  }
}