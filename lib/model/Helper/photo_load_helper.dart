
import 'dart:convert';
import 'package:photo_gallery/model/core/photoDataModel.dart';
import 'package:photo_gallery/model/service/photoApiService.dart';

class PhotoLoadHelper{

  List<String> loadedTenPhotos=[];
  PhotoApiService service= PhotoApiService();

  loadTenPhotosList() async {
    String jsonPhotos = await service.loadPhotoJson();
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

    //notifyListeners();
    return loadedTenPhotos;//photosList.photos;

  }

}