import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_gallery/model/Helper/photo_load_helper.dart';
import 'package:photo_gallery/model/service/photoApiService.dart';
import 'package:photo_gallery/provider/photo_view_data_provider.dart';
import 'package:photo_gallery/model/core/photoDataModel.dart';
import 'package:photo_gallery/view/photo_view_page.dart';
import 'package:provider/provider.dart';

class PhotoGallery extends StatelessWidget {
  PhotoGallery({Key? key}) : super(key: key);

  void _setFullScreenImageData(BuildContext context, String imageUrl) {
    Provider.of<PhotoViewDataProvider>(context, listen: false)
        .setImageUrl(imageUrl);
  }

  // PhotoApiService _loadPhoto=PhotoApiService();
  @override
  Widget build(BuildContext context) {
    final fullScreenData =
        Provider.of<PhotoViewDataProvider>(context, listen: false);

    final tenImageProvider=Provider.of<PhotoApiService>(context);
    tenImageProvider.loadTenPhotosList();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Center(child: Text("Photo Gallery")),
        ),
        body: GridView.builder(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          //physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount:tenImageProvider.loadedTenPhotos.length==null ? 0 : tenImageProvider.loadedTenPhotos.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            childAspectRatio: 3 / 2,
            mainAxisSpacing: 5,
            mainAxisExtent: MediaQuery.of(context).size.height * .15,
          ),
          itemBuilder: (context, index){
            var item=tenImageProvider.loadedTenPhotos[index];
            //print(item.toString());
            return GestureDetector(
              onTap: () {
                //print(item.toString()+">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
                fullScreenData.setImageUrl(item.toString());
                showDialog(
                  context: context,
                  builder: (context) => FullScreenView(),
                );
              },
              child: Container(
                //margin: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(item.toString()),
                      fit: BoxFit.contain),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                ),
              ),
            );
          },
        ));
  }
}
