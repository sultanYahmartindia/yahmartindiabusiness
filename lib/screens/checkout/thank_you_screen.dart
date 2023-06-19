import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahmart/screens/home/home_screen.dart';
import 'package:yahmart/utils/common_images.dart';
import '../../controller/cart_checkout_controller.dart';
import '../../utils/common_colors.dart';
import '../../utils/common_logics.dart';
import '../../utils/common_values.dart';
import '../../utils/screen_constants.dart';
import '../../widgets/outline_border_button.dart';
import '../orders/order_details_screen.dart';

class ThankYouScreen extends StatelessWidget {
  ThankYouScreen({Key? key}) : super(key: key);

  /// find orders notification controller.
  final CartCheckoutController _cartCheckoutC = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.appBgColor,
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 50),
            Image.asset(
              _cartCheckoutC.paymentSuccess.value
                  ? CommonImages.thankYouIcon
                  : CommonImages.paymentFailIcon,
              height: 150,
            ),
            const SizedBox(height: 30),
            Text(
              _cartCheckoutC.paymentSuccess.value
                  ? "Thank You"
                  : "Payment Failed",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: CommonColors.blackColor,
                  fontWeight: FontWeight.w600,
                  fontSize: FontSize.s30),
            ),
            const SizedBox(height: 16),
            Text(
              _cartCheckoutC.paymentSuccess.value
                  ? "Your order has been placed successfully \n You can track the delivery in the \norder status section."
                  : "Your payment failed. Please try again",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 30),

            Container(
              color: CommonColors.whiteColor,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order ID",
                    style: TextStyle(
                      color: CommonColors.greyColor535353,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      "${_cartCheckoutC.selectedPaymentMethod.value == 'ONLINE' ? _cartCheckoutC.orderId.value  :_cartCheckoutC.orderCreateModel.orderId!.toString()}",
                      maxLines: 1,
                      textAlign: TextAlign.end,
                      //overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: CommonColors.greyColor535353,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: CommonColors.appBgColor,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Amount",
                    style: TextStyle(
                      color: CommonColors.greyColor535353,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "₹ ${_cartCheckoutC.selectedPaymentMethod.value == 'ONLINE' ? _cartCheckoutC.cartTotalAmount.toString() : _cartCheckoutC.orderCreateModel.totalAmount!.toString()}",
                    style: TextStyle(
                      color: CommonColors.greyColor535353,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            if(_cartCheckoutC.orderCreateModel.totalDiscount != null)
            Container(
              color: CommonColors.whiteColor,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Discount",
                    style: TextStyle(
                      color: CommonColors.greyColor535353,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "₹ ${_cartCheckoutC.orderCreateModel.totalDiscount.toString()}",
                    style: TextStyle(
                      color: CommonColors.greyColor535353,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: CommonColors.appBgColor,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Payment Mode",
                    style: TextStyle(
                      color: CommonColors.greyColor535353,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    _cartCheckoutC.selectedPaymentMethod.toString(),
                    style: TextStyle(
                      color: CommonColors.greyColor535353,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: CommonColors.whiteColor,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Estimated Delivery",
                        style: TextStyle(
                          color: CommonColors.greyColor535353,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (_cartCheckoutC.paymentSuccess.value)
                        _cartCheckoutC.orderCreateModel.deliveryDate != null
                            ? Text(
                          CommonLogics.getDateFromUtc(
                            _cartCheckoutC.orderCreateModel.deliveryDate!,
                            CommonValues.ddMmYyyyAa,
                          ),
                          style: TextStyle(
                            color: CommonColors.greyColor535353,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                            : Text(
                          'Estimated delivery in 3 to 7 Days',
                          style: TextStyle(
                            color: CommonColors.greyColor535353,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                  if (_cartCheckoutC.orderCreateModel.deliveryDate == null)
                    const SizedBox(height: 5),
                  if (_cartCheckoutC.orderCreateModel.deliveryDate == null)
                    Text(
                      _cartCheckoutC.paymentSuccess.value ? "Confirm Date will be shown after product shipment." : "",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: CommonColors.greyColor535353,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        color: CommonColors.appBgColor,
        height: 55,
        child: Row(
          children: [
            if (_cartCheckoutC.paymentSuccess.value)
              Expanded(
                child: OutlineBorderButtonView(
                  "Check Order Status",
                  onPressed: () {
                    /// put orders notification controller.
                    Get.offAll(() => OrderDetailsScreen(
                          orderId:_cartCheckoutC.selectedPaymentMethod.value == 'ONLINE' ? _cartCheckoutC.orderId.value  : _cartCheckoutC
                              .orderCreateModel.items!.first.orderItemId,
                        ));
                  },
                  backgroundColor: CommonColors.appColor,
                  color: CommonColors.whiteColor,
                ),
              ),
            if (_cartCheckoutC.paymentSuccess.value) const SizedBox(width: 12),
            Expanded(
              child: OutlineBorderButtonView(
                "Back to Home",
                onPressed: () {
                  Get.offAll(() => const HomeScreen());
                },
                backgroundColor: CommonColors.whiteColor,
                color: CommonColors.appColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
