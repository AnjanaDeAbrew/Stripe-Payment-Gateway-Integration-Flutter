import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stripe_integration/providers/payment_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
              'https://img.freepik.com/free-vector/delivery-service-illustrated_23-2148505081.jpg?w=2000'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Provider.of<PaymentProvider>(context, listen: false)
                  .makePayment(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            child: const Text(
              "\$ Pay Now",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
