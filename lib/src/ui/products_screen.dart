import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/src/api_manager/api_manager.dart';
import 'package:shopping/src/bloc/add_to_cart_bloc/add_to_cart_bloc.dart';
import 'package:shopping/src/bloc/add_to_cart_bloc/add_to_cart_event_bloc.dart';
import 'package:shopping/src/bloc/add_to_cart_bloc/add_to_cart_state_bloc.dart';
import 'package:shopping/src/model/req_all_product.dart';
import 'package:shopping/src/model/res_all_product.dart';
import 'package:shopping/src/ui/common_appbar.dart';
import 'package:shopping/src/utils/navigation_utils.dart';
import 'package:shopping/src/utils/progress_utils.dart';
import 'package:shopping/src/utils/route_constant.dart';
import 'package:shopping/src/utils/sqfliter_database_utils.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int page = 1;
  ResAllProduct? allProduct;
  final _dbHelper = DatabaseHelper();

  ValueNotifier<List<ProductDetails>> productList =
      ValueNotifier<List<ProductDetails>>([]);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await _getAllProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.only(top: 44, left: 20, right: 20),
        child: Column(children: [
          CommonAppBar(
            suffixShow: true,
            suffixIcon: (Icons.add_shopping_cart_rounded),
            iconColor: Colors.white,
            title: "Shopping Mall",
            // prefixShow: false,
            onTapSuffix: () {
              NavigationUtils.push(context, routeCart);
            },
          ),
          Expanded(
            child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 250.0,
                  childAspectRatio: 1,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                ),
                itemCount: productList.value.length,
                itemBuilder: (ctx, index) {
                  return scrollView(index);
                }),
          ),
        ]),
      ),
    );
  }

  Widget scrollView(int index) {
    return Padding(
      padding: EdgeInsets.all(6.0),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue,
                width: 3,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 130,
                    child: Image.network(
                      "${productList.value[index].featured_image}",
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          "${productList.value[index].title}",
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            // context
                            //     .read<AddToCartBloc>()
                            //     .add(InsertItemEvent());
                            _dbHelper
                                .insertCartProducts(productList.value[index]);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                "Add to cart successfully",
                                style: TextStyle(color: Colors.black),
                              ),
                              backgroundColor: Colors.green,
                            ));
                          },
                          child: Icon(
                            Icons.add_shopping_cart_rounded,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _getAllProducts() async {
    ProgressDialogUtils.showProgressDialog(context);
    ReqAllProduct? param = ReqAllProduct(page: page, perPage: 5);
    await ApiManager().getProducts(context, param).then((value) {
      ProgressDialogUtils.dismissProgressDialog();
      setState(() {});
      allProduct = value;
      productList.value = value.data!;
      for (int i = 0; i < productList.value.length; i++) {
        _dbHelper.insertProducts(value.data![i]);
      }
    }).catchError((error) {
      ProgressDialogUtils.dismissProgressDialog();
      // if (error is BaseModel) {
      //   DialogUtils.showAlertDialog(context, error.message!);
      // }
    });
  }
}
