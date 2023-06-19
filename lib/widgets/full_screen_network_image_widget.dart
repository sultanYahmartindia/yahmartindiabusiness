import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yahmart/utils/common_colors.dart';

class FullScreenNetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  const FullScreenNetworkImageWidget({Key? key, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        viewFullImage(context);
      },
      child: CachedNetworkImage(
        //imageUrl: "https://storage.googleapis.com/yahmart-pre-prod.appspot.com/$imageUrl",
        imageUrl: imageUrl.startsWith("http")
            ? imageUrl
            : "https://storage.googleapis.com/yahmart-pre-prod.appspot.com/$imageUrl",
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.3),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.fill,
            ),
          ),
        ),
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: CommonColors.shimmerBaseColor,
          highlightColor: CommonColors.shimmerHighlightColor,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
          ),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
    /* return FullScreenWidget(
      child: Hero(
        tag: Random().nextInt(90) + 10,
        child: CachedNetworkImage(
          imageUrl: imageUrl.startsWith("http")
              ? imageUrl
              : "https://yahmartindia.in/api/v1/$imageUrl",
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.3),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.fill,
              ),
            ),
          ),
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: CommonColors.shimmerBaseColor,
            highlightColor: CommonColors.shimmerHighlightColor,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );*/
  }

  viewFullImage(context) {
    return showDialog(
      useSafeArea: false,
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
          child: Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 120, horizontal: 16),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: imageUrl.startsWith("http")
                      ? imageUrl
                      : "https://storage.googleapis.com/yahmart-pre-prod.appspot.com/$imageUrl",
                  //imageUrl: "https://storage.googleapis.com/yahmart-pre-prod.appspot.com/$imageUrl",
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.3),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: CommonColors.shimmerBaseColor,
                    highlightColor: CommonColors.shimmerHighlightColor,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Positioned(
                  top: 3,
                  right: 3,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: CommonColors.greyColor.withOpacity(.7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
