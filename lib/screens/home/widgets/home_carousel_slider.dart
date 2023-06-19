import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yahmart/model/home_banners_model.dart';
import '../../../utils/common_colors.dart';
import '../../../widgets/network_image_widget.dart';

class HomeCarouselSlider extends StatelessWidget {
  final List<HomeBannersModel> banner;
  const HomeCarouselSlider({Key? key, required this.banner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return banner.isNotEmpty
          ? CarouselSlider(
              items: banner.map(
                (x) {
                  return Container(
                    margin: const EdgeInsets.only(right: 5, left: 5),
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: NetworkImageWidget(
                        imageUrl: x.url!,
                      ),
                    ),
                  );
                },
              ).toList(),
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.2,
                //aspectRatio: 16 / 9,
                //enlargeCenterPage: true,
                viewportFraction: 0.99,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
              ),
            )
          : Shimmer.fromColors(
              baseColor: CommonColors.shimmerBaseColor,
              highlightColor: CommonColors.shimmerHighlightColor,
              child: Container(
                height: 150,
                margin: const EdgeInsets.only(right: 5, left: 5),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.3),
                    borderRadius: BorderRadius.circular(8)),
              ),
            );
    });
  }
}
