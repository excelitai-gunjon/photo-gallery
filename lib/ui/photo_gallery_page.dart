import 'package:flutter/material.dart';
import 'package:photo_gallery/core/controller/full_screen_data.dart';
import 'package:photo_gallery/core/model/photoDataModel.dart';
import 'package:photo_gallery/core/service/photoApiService.dart';
import 'package:photo_gallery/ui/full_screen_view.dart';
import 'package:provider/provider.dart';

class PhotoGallery extends StatelessWidget {
  const PhotoGallery({Key? key}) : super(key: key);

  void _setFullScreenImageData(BuildContext context,String imageUrl) {
    Provider.of<FullScreenData>(context,listen: false).setImageUrl(imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    final apiService = PhotoApiRequest();
    final fullScreenData=Provider.of<FullScreenData>(context,listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Center(child: Text("Photo Gallery")),
      ),
      body: FutureBuilder(
        future: apiService.loadPhotosList(),
        builder: (context, data) {
          if (data.hasError) {
            print(data.error.toString());
            return Center(child: Text("${data.error}"));
          } else if (data.hasData) {
            var items = data.data as List<PhotoDataModel>;
            print(items[0].url.toString());
            //print(items);
            return GridView.builder(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              //physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: items == null ? 0 : items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                childAspectRatio: 3 / 2,
                mainAxisSpacing: 5,
                mainAxisExtent: MediaQuery.of(context).size.height * .15,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {

                    print(items[index].downloadUrl.toString()+">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
                    fullScreenData.setImageUrl(items[index].downloadUrl.toString());

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
                          image:
                              NetworkImage(items[index].downloadUrl.toString()),
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
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
