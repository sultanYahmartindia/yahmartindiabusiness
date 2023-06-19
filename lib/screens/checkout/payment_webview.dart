import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';
import 'package:yahmart/controller/cart_checkout_controller.dart';
import 'package:yahmart/screens/checkout/thank_you_screen.dart';
import '../../utils/common_colors.dart';
import '../../utils/custom_alert_dialog.dart';
import '../../utils/screen_constants.dart';


class PaymentWebView extends StatefulWidget {
  final String url;
  const PaymentWebView({Key? key, required this.url}) : super(key: key);

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  WebViewController? webController;

  final CartCheckoutController _checkoutController = Get.find();

  @override
  void initState() {
    super.initState();
    webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://yahmartindia.in/')) {
              debugPrint('blocking navigation to $request}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          // onNavigationRequest: (NavigationRequest request) {
          //   return NavigationDecision.navigate;
          // },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) async {
            debugPrint('Page finished loading: $url');
            //  https://api.yahmartindia.in/api/v1/transaction/redirect
            // https://yahmartindia.in/account/payment-success?orderId=YAH0175&totalAmount=199900&paymentType=ONLINE&status=Error&success=false
            final uri = Uri.parse(url);
            if (uri.host == 'yahmartindia.in') {
              final orderId = uri.queryParameters['orderId'];
              final totalAmount = uri.queryParameters['totalAmount'];
              final paymentType = uri.queryParameters['paymentType'];
              final status = uri.queryParameters['status'];
              final success = uri.queryParameters['success'];

              _checkoutController.paymentSuccess(
                success == 'true' ? true : false,
              );
              _checkoutController.cartTotalAmount(
                (int.parse(totalAmount ?? '0') / 100).floor(),
              );
              _checkoutController.paymentStatus(status);
              _checkoutController.selectedPaymentMethod(paymentType);
              _checkoutController.orderId(orderId);
              if (_checkoutController.paymentSuccess.isFalse) {
                showToastMessage(msg: "Payment failed please try again");
              }
              await Get.offAll(() => ThankYouScreen());
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.appBgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        elevation: 0,
        backgroundColor: CommonColors.appBgColor,
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            "Payment",
            style: TextStyle(
              color: CommonColors.appColor,
              fontWeight: FontWeight.bold,
              fontSize: FontSize.s16,
            ),
          ),
        ),
      ),
      body: WebViewWidget(controller: webController!),
    );
  }
}
