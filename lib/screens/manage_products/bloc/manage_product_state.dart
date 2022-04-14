import 'package:products_app/screens/manage_products/model/product_list_model.dart';

class ManageProductsState {
  ProductListModel addedProduct;
  List<ProductListModel> productsList;
  bool isLoading;
  bool success;
  bool fail;
  bool isSearchDone;

  ManageProductsState(
      {this.productsList,
      this.addedProduct,
      this.isLoading = false,
      this.fail = false,
        this.isSearchDone,
      this.success = false});

  factory ManageProductsState.loading() =>
      ManageProductsState(isLoading: true, fail: false, success: false);

  factory ManageProductsState.initial() => ManageProductsState(
        isLoading: false,
        fail: false,
        success: false,
        addedProduct: ProductListModel(),
        productsList: [],
      );

  factory ManageProductsState.succeeded() =>
      ManageProductsState(isLoading: false, fail: false, success: true);

  factory ManageProductsState.failed() =>
      ManageProductsState(isLoading: false, fail: true, success: false);

  bool operator ==(o) =>
      o.isLoading == isLoading && o.success == success && o.fail == fail;

  @override
  int get hashCode => super.hashCode;

  @override
  ManageProductsState copyWith(
          {List<ProductListModel> productsList,
          ProductListModel addedProduct,
          bool fail,
          bool success,
          bool isSearchDone,
          bool isLoading}) =>
      ManageProductsState(
          productsList: productsList ?? this.productsList,
          addedProduct: addedProduct ?? this.addedProduct,
          isLoading: isLoading ?? this.isLoading,
          success: success ?? this.success,
          isSearchDone:isSearchDone??this.isSearchDone,
          fail: fail ?? this.fail,
      );

  @override
  List<Object> get props =>
      [productsList, addedProduct, isLoading, success, fail,isSearchDone];
}
