import 'package:flutter/material.dart';
import 'package:photo_gallery/core/controller/full_screen_data.dart';
import 'package:provider/provider.dart';

class FullScreenView extends StatelessWidget {
  const FullScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fullScreenData = Provider.of<FullScreenData>(context);
    //final size = MediaQuery.of(context).size;
    print(fullScreenData.imageUrl.toString());
    return InteractiveViewer(
      boundaryMargin: EdgeInsets.all(20.0),
      child: Image.network(
        fullScreenData.imageUrl,
        fit: BoxFit.contain,
      ),
    );
  }
}
