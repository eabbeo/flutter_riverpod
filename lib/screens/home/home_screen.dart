import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:r_pod/providers/cart_provider.dart';
import 'package:r_pod/providers/products_provider.dart';
import 'package:r_pod/shared/cart_icon.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //using watch provides changes when data is updated
    final allProducts = ref.watch(productsProvider);
    final catProducts = ref.watch(cartNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Garage Sale Products'),
        actions: const [CartIcon()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          itemCount: allProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(20),
              color: Colors.blueGrey.withOpacity(0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    allProducts[index].image,
                    width: 60,
                    height: 60,
                  ),
                  Text(allProducts[index].title),
                  Text('GHS: ${allProducts[index].price}'),
                  if (catProducts.contains(allProducts[index]))
                    TextButton(
                        onPressed: () {
                          ref
                              .read(cartNotifierProvider.notifier)
                              .removeProducts(allProducts[index]);
                        },
                        child: Text('Remove')),
                  //
                  if (!catProducts.contains(allProducts[index]))
                    TextButton(
                        onPressed: () {
                          ref
                              .read(cartNotifierProvider.notifier)
                              .addProduct(allProducts[index]);
                        },
                        child: Text('Add to cart'))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
