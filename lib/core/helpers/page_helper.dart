import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:products_app/core/helpers/page_builder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';



abstract class PageHelper {
  buildPage(PageBuilder pageBuilder) {
    final double deviceWidth = MediaQuery.of(pageBuilder.context).size.width;
    final double targetWidth =
        deviceWidth < 550.0 ? deviceWidth - 20 : deviceWidth * 0.7;
    final double targetPadding = deviceWidth - targetWidth;
    final double deviceHeight = MediaQuery.of(pageBuilder.context).size.height;
    return WillPopScope(
      onWillPop: () async {
        if (pageBuilder.backButtonCallBack != null) {
          pageBuilder.backButtonCallBack();
          return false;
        }
        return true;
      },
      child: Scaffold(
          key: pageBuilder.scaffoldKey,
          persistentFooterButtons:pageBuilder.isPersistentFooterButtons?pageBuilder.buttonList:[],
          backgroundColor:Theme.of(pageBuilder.context).backgroundColor,
          appBar: (pageBuilder.appBar)
              ? AppBar(

                  primary: true,
                  elevation: 0,
                  actions: pageBuilder.appBarActions ?? [],
                  leading: (pageBuilder.allowBackButtonInAppBar)
                      ? Semantics(
                          label: "back_button",
                          child: IconButton(
                            color: Theme.of(pageBuilder.context).primaryColor,
                            icon: Icon(Icons.arrow_back_ios),
                            onPressed: () {
                              if (pageBuilder.backButtonCallBack != null) {
                                FocusScope.of(pageBuilder.context).unfocus();
                                pageBuilder.backButtonCallBack();
                              } else {
                                FocusScope.of(pageBuilder.context).unfocus();
                                Navigator.pop(pageBuilder.context);
                              }
                            },
                          ),
                        )
                      : Container(),
                  title: Text(
                    pageBuilder.appBarTitle,
                    style: TextStyle(
                        color:Theme.of(pageBuilder.context).primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  backgroundColor: Theme.of(pageBuilder.context).backgroundColor,
                  centerTitle: true,

                )
              : null,
          body: (!pageBuilder.appBar)
              ? SafeArea(
                  child: _buildBody(pageBuilder),
                )
              : _buildBody(pageBuilder)),
    );
  }

  _buildBody(PageBuilder pageBuilder) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(pageBuilder.context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: pageBuilder.body);
  }

  showLoadingIndicator(BuildContext context) {
    EasyLoading.show();
  }

  hideLoadingIndicator(BuildContext context) {
    EasyLoading.dismiss();
  }
}
