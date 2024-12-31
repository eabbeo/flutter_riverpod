import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:r_pod/providers/cart_provider.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  bool showCoupon = true;

  @override
  Widget build(BuildContext context) {
    final cartProducts = ref.watch(cartNotifierProvider);
    final total = ref.watch(cartTotalProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        centerTitle: true,
        // actions: [],
      ),
      body: cartProducts.isEmpty
          ? Center(
              child: Text('No items added'),
            )
          : Container(
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  Column(
                    children: cartProducts.map((product) {
                      return Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Image.asset(
                              product.image,
                              width: 60,
                              height: 60,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(product.title),
                            Spacer(),
                            Text('GHS: ${product.price}')
                          ],
                        ),
                      );
                    }).toList(), // output cart products here
                  ),
                  Spacer(),
                  // output totals here
                  Text("Total price is $total")
                ],
              ),
            ),
    );
  }
}
