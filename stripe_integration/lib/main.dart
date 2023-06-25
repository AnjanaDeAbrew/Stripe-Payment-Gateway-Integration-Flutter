import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:stripe_integration/providers/payment_provider.dart';
import 'package:stripe_integration/screens/home.dart';

Future<void> main() async {
//----load our .env file that contains required keys
  await dotenv.load(fileName: "assets/.env");

//-asign publishable key to flutter_stripe
  Stripe.publishableKey = dotenv.env['PUBLISHABLE_KEY']!;

  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => PaymentProvider())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        darkTheme: ThemeData.dark(),
        home: const Home());
  }
}
