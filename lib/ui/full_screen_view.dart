import 'package:flutter/material.dart';
import 'package:photo_gallery/core/controller/ImageTransformationController.dart';
import 'package:photo_gallery/core/controller/full_screen_data.dart';
import 'package:photo_gallery/core/controller/image_tap_down_details.dart';
import 'package:provider/provider.dart';

class FullScreenView extends StatelessWidget {
  const FullScreenView({Key? key}) : super(key: key);

  //late TransformationController controller;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //
  //   controller =TransformationController();
  // }
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   controller.dispose();
  // }

  @override
  Widget build(BuildContext context) {

    final fullScreenProvider = Provider.of<FullScreenData>(context);
    final transformationController = ImageTransformationController();
    final tapDownDetails=ImageTapDownDetails();

    transformationController.initTransFormationState();
    //final size = MediaQuery.of(context).size;
    print(fullScreenProvider.imageUrl.toString());
    return Scaffold(

      backgroundColor: Colors.black,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(24),
        child: GestureDetector(
          onDoubleTapDown: (details) {
            return tapDownDetails.setTapDownDetails(details);//tapDownDetails = details;
          },
          onDoubleTap: () {
            final position = tapDownDetails.tapDownDetails!.localPosition;

            final double scale = 3;
            final x = -position.dx * (scale - 1);
            final y = -position.dy * (scale - 1);
            final zoomed = Matrix4.identity()
              ..translate(x,y)
              ..scale(scale);
            final value =transformationController.controller!.value.isIdentity() ?zoomed:Matrix4.identity();
            //transformationController.initTransFormationState();
            transformationController.setControllerValue(value);
            //controller.value=value;
          },
          child: InteractiveViewer(
            clipBehavior: Clip.none,
            transformationController: transformationController.controller,
            panEnabled: false,
            scaleEnabled: false,
            //boundaryMargin: EdgeInsets.all(20.0),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                fullScreenProvider.imageUrl,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
