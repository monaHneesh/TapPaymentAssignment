
import 'package:flutter/material.dart';
import 'package:products_app/screens/manage_products/bloc/manage_product_bloc.dart';
import 'package:products_app/screens/manage_products/bloc/manage_product_state.dart';
import 'package:products_app/screens/manage_products/view/manage_products_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers:[BlocProvider<ManageProductBloc>(
      create: (context) => ManageProductBloc(ManageProductsState.initial()),)], child: App()));
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return _buildWithTheme(context);
  }

  }
  Widget _buildWithTheme(BuildContext context, ) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Colors.black,
        brightness: Brightness.light,
        backgroundColor: const Color.fromRGBO(247, 247, 250, 1),
        accentColor: Colors.black,
        accentIconTheme: IconThemeData(color: Colors.black),
        dividerColor: Colors.white,
        // primarySwatch: Colors.blue,
        // visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Color(0xffffffff),
        brightness: Brightness.dark,
        backgroundColor: const Color(0xFF5E5E5E),
        accentColor: Colors.white,
        dividerColor: Colors.grey,     // New
      ),
      home:BlocProvider<ManageProductBloc>(
        create: (_) => ManageProductBloc(ManageProductsState.initial()),
        child: ManageProductsView(),
      ),
      // theme: state.themeData,
    );
  }




