import 'package:flutter/material.dart';

import '../local_datasource/shopping_datasource.dart';
import '../model/basket_model.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final List<BasketModel> _shopping = [];

  @override
  void initState() {
    super.initState();
    loadBasket();
  }

  Future<void> deleteBasket(int id) async {
    await DatabaseHelper().deleteBasket(id);
    loadBasket();
  }

  Future<void> updateBasket(BasketModel model) async {
    await DatabaseHelper().updateBasket(model);
    loadBasket();
  }

  Future<void> loadBasket() async {
    _shopping.clear();
    List<BasketModel> baskets = await DatabaseHelper().getBaskets();
    setState(() {
      _shopping.addAll(baskets);
    });
    print(_shopping);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: _shopping.isEmpty
          ? const Center(
              child: Text("Your cart is empty."),
            )
          : ListView.builder(
              itemCount: _shopping.length,
              itemBuilder: (context, index) {
                var item = _shopping[index];
                return Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        leading: Image.network(
                          item.image!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(item.title!),
                        subtitle: Text("${item.price}₺ x ${item.count}"),
                      ),
                    ),
                    IconButton(
                      icon: Icon(item.count == 1 ? Icons.delete : Icons.remove),
                      onPressed: () {
                        if (item.count! > 1) {
                          item.count = item.count! - 1;
                          updateBasket(item);
                        } else {
                          deleteBasket(item.id!);
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        if (item.count! > 0) {
                          item.count = item.count! + 1;
                          updateBasket(item);
                        }
                      },
                    ),
                  ],
                );
              },
            ),
      bottomNavigationBar: _shopping.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total: ${calculateTotalPrice(_shopping)}₺",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Checkout"),
                  ),
                ],
              ),
            )
          : null,
    );
  }

  double calculateTotalPrice(List<BasketModel> shopping) {
    double total = 0;
    for (var item in shopping) {
      setState(() {
        total += (item.price! * item.count!);
      });
    }
    return total;
  }
}
