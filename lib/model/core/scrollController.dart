import 'package:flutter/cupertino.dart';
import 'package:photo_gallery/model/service/photoApiService.dart';


class GalleryScrollController{

  ScrollController _scrollController=ScrollController();

  void initScrollController(){
    final loadTenPhoto=PhotoApiService();
    _scrollController.addListener((){
      if(_scrollController.position.pixels==_scrollController.position.maxScrollExtent){
        loadTenPhoto.loadTenPhotosList();
        // PhotoApiService
        // tenImage.fetchTenImage();
      }
    }
    );
  }

  void disposeScrollController(){
    _scrollController.dispose();
  }

}