import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class PaymentService {
  //-calculate amount
  String calculateAmount(String amount) {
    final temp = (int.parse(amount)) * 100;
    return temp.toString();
  }

  //--create a payment intent function
  Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      //make the http request to stripe
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          headers: {
            "Authorization": 'Bearer ${dotenv.env['STRIPE_SECRET']}',
            "Content-Type": 'application/x-www-form-urlencoded',
          },
          body: body);

      Logger().w(response.body);

      return json.decode(response.body);
    } catch (e) {
      Logger().e(e);
      throw Exception(e.toString());
    }
  }
}
