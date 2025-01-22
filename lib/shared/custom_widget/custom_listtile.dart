import 'package:flutter/material.dart';
import '../colors.dart';
import '../constants.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {super.key,
      required this.ontap,
      required this.image,
      required this.text,
      this.trailingText,
      this.descriptionText});
  final VoidCallback ontap;
  final String image;
  final String text;
  final String? trailingText;
  final String? descriptionText;
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
        trailing: Text(
          trailingText!,
          style: style.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.black,
            fontSize: 16,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: style.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.black,
                fontSize: 14,
              ),
            ),
            Text(
              descriptionText!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: style.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.black.withOpacity(.4),
                fontSize: 12,
              ),
            ),
          ],
        ));
    // title: Text(
    //   text,
    //   style: style.copyWith(
    //     fontWeight: FontWeight.w600,
    //     color: AppColors.appColor,
    //     fontSize: 15,
    //   ),
    // ));
  }
}
