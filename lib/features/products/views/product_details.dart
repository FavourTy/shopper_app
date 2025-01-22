import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sca_shopper/models/response_model/product_model.dart';
import 'package:sca_shopper/shared/constants.dart';

import '../../../shared/colors.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, this.model});

  final ProductModel? model;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool isNaira = true;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detailed Description",
          style: style.copyWith(
            fontSize: 20,
            color: AppColors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.white),
        backgroundColor: AppColors.appColor,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isNaira = !isNaira;
                });
              },
              icon:
                  Icon(isNaira ? Icons.currency_exchange : Icons.attach_money))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider.builder(
                itemCount: widget.model?.images?.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) {
                  final img = widget.model?.images?[itemIndex];
                  return SizedBox(
                    height: height * .5,
                    width: width,
                    child: Image.network(
                      img ?? "",
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) {
                        return Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.black.withOpacity(.1)),
                          height: height * .5,
                          width: width,
                          child: Icon(
                            Icons.image_not_supported,
                            color: AppColors.black.withOpacity(.3),
                          ),
                        );
                      },
                    ),
                  );
                },
                options: CarouselOptions(
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: false,
                  aspectRatio: 1,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                widget.model?.title ?? "",
                style: style.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                  fontSize: 20,
                ),
              ),
              Text(
                isNaira
                    ? (widget.model?.price?.convertToNaira() ?? "")
                    : (widget.model?.price != null
                        ? "\$${widget.model?.price}"
                        : ""),
                style: style.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.appColor,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.model?.description ?? "",
                style: style.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.black.withOpacity(.3),
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
