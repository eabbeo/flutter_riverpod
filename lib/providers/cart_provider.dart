import 'package:r_pod/models/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_provider.g.dart';

class CartNotifier extends Notifier<Set<Product>> {
  //initial value
  @override
  Set<Product> build() {
    return const {};
  }

  //methods to update state
  void addProduct(Product product) {
    //checking for product duplication
    if (!state.contains(product)) {
      state = {...state, product};
    }
  }

  //remove products from items
  void removeProducts(Product product) {
    if (state.contains(product)) {
      state = state.where((p) => p.id != product.id).toSet();
    }
  }
}

final cartNotifierProvider = NotifierProvider<CartNotifier, Set<Product>>(() {
  return CartNotifier();
});

@riverpod
int cartTotal(ref) {
  final cartProducts = ref.watch(cartNotifierProvider);

  int total = 0;

  for (Product product in cartProducts) {
    total += product.price;
  }
  return total;
}
