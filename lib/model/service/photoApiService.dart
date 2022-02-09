import 'dart:convert';

//import 'package:photo_gallery/core/model/photoDataModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:photo_gallery/model/core/photoDataModel.dart';

class PhotoApiService with ChangeNotifier{

  List<String> loadedTenPhotos=[];


  Future<String> loadPhotoJson() async {
    final response = await http.get(
      Uri.parse("https://picsum.photos/v2/list?page=1&limit=30"),
      // body: {
      //   "page": "1",
      //   "limit": "5",
      // },
    );

    if (response.statusCode == 200){
      print(response.body);
      return response.body;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  loadTenPhotosList() async {
    String jsonPhotos = await loadPhotoJson();
    final jsonResponse = json.decode(jsonPhotos);
    PhotosList photosList = PhotosList.fromJson(jsonResponse);

    for(int i=0;i<photosList.photos!.length;i++){
      loadedTenPhotos.add(photosList.photos![i].downloadUrl.toString());
      print(i.toString());
    }

    for(int i=0;i<loadedTenPhotos.length;i++){
      //loadedTwentyPhotos.add(photosList.photos![i].downloadUrl.toString());
      print(loadedTenPhotos[i].toString());
      print(i.toString());
    }
    //loadedTwentyPhotos=List.from(loadedTwentyPhotos)..addAll(loadPhotosList() as List<PhotoDataModel>);
    notifyListeners();
    return loadedTenPhotos;//photosList.photos;

  }

}
