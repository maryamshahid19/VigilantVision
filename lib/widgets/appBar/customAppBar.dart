import 'package:flutter/material.dart';
import 'package:vigilant_vision/constants/color_constants.dart';
import 'package:vigilant_vision/constants/screensize_constants.dart';
import 'package:vigilant_vision/widgets/text/customText.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({required this.title, super.key});

  final String title;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ClrUtils.primary,
      title: Padding(
        padding: EdgeInsets.only(left: SizeCons.getWidth(context) * 0.02),
        child: CustomText(
          text: title,
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
      ),
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications_on_outlined,
            size: 30,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: SizeCons.getWidth(context) * 0.05),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              "assets/icon/pic.PNG",
              height: 28,
              width: 28,
            ),
          ),
        ),
      ],
    );
  }
}
