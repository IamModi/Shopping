import 'package:flutter/material.dart';
import 'package:shopping/src/model/res_all_product.dart';
import 'package:shopping/src/ui/common_appbar.dart';
import 'package:shopping/src/utils/navigation_utils.dart';
import 'package:shopping/src/utils/progress_utils.dart';
import 'package:shopping/src/utils/sqfliter_database_utils.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  ValueNotifier<List<ProductDetails>> cartItemList =
      ValueNotifier<List<ProductDetails>>([]);
  final _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      ProgressDialogUtils.showProgressDialog(context);
      _getProductsLocally();
    });
  }

  _getProductsLocally() async {
    _dbHelper.getCartProducts().then((value) {
      cartItemList.value = value;

      ProgressDialogUtils.dismissProgressDialog();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.only(top: 44),
        child: Column(children: [
          CommonAppBar(
            prefixIcon: (Icons.arrow_back_outlined),
            iconColor: Colors.white,
            title: "My Cart",
            onTapPrefix: () {
              NavigationUtils.pop(context);
            },
          ),
          Expanded(
            child: ListView.separated(
                itemCount: cartItemList.value.length,
                separatorBuilder: (c, i) {
                  return Padding(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: Column(
                      children: [
                        SizedBox(height: 2),
                      ],
                    ),
                  );
                },
                itemBuilder: (context, index) {
                  return Container(
                    height: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              right: 10, left: 10, top: 8, bottom: 8),
                          child: Row(
                            children: [
                              Container(
                                height: 130,
                                width: 130,
                                child: Image.network(
                                    '${cartItemList.value[index].featured_image}'),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * (0.5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${cartItemList.value[index].title}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                    // SizedBox(width: 8.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Prize",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Text(
                                          '\$${cartItemList.value[index].price}',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Quantity",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Text(
                                          '1',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Container(
              height: 50,
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("Total Items",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                        SizedBox(width: 5),
                        Text("${cartItemList.value.length}",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
