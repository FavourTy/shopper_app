import 'package:flutter/material.dart';
import 'package:sca_shopper/models/response_model/category_model.dart';
import 'package:sca_shopper/shared/colors.dart';
import 'package:sca_shopper/shared/custom_widget/custom_listtile.dart';

import '../../../repository/api_repository.dart';
import '../../../shared/Navigation/app_route_strings.dart';
import '../../../shared/Navigation/app_router.dart';
import '../../../shared/constants.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key, this.categoryModel});

  final CategoryModel? categoryModel;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final apiRepo = ApiRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.white),
          backgroundColor: AppColors.appColor,
          title: Text(
            widget.categoryModel?.name ?? "Product List",
            style: style.copyWith(
              fontSize: 20,
              color: AppColors.white,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              FutureBuilder(
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(AppColors.appColor),
                    ));
                  } else if (snapshot.hasError) {
                    return const Center(
                        child: Text("Could not fetch Products"));
                  } else if (snapshot.data?.error != null) {
                    return Center(
                      child: Text(
                          snapshot.data?.error ?? "Could not fetch Products"),
                    );
                  } else if (snapshot.data?.products?.isEmpty ?? false) {
                    return const Center(
                      child: Text("No Product found"),
                    );
                  }
                  return Expanded(
                    child: ListView.separated(
                        itemBuilder: (_, i) {
                          final each = snapshot.data?.products?[i];
                          return CustomListTile(
                            ontap: () {
                              AppRouter.push(
                                  AppRouteStrings.productDetailsScreen,
                                  arg: each);
                            },
                            image: each?.images?.firstOrNull ?? "",
                            trailingText: each?.price?.convertToNaira() ?? "",
                            text: each?.title ?? "",
                            descriptionText: each?.description ?? "",
                          );
                          // return ListTile(
                          //     contentPadding:
                          //         const EdgeInsets.symmetric(vertical: 15),
                          //     onTap: () {
                          //       AppRouter.push(
                          //           AppRouteStrings.productDetailsScreen,
                          //           arg: each);
                          //     },
                          //     leading: ClipRRect(
                          //       borderRadius: BorderRadius.circular(50),
                          //       child: Image.network(
                          //         each?.images?.firstOrNull ?? "",
                          //         height: 50,
                          //         width: 50,
                          //         errorBuilder: (_, __, ___) {
                          //           return Container(
                          //             decoration: BoxDecoration(
                          //                 shape: BoxShape.circle,
                          //                 color:
                          //                     AppColors.black.withOpacity(.1)),
                          //             height: 50,
                          //             width: 50,
                          //             child: Icon(
                          //               Icons.image_not_supported,
                          //               color: AppColors.black.withOpacity(.3),
                          //             ),
                          //           );
                          //         },
                          //       ),
                          //     ),
                          //     trailing: Text(
                          //       each?.price?.convertToNaira() ?? "",
                          //       style: style.copyWith(
                          //         fontWeight: FontWeight.w600,
                          //         color: AppColors.black,
                          //         fontSize: 16,
                          //       ),
                          //     ),
                          //     title: Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         Text(
                          //           each?.title ?? "",
                          //           style: style.copyWith(
                          //             fontWeight: FontWeight.w600,
                          //             color: AppColors.black,
                          //             fontSize: 14,
                          //           ),
                          //         ),
                          //         Text(
                          //           each?.description ?? "",
                          //           maxLines: 2,
                          //           overflow: TextOverflow.ellipsis,
                          //           style: style.copyWith(
                          //             fontWeight: FontWeight.w400,
                          //             color: AppColors.black.withOpacity(.4),
                          //             fontSize: 12,
                          //           ),
                          //         ),
                          //       ],
                          //     ));
                        },
                        separatorBuilder: (_, __) => Divider(
                              height: 0,
                            ),
                        itemCount: snapshot.data?.products?.length ?? 0),
                  );
                },
                future: apiRepo.fetchProductsById(
                    (widget.categoryModel?.id ?? "").toString()),
              )
            ],
          ),
        ));
  }
}
