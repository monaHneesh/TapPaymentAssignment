import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:products_app/core/helpers/page_builder.dart';
import 'package:products_app/core/helpers/page_helper.dart';
import 'package:products_app/core/navigation/app_navigation.dart';
import 'package:products_app/core/storage/my_shared_prefrance.dart';
import 'package:products_app/core/ui/basic_input_field.dart';
import 'package:products_app/core/ui/common_button.dart';
import 'package:products_app/screens/add_product/add_product_view.dart';
import 'package:products_app/screens/manage_products/bloc/manage_product_bloc.dart';
import 'package:products_app/screens/manage_products/bloc/manage_product_event.dart';
import 'package:products_app/screens/manage_products/bloc/manage_product_state.dart';
import 'package:products_app/screens/manage_products/model/product_list_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flushbar/flushbar.dart';

class ManageProductsView extends StatefulWidget {
  List<ProductListModel> productList;

  ManageProductsView({this.productList});

  @override
  ManageProductsViewState createState() => ManageProductsViewState();
}

class ManageProductsViewState extends State<ManageProductsView>
    with PageHelper {
  List<ProductListModel> productsList = [];
  List<ProductListModel> filteredList = [];
  TextEditingController searchController = TextEditingController();
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  List<ProductListModel> tempFilteredProductList = [];

  @override
  void initState() {
    super.initState();
    if (widget.productList != null && widget.productList.isNotEmpty) {
      setState(() {
        filteredList = widget.productList;
      });

    } else {
      BlocProvider.of<ManageProductBloc>(context).add(LoadProducts());
    }
  }

  @override
  Widget build(BuildContext context) {

    return buildPage(PageBuilder(
        scaffoldKey: _globalKey,
        context: context,
        body: _buildPage(context),
        appBar: true,
        appBarTitle: "Manage Products",
        allowBackButtonInAppBar: false,
        isPersistentFooterButtons: true,
        backgroundColor: Theme.of(context).backgroundColor,
        buttonList: [
          CommonButton(
            onPressed: () =>
                {AppNavigation.navigateToPageWidget(context, AddProductForm())},
            text: "Add Product",
          )
        ]));
  }

  Widget _buildPage(BuildContext context) {
    return BlocBuilder<ManageProductBloc, ManageProductsState>(
        builder: (context, state) {
      return BlocListener<ManageProductBloc, ManageProductsState>(
        listener: (context, state) {
          if (state.success != null && state.success && !state.isSearchDone) {
            productsList = state.productsList;
              // filteredList = productsList;
          }
          if (state.isSearchDone != null && state.isSearchDone) {
            filteredList = state.productsList;
          } else {
            productsList = state.productsList;
            filteredList = productsList;
          }
          if (state.fail != null && state.fail) {
            hideLoadingIndicator(context);
            print("fail");
          }
          if (state.isLoading != null && state.isLoading)
            showLoadingIndicator(context);
        },
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              color: Theme.of(context).backgroundColor,
              padding: EdgeInsets.only(left: 10, right: 10),
              child: BasicInputField(
                suffixIcon: Icon(Icons.search),
                clearIcon: true,
                controller: searchController,
                basicInputKey: UniqueKey(),
                keyboardType: TextInputType.text,
                labelText: 'Search product',
                onChanged: (val) {
                  setState(() {
                    BlocProvider.of<ManageProductBloc>(context).add(
                        SearchProductList(
                            searchList: productsList, searchText: val));
                  });
                },
                validationMethod: (val) {
                  if (val.isEmpty) {
                    return null;
                  }
                  return null;
                },
              ),
            ),
            (filteredList != null && filteredList.isNotEmpty) ||
                    searchController.text.isNotEmpty
                ? ListView.builder(
                    itemCount: filteredList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, int index) {
                      return Padding(
                        padding: EdgeInsets.all(5),
                        child: Card(
                          color: Theme.of(context).dividerColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side: BorderSide(
                                color: Theme.of(context).dividerColor),
                          ),
                          elevation: 5,
                          child: ListTile(
                            isThreeLine: true,
                            title: Text(
                              filteredList[index].productName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    filteredList[index].productDescription,
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(children: [
                                    Text(
                                        filteredList[index]
                                            .productPrice
                                            .toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).primaryColor,
                                        )),
                                    Text(" KD",
                                        style: TextStyle(
                                            color: Color(0xffFFC7C7),
                                            fontWeight: FontWeight.bold)),
                                  ])
                                ]),
                          ),
                        ),
                      );
                    })
                : Container(
                    color: Theme.of(context).backgroundColor,
                    child: Center(
                      child: Text("your product list is empty.. ",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          )),
                    ),
                  ),
            SizedBox(
              height: 20,
            )
          ]),
        ),
      );
    });
  }
void showFlushBar(){
  Flushbar(
    flushbarPosition: FlushbarPosition.TOP,
    message:
    "Product was added succfully",
    duration: Duration(seconds: 3),
  )..show(context);
}
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }
}
