import 'package:flutter/cupertino.dart';

class CommonText extends StatelessWidget {
  const CommonText(
      {super.key,
      required this.text,
      required this.sizeText,
      required this.colorText,
      required this.fontWeight,
      required this.fontFamily,
      required this.maxLines});

  final String text;

  final double sizeText;

  final Color colorText;

  final FontWeight fontWeight;

  final String fontFamily;

  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: sizeText,
        fontFamily: fontFamily,
        color: colorText,
        fontWeight: fontWeight,
      ),
    );
  }
}
