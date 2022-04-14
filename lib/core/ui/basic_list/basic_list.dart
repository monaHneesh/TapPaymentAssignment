import 'package:flutter/material.dart';
import 'basic_list_item.dart';

class BasicList extends StatefulWidget {
  final Axis axisDirection;
  final bool hasDivider;
  final List<BasicListItem> itemsList;



  const BasicList({
    Key key,
    this.axisDirection,
    this.hasDivider,
    this.itemsList,

  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BasicListState();
  }
}

class _BasicListState extends State<BasicList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.itemsList.length,
      scrollDirection: widget.axisDirection,
      itemBuilder: (context, index) {
        return Container(
          child: ListTile(
            title: Text(widget.itemsList[index].title),
            subtitle: widget.itemsList[index].itemSubTitle,
            isThreeLine: widget.itemsList[index].isThreeLine,
            trailing: Icon(Icons.keyboard_arrow_right),
            // onTap:widget.itemsList[index].onItemPressed!=null? widget.itemsList[index].onItemPressed():(){} ,
          ),
        );
      },
      separatorBuilder: (context, index) {
        return widget.hasDivider ? Divider() : Container();
      },
    );
  }
}
