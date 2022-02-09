
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageTransformationController{

  TransformationController? controller;

  void initTransFormationState(){
    controller= TransformationController();
    //notifyListeners();
  }

  void disposeTransformation(){
    controller!.dispose();
    //notifyListeners();
  }

  void setControllerValue(var value){
    controller!.value=value;
    //notifyListeners();
  }


}