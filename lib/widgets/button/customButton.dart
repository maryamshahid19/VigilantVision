import 'package:flutter/material.dart';
import 'package:vigilant_vision/constants/color_constants.dart';
import 'package:vigilant_vision/widgets/text/customText.dart';

class CustomButton extends StatelessWidget {
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
  final Color? borderColor;
  final double borderWidth;
  //final Icon? icon;
  final String? icon;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = ClrUtils.secondary,
    this.textColor = Colors.white,
    this.borderRadius = 10.0,
    this.elevation = 0,
    this.fontSize = 14.0,
    this.height = 48,
    this.width = double.infinity,
    this.fontWeight,
    this.borderColor,
    this.borderWidth = 1,
    this.icon = null,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(width, height),
        minimumSize: Size(width, height),
        padding: EdgeInsets.zero,
        foregroundColor: textColor,
        backgroundColor: color,
        elevation: elevation,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: borderWidth, color: borderColor ?? Colors.transparent),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Image.asset(icon!, height: 24, width: 24),
            SizedBox(width: 10),
          ],
          Text(
            text,
            style: TextStylesCons.custom(
                fontSize: fontSize,
                color: textColor,
                fontWeight: fontWeight ?? FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
