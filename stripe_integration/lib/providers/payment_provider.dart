import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:logger/logger.dart';
import 'package:stripe_integration/services/payment_services.dart';

class PaymentProvider extends ChangeNotifier {
  final PaymentService _paymentService = PaymentService();

  //-start creating the payment
  Future<void> makePayment(BuildContext context) async {
    try {
      //-----send payment intend request
      dynamic paymentIntent =
          await _paymentService.createPaymentIntent('100', 'USD');
      if (paymentIntent != null) {
        Logger().w(paymentIntent);

        //---initialize payment sheet
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent['client_secret'],
            style: ThemeMode.dark,
            merchantDisplayName: 'Test',
          ),
        );

        //-display the payment sheet
        // ignore: use_build_context_synchronously
        displayPaymentSheet(context);
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  //-display the payment sheet
  void displayPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Payment Success"),
                  SizedBox(height: 10),
                  Icon(
                    Icons.check_circle,
                    size: 100,
                    color: Colors.green,
                  )
                ],
              ),
            );
          },
        );
      });
    } on StripeException catch (e) {
      Logger().e(e);
    } catch (e) {
      Logger().e(e);
    }
  }
}
