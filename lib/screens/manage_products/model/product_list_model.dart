

class ProductListModel{
  String productName;
  String productDescription;
  double productPrice;


  ProductListModel({
    this.productName,
    this.productDescription,
    this.productPrice
});
  //
  factory ProductListModel.fromJson(Map<String, dynamic> json) => ProductListModel(
    productName: json["productName"] == null ? null : json["productName"],
      productDescription: json["productDescription"] == null ? null : json["productDescription"],
    productPrice: json["productPrice"] == null ? null : json["productPrice"],
  );
  Map<String, dynamic> toJson() => {
    'productName': productName,
    'productDescription': productDescription,
    'productPrice':productPrice
  };

}