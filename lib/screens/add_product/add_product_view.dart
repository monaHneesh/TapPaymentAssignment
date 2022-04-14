import 'package:flutter/material.dart';
import 'package:products_app/core/helpers/page_builder.dart';
import 'package:products_app/core/helpers/page_helper.dart';
import 'package:products_app/core/navigation/app_navigation.dart';
import 'package:products_app/core/ui/app_bar.dart';
import 'package:products_app/core/ui/basic_input_field.dart';
import 'package:products_app/core/ui/common_button.dart';
import 'package:products_app/screens/manage_products/bloc/manage_product_bloc.dart';
import 'package:products_app/screens/manage_products/bloc/manage_product_event.dart';
import 'package:products_app/screens/manage_products/bloc/manage_product_state.dart';
import 'package:products_app/screens/manage_products/model/product_list_model.dart';
import 'package:products_app/screens/manage_products/view/manage_products_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductForm extends StatefulWidget {
  @override
  AddProductFormState createState() => AddProductFormState();
}

class AddProductFormState extends State<AddProductForm> with PageHelper {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode validationMode = AutovalidateMode.disabled;
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _productDescreptionController = TextEditingController();
  TextEditingController _productPriceController = TextEditingController();
  bool inputField1Valid = false,
      inputField2Valid = false,
      inputField3Valid = false;

  @override
  Widget build(BuildContext context) {
    return buildPage(PageBuilder(
      context: context,
      scaffoldKey: scaffoldKey,
      appBarTitle: "Add Product",
      appBar: true,
      backgroundColor: Theme.of(context).backgroundColor,
      allowBackButtonInAppBar: true,
      body: _buildPage(context),
    ));
  }

  Widget _buildPage(BuildContext context) {
    return BlocBuilder<ManageProductBloc, ManageProductsState>(
        builder: (context, state) {
      return BlocListener<ManageProductBloc, ManageProductsState>(
          listener: (context, state) {
            if (state.success != null && state.success && !state.isSearchDone) {
              hideLoadingIndicator(context);
              AppNavigation.navigateToPageWidget(context, ManageProductsView(productList: state.productsList,));
            }
            if (state.fail != null && state.fail) {
              hideLoadingIndicator(context);
              print("fail");
            }
            if (state.isLoading != null && state.isLoading)
              showLoadingIndicator(context);
          },
          child: Container(
            child: Form(
              key: _formKey,
              autovalidateMode: validationMode,
              child: _buildFormFields(),
            ),
          ));
    });
  }

  Widget _buildFormFields() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          BasicInputField(
            labelText: "Product Name",
            controller: _productNameController,
            validateEmptyString: true,
            validationMethod: (value) {
              if (value.isNotEmpty && value.length < 3) {
                return "please enter product name longer than 3 charcters ";
              } else if (value.isEmpty) {
                return "please enter product name";
              } else {
                return null;
              }
            },
            clearIcon: true,
            keyboardType: TextInputType.text,
          ),
          BasicInputField(
            labelText: "Product Description",
            controller: _productDescreptionController,
            validateEmptyString: true,
            validationMethod: (value) {
              if (value.isNotEmpty && value.length < 3) {
                return "please enter product description longer than 3 charcters ";
              } else if (value.isEmpty) {
                return "please enter product description";
              } else {
                return null;
              }
            },
            clearIcon: true,
            keyboardType: TextInputType.text,
          ),
          BasicInputField(
            labelText: "Product Price",
            controller: _productPriceController,
            suffixIcon: Text(
              "K.D",
              style: TextStyle(color: Colors.black26),
            ),
            validateEmptyString: true,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            validationMethod: (value) {
              RegExp regex = new RegExp(
                  r'^[+-]?([0-9]{1,3}(,[0-9]{3})*(\.[0-9]+)?|\d*\.\d+|\d+)$');
              if (value.isEmpty) {
                return "please enter product price";
              } else if (value.isNotEmpty && !regex.hasMatch(value)) {
                return "input should be only numbers";
              } else {
                return null;
              }
            },
            validateZeroNumber: true,
            clearIcon: true,
          ),
          SizedBox(
            height: 20,
          ),
          CommonButton(
            text: "Submit",
            onPressed: submitForm,
          ),
        ],
      ),
    );
  }

  void submitForm() {
    validationMode = AutovalidateMode.always;
    FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate()) {
      print("Valid");
      ProductListModel newProduct = ProductListModel(
          productName: _productNameController.text,
          productDescription: _productDescreptionController.text,
          productPrice: double.parse(_productPriceController.text));
      BlocProvider.of<ManageProductBloc>(context).add(AddProduct(addedProduct: newProduct));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _productNameController.dispose();
    _productDescreptionController.dispose();
    _productPriceController.dispose();
  }
}
