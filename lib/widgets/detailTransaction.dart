import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:projet_d_integration/data/Transaction.dart';
import '../../../constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.t
  }) : super(key: key);
final transaction t;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset('images/Transfer.png'),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'titreeee',
              style: const TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(
                text: "\$8787",
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
                children: [
                  TextSpan(
                      text: " x8787",
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}




class CartScreen extends StatefulWidget {
  static String routeName = "/cart";

  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text(
              "Your Cart",
              style: TextStyle(color: Colors.black),
            ),
            Text(
              "7 items",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
      //bottomNavigationBar: const CheckoutCard(),
    );
  }
}