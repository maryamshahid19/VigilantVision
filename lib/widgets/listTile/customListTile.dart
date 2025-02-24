import 'package:flutter/material.dart';
import 'package:vigilant_vision/constants/color_constants.dart';
import 'package:vigilant_vision/widgets/text/customText.dart';

class CustomListTile extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double borderRadius;
  final double elevation;
  final double fontSize;
  final double height;
  final double width;
  final FontWeight? fontWeight;
  final Color borderColor;
  final double borderWidth;

  const CustomListTile({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = ClrUtils.primary,
    this.textColor = ClrUtils.textPrimary,
    this.borderRadius = 10.0,
    this.elevation = 0,
    this.fontSize = 14.0,
    this.height = 48,
    this.width = double.infinity,
    this.fontWeight = FontWeight.normal,
    this.borderColor = ClrUtils.border,
    this.borderWidth = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: ListTile(
        onTap: onPressed,
        leading: Image.asset('assets/icon/alert.png', width: 18, height: 18),
        title: CustomText(text: text),
        tileColor: const Color.fromARGB(58, 28, 225, 218),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
