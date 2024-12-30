import 'package:flutter/material.dart';

class DeviceDimensions {
  static late double deviceHeight;
  static late double deviceWidth;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double textMultiplier;
  static late double imageSizeMultiplier;
  static late double heightMultiplier;

  static void init({required BuildContext context}) {
    final mediaQueryData = MediaQuery.of(context);
    deviceHeight = mediaQueryData.size.height;
    deviceWidth = mediaQueryData.size.width;

    // حساب النسبة المئوية لكل بلوك
    blockSizeHorizontal = deviceWidth / 100;
    blockSizeVertical = deviceHeight / 100;

    // عوامل إضافية للتحكم في النصوص والصور
    textMultiplier = blockSizeVertical;
    imageSizeMultiplier = blockSizeHorizontal;
    heightMultiplier = blockSizeVertical;
  }
}
