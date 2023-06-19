import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/screens/home/widgets/home_categories_shimmer.dart';
import 'package:yahmart/utils/common_colors.dart';
import '../../../controller/home_controller.dart';
import '../../../utils/screen_constants.dart';
import '../../categories/sub_categories_screen.dart';
import '../../categories/widgets/category_widget.dart';
import '../../product_listing/product_listing_screen.dart';

class HomeCategoriesWidget extends StatelessWidget {
  HomeCategoriesWidget({Key? key}) : super(key: key);

  /// find home controller.
  final HomeController _homeC = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return _homeC.isHomeCatLoading.value
          ? Container(
              color: CommonColors.appBgColor,
              child: const HomeCategoriesShimmer())
          : Center(
              child: Container(
                color: CommonColors.appBgColor,
                child: _homeC.homeCategoryList.isNotEmpty
                    ? ScrollConfiguration(
                        behavior:
                            const ScrollBehavior().copyWith(overscroll: false),
                        child: SingleChildScrollView(
                          primary: false,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                _homeC.homeCategoryList.length,
                                (index) => Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: GestureDetector(
                                        onTap: () {
                                          if (_homeC.homeCategoryList[index]
                                              .subCategories.isNotEmpty) {
                                            Get.to(() => SubCategoriesScreen(
                                                  subCategories: _homeC
                                                      .homeCategoryList[index]
                                                      .subCategories,
                                                  catName: _homeC
                                                      .homeCategoryList[index]
                                                      .categoryName,
                                                ));
                                          } else {
                                            Get.to(() => ProductListingScreen(
                                                  categoryId: _homeC
                                                      .homeCategoryList[index]
                                                      .categoryId,
                                                ));
                                          }
                                        },
                                        child: CategoryWidget(
                                          categoryId: _homeC
                                              .homeCategoryList[index]
                                              .categoryId,
                                          catImage: _homeC
                                              .homeCategoryList[index]
                                              .categoryBannerImage,
                                          catName: _homeC
                                              .homeCategoryList[index]
                                              .categoryName,
                                        ),
                                      ),
                                    )),
                          ),
                        ),
                      )
                    : Text("Home categories not found.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: FontSize.s14,
                            fontWeight: FontWeight.bold)),
              ),
            );
    });
  }
}
