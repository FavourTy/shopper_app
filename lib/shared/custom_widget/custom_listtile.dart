import 'package:flutter/material.dart';

import '../Navigation/app_route_strings.dart';
import '../Navigation/app_router.dart';
import '../colors.dart';
import '../constants.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {super.key,
      required this.ontap,
      required this.image,
      required this.text});
  final VoidCallback ontap;
  final String image;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
        onTap: ontap,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(
            image,
            height: 50,
            width: 50,
            errorBuilder: (_, __, ___) {
              return Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.black.withOpacity(.1)),
                height: 50,
                width: 50,
                child: Icon(
                  Icons.image_not_supported,
                  color: AppColors.black.withOpacity(.3),
                ),
              );
            },
          ),
        ),
        title: Text(
          text,
          style: style.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.appColor,
            fontSize: 15,
          ),
        ));
  }
}
