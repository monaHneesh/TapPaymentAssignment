
import 'package:flutter/material.dart';
import 'package:products_app/core/ui/theme/app_themes.dart';
import 'package:products_app/core/ui/theme/theme_bloc/theme_bloc.dart';
import 'package:products_app/core/ui/theme/theme_bloc/theme_state.dart';
import 'package:products_app/screens/manage_products/bloc/manage_product_bloc.dart';
import 'package:products_app/screens/manage_products/bloc/manage_product_state.dart';
import 'package:products_app/screens/manage_products/view/manage_products_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers:[BlocProvider<ManageProductBloc>(
      create: (context) => ManageProductBloc(ManageProductsState.initial()),),
  BlocProvider(create: (context)=>ThemeBloc(),)], child: App()));
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: _buildWithTheme,
      ),
    );
    // return MaterialApp(
    //     title: 'Flutter Demo',
    //     debugShowCheckedModeBanner: false,
    //     theme: ThemeData(
    //       // This is the theme of your application.
    //       //
    //       // Try running your application with "flutter run". You'll see the
    //       // application has a blue toolbar. Then, without quitting the app, try
    //       // changing the primarySwatch below to Colors.green and then invoke
    //       // "hot reload" (press "r" in the console where you ran "flutter run",
    //       // or simply save your changes to "hot reload" in a Flutter IDE).
    //       // Notice that the counter didn't reset back to zero; the application
    //       // is not restarted.
    //       primarySwatch: Colors.blue,
    //     ),
    //     home:
  }
  Widget _buildWithTheme(BuildContext context, ThemeState state) {
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
}



