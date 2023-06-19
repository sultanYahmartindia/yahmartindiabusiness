import 'package:flutter/material.dart';
import 'package:yahmart/utils/common_images.dart';
import '../utils/screen_constants.dart';

// ignore: must_be_immutable
class NoDataScreen extends StatelessWidget {
  final String? message;
  const NoDataScreen({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 200,
            width: 300,
            alignment: Alignment.center,
            child: Image.asset(CommonImages.noResultGif),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(message ?? "No Data Found.",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: FontSize.s16,
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 150,
          ),
        ],
      ),
    );
  }
}
