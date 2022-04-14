import 'package:flutter/material.dart';

abstract class IButton {}

class CommonButton extends StatelessWidget implements IButton {
  final VoidCallback onPressed;
  final Widget child;
  final String text;
  final double height;
  final bool hasBoxShadow;
  final bool fit;
  final double width;
  Color disableColor;

  CommonButton(
      {Key key,
      this.fit = false,
      this.width,
      this.disableColor,
      @required this.onPressed,
      this.child,
      this.text = "",
      this.height = 50,
      this.hasBoxShadow = false})
      : super(key: key);

  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth =
        deviceWidth < 550.0 ? deviceWidth - 20 : deviceWidth * 0.7;

    return Container(
      width: width != null
          ? width
          : (!fit)
              ? targetWidth
              : null,
      height: height,
      decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xffFFC7C7),
          ),
          boxShadow: hasBoxShadow
              ? [
                  BoxShadow(
                    color: Color(0xffFFC7C7).withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ]
              : null,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          color: disableColor != null ? disableColor : Color(0xffFFB3B3)),
      child: FlatButton(

        textColor: Colors.white,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(20)),
        color: Colors.transparent,
        disabledColor: Color(0xffFFC7C7),
        disabledTextColor: Colors.white,
        onPressed: () {
          onPressed();
        },
        child: child ??
            FittedBox(
                child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(color: Colors.white, fontSize: 18),
            )),
      ),
    );
  }
}
