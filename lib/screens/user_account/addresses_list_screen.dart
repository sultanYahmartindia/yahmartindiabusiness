import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/widgets/no_data_screen_widget.dart';

import '../../controller/cart_checkout_controller.dart';
import '../../utils/common_colors.dart';
import '../../utils/common_logics.dart';
import '../../utils/screen_constants.dart';
import '../../widgets/outline_border_button.dart';
import 'add_address_screen.dart';

class AddressesListScreen extends StatelessWidget {
  AddressesListScreen({Key? key}) : super(key: key);

  /// find CartCheckout controller.
  final CartCheckoutController _cartCheckoutC = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CommonColors.appBgColor,
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          backgroundColor: CommonColors.appBgColor,
          titleSpacing: 0,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: CommonColors.appColor,
              ),
              onPressed: () => Get.back()),
          title: Text(
            "My Address",
            style: TextStyle(
                color: CommonColors.appColor,
                fontWeight: FontWeight.bold,
                fontSize: FontSize.s16),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          color: CommonColors.appBgColor,
          height: 55,
          child: OutlineBorderButtonView(
            "Add Address",
            onPressed: () => Get.to(() => const AddAddressScreen()),
            backgroundColor: CommonColors.appColor,
            color: CommonColors.whiteColor,
          ),
        ),
        body: Obx(() {
          return _cartCheckoutC.addressesList.isNotEmpty
              ? ListView(
                  children: List.generate(_cartCheckoutC.addressesList.length,
                      (index) {
                    return Column(
                      children: [
                        ListTile(
                          trailing: GestureDetector(
                            onTap: () {
                              _cartCheckoutC.addressDelete(
                                  id: _cartCheckoutC
                                      .addressesList[index].addressId);
                            },
                            child: const Icon(
                              Icons.delete_outline,
                              color: Colors.black,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 5),
                          selectedTileColor: CommonColors.whiteColor,
                          selected: true,
                          selectedColor: CommonColors.blackColor,
                          leading: CircleAvatar(
                            backgroundColor: Color(
                              CommonLogics.getRandomColor(index),
                            ),
                            child: Text(
                              CommonLogics.runeSubstring(
                                  _cartCheckoutC
                                          .addressesList[index].addressKind ??
                                      "Home".toUpperCase(),
                                  0,
                                  1),
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: CommonColors.lightGreyColor,
                                  fontWeight: FontWeight.bold),
                            ), //Text
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text(
                              _cartCheckoutC.addressesList[index].addressKind ??
                                  "",
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "${_cartCheckoutC.addressesList[index].name ?? ""}, ${_cartCheckoutC.addressesList[index].mobile ?? ""}"),
                              Text(
                                  "${_cartCheckoutC.addressesList[index].houseNumber!}, ${_cartCheckoutC.addressesList[index].addressText!}, ${_cartCheckoutC.addressesList[index].streetName!}"),
                              Text(
                                  "${_cartCheckoutC.addressesList[index].city!}, ${_cartCheckoutC.addressesList[index].state!}"),
                              Text(
                                  "${_cartCheckoutC.addressesList[index].pincode!}, ${_cartCheckoutC.addressesList[index].country!}"),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ), //
                      ],
                    );
                  }),
                )
              : const NoDataScreen(message: "No address found");
        }));
  }
}
