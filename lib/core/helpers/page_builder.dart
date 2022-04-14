import 'package:flutter/material.dart';


class PageBuilder{
  bool allowBackButtonInAppBar;
  bool appBar;
  Widget body;
  bool enableDrawer;
  String appBarTitle;
  GlobalKey<ScaffoldState> scaffoldKey;
  BuildContext context;
  Color backgroundColor;
  Function backButtonCallBack;
  List<Widget> appBarActions;
  bool isPersistentFooterButtons;
  List<Widget>buttonList;

  PageBuilder({
    this.allowBackButtonInAppBar=true,
    this.appBar=true,
    this.body,
    this.enableDrawer=true,
    this.appBarActions,
    this.backButtonCallBack,
    this.backgroundColor,
    this.scaffoldKey,
    this.context,
    this.appBarTitle,
    this.isPersistentFooterButtons=false,
    this.buttonList


});

}