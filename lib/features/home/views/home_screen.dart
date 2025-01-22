import 'package:flutter/material.dart';
import 'package:sca_shopper/services/cache_service.dart';
import 'package:sca_shopper/shared/Navigation/app_route_strings.dart';
import 'package:sca_shopper/shared/Navigation/app_router.dart';
import 'package:sca_shopper/shared/colors.dart';
import 'package:sca_shopper/shared/constants.dart';
import 'package:sca_shopper/shared/custom_widget/custom_listtile.dart';

import '../../../repository/api_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final cache = CacheService();

  final apiRepo = ApiRepository();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appColor,
          title: Text(
            "Home Screen",
            style: style.copyWith(
              fontSize: 20,
              color: AppColors.white,
            ),
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  await cache.deleteToken().then((_) {
                    AppRouter.push(AppRouteStrings.loginScreen);
                  });
                },
                child: Text(
                  "Logout",
                  style: style.copyWith(fontSize: 15, color: AppColors.white),
                ))
          ],
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Categories",
                  style: style.copyWith(
                    fontSize: 20,
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation(AppColors.appColor),
                        ),
                      )
                    : FutureBuilder(
                        builder: (_, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            // setState(() {
                            //   isLoading = true;
                            // });
                            return const Center(
                                child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation(AppColors.appColor),
                            ));
                          } else if (snapshot.hasError) {
                            return const Center(
                                child: Text("Could not fetch categories"));
                          } else if (snapshot.data?.error != null) {
                            return Center(
                              child: Text(snapshot.data?.error ??
                                  "Could not fetch categories"),
                            );
                          }
                          // setState(() {
                          //   isLoading = false;
                          // });
                          return ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (_, i) {
                                final each = snapshot.data?.cats?[i];
                                return CustomListTile(
                                    ontap: () {
                                      AppRouter.push(
                                          AppRouteStrings.productListScreen,
                                          arg: each);
                                    },
                                    image: each?.image ?? "",
                                    text: each?.name ?? "");
                              },
                              separatorBuilder: (_, __) => const Divider(
                                    height: 0,
                                  ),
                              itemCount: snapshot.data?.cats?.length ?? 0);
                        },
                        future: apiRepo.fetchCategories(),
                      ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "All Products",
                  style: style.copyWith(
                    fontSize: 20,
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation(AppColors.appColor),
                        ),
                      )
                    : FutureBuilder(
                        builder: (_, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            // setState(() {
                            //   isLoading = true;
                            // });
                            return const Center(
                                child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation(AppColors.appColor),
                            ));
                          } else if (snapshot.hasError) {
                            return const Center(
                                child: Text("Could not fetch categories"));
                          } else if (snapshot.data?.error != null) {
                            return Center(
                              child: Text(snapshot.data?.error ??
                                  "Could not fetch categories"),
                            );
                          }
                          // setState(() {
                          //   isLoading = false;
                          // });
                          return ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (_, i) {
                                final each = snapshot.data?.products?[i];

                                return CustomListTile(
                                  ontap: () {
                                    AppRouter.push(
                                        AppRouteStrings.productDetailsScreen,
                                        arg: each);
                                  },
                                  image: each?.images?.firstOrNull ?? "",
                                  text: each?.title ?? "",
                                );
                              },
                              separatorBuilder: (_, __) => const Divider(
                                    height: 0,
                                  ),
                              itemCount: snapshot.data?.products?.length ?? 0);
                        },
                        future: apiRepo.fetchProducts(),
                      ),
              ],
            ),
          ),
        ));
  }
}
