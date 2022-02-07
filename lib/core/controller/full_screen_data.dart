import 'package:flutter/cupertino.dart';

class FullScreenData with ChangeNotifier{

  String imageUrl="";

  void setImageUrl(String url){
    imageUrl=url;
    notifyListeners();
  }
}