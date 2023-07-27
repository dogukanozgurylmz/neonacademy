import 'package:basketballapp/model/basket_model.dart';
import 'package:basketballapp/model/product_model.dart';
import 'package:basketballapp/services/person_service.dart';
import 'package:basketballapp/services/product_service.dart';
import 'package:basketballapp/view/users_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../local_datasource/shopping_datasource.dart';
import 'cart_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ProductService _service = ProductService();
  final List<ProductModel> _products = [];
  final List<BasketModel> _shopping = [];
  bool isLoading = false;
  PersonService personService = PersonService();

  @override
  void initState() {
    super.initState();
    getAllProduct();
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

  Future<void> deleteBasket(int id) async {
    await DatabaseHelper().deleteBasket(id);
    loadBasket();
  }

  Future<void> addBasket(BasketModel model) async {
    await DatabaseHelper().insertBasket(model);
    loadBasket();
  }

  Future<void> updateBasket(BasketModel model) async {
    await DatabaseHelper().updateBasket(model);
    loadBasket();
  }

  Future<void> getAllProduct() async {
    setState(() {
      isLoading = true;
    });
    var list = await _service.products();
    if (list.isNotEmpty) {
      setState(() {
        _products.addAll(list);
      });
    }
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Users'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UsersView(),
                    ));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          IconButton(
            onPressed: () async {
              var result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartView(),
                ),
              );
              await loadBasket();
              print(result);
            },
            icon: Icon(_shopping.isEmpty
                ? Icons.shopping_cart_outlined
                : Icons.shopping_cart),
          )
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(4),
        itemCount: _products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          childAspectRatio: 2 / 3,
        ),
        itemBuilder: (context, index) {
          var product = _products[index];
          return Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  product.image!,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                Text(
                  product.title!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                RatingBar.builder(
                  initialRating: product.rating!.rate!,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 16,
                  glow: false,
                  ignoreGestures: true,
                  tapOnlyMode: true,
                  updateOnDrag: true,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${product.price}₺"),
                    IconButton(
                      onPressed: () async {
                        BasketModel basketModel = BasketModel(
                          id: product.id,
                          title: product.title,
                          price: product.price,
                          image: product.image,
                          count: 1,
                        );

                        // Eğer sepette ürün yoksa, ürünü direk ekleyelim.
                        if (_shopping.isEmpty) {
                          addBasket(basketModel);
                        } else {
                          // Sepette ürün varsa, ürünün count değerini arttıralım.
                          bool found = false;
                          for (var basket in _shopping) {
                            if (basket.id == product.id) {
                              basketModel.count = basket.count! + 1;
                              await updateBasket(basketModel);
                              found = true;
                              break;
                            }
                          }
                          if (!found) {
                            addBasket(basketModel);
                          }
                        }
                      },
                      icon: const Icon(
                        Icons.add_shopping_cart_outlined,
                        color: Colors.orange,
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
