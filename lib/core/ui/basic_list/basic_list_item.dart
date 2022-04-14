import 'package:flutter/material.dart';

class BasicListItem {
  final String image;
  final String title;
  final dynamic pageToNavigateTo;
  final bool isVisible;
  final List<BasicListItem> itemList;
  bool isSelected = false;
  final String label;
  final bool isGroup;
  final String serviceConfigurationId;
  final Function itemClicked;
  final Icon icon;
  final Widget itemSubTitle;
  final bool haveBadgeNumber;
  final bool isThreeLine;

  BasicListItem(
      {this.image,
        this.title,
        this.pageToNavigateTo,
        this.itemList,
        this.isVisible,
        this.isSelected,
        this.isGroup,
        this.serviceConfigurationId,
        this.label,
        this.itemClicked,
        this.icon,
        this.itemSubTitle,
        this.isThreeLine,
        this.haveBadgeNumber=false});
}
