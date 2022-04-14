

import 'package:products_app/screens/manage_products/model/product_list_model.dart';

abstract class ManageProductsEvent {}
class LoadProducts extends ManageProductsEvent {


  @override
  List<Object> get props => [];
}
class AddProduct extends ManageProductsEvent {
  ProductListModel addedProduct;
  AddProduct({this.addedProduct});
  @override
  List<Object> get props => [addedProduct];
}
class SearchProductList extends ManageProductsEvent {
  String searchText;
  List<ProductListModel>searchList;
  SearchProductList({this.searchList,this.searchText});
  @override
  List<Object> get props => [searchList,searchText];
}
