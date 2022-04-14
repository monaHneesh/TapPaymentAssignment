import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_app/core/storage/my_shared_prefrance.dart';
import 'package:products_app/screens/manage_products/model/product_list_model.dart';
import 'manage_product_event.dart';
import 'manage_product_state.dart';
import 'package:bloc/bloc.dart';

import 'dart:async';
import 'dart:convert';


class ManageProductBloc extends Bloc<ManageProductsEvent,ManageProductsState>{
  ManageProductBloc(ManageProductsState initialState) : super(initialState);


  @override
  Stream<ManageProductsState> mapEventToState(ManageProductsEvent event) async* {
    List<ProductListModel>productsList=[];
    if (event is LoadProducts) {
      try {
        yield state.copyWith(fail: true,success: false);
        dynamic response = await MySharedPrefs.getStringVal("Product_List");
        if (response != null) {
          void addRetrievedProducts(var product) {
            var newProduct = ProductListModel.fromJson(product);
           state.productsList.add(newProduct);
          }
          var products = jsonDecode(response);
          products.forEach((product) => addRetrievedProducts(product));
          productsList=state.productsList;
          yield state.copyWith(success: true, productsList: productsList,isSearchDone: false);
        }
      } on PlatformException catch (e) {
        yield state.copyWith(
          fail: true,
        );
      }
    }

    else if(event is SearchProductList){
      try {
        yield state.copyWith(fail: true,success: false);
        List<ProductListModel> _filteredProductList = event.searchList
            .where((element) => element.productName
            .toLowerCase()
            .contains(event.searchText.toLowerCase())||
            element.productDescription
                .toLowerCase()
                .contains(event.searchText.toLowerCase())||
            element.productPrice.toString()
                .toLowerCase()
                .contains(event.searchText.toLowerCase()))
            .toList();

        yield state.copyWith(
          productsList: _filteredProductList,
          isSearchDone: true,
          fail: false
        );
      } on PlatformException catch (e) {
        yield state.copyWith(
         fail: true);
      }
    }
    else if (event is AddProduct) {
      try {
        yield state.copyWith(fail: true,success: false);
        if(event.addedProduct != null){
          dynamic response = await MySharedPrefs.getStringVal("Product_List");
          if (response != null) {
            void addRetrievedProducts(var product) {
              var newProduct = ProductListModel.fromJson(product);
              productsList.add(newProduct);
            }
            var products = jsonDecode(response);
            products.forEach((product) => addRetrievedProducts(product));
          }
      var updatedList= productsList;
          updatedList.add(event.addedProduct);
        await MySharedPrefs.setStringVal(
            "Product_List", jsonEncode(updatedList));
        yield state.copyWith(success: true, productsList: updatedList,isSearchDone: false);
        }
      } on PlatformException catch (e) {
        yield state.copyWith(
          fail: true,
        );
      }
    }
  }
}
