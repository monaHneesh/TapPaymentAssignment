import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BasicInputField extends StatefulWidget{
  final FormFieldValidator<String> validationMethod;
  final String labelText;
  final String errorLabel;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final Key basicInputKey;
  final TextEditingController controller;
  final Function(String) onChanged;
  final TextInputType keyboardType;
  final Widget suffixIcon;
  final int maxLength;
  final TextAlign textAlign;
  final bool validateEmptyString;
  final bool validateZeroNumber;
  final bool clearIcon;




  BasicInputField(
      {
        this.clearIcon = false,
        this.suffixIcon,
        this.keyboardType = TextInputType.text,
        this.validationMethod,
        this.labelText = '',
        this.errorLabel,
        this.textInputAction = TextInputAction.next,
        this.basicInputKey,
        this.controller,
        this.onChanged,
        this.focusNode,
        Key key,
        this.maxLength,
        this.textAlign,
        this.validateEmptyString = false,
        this.validateZeroNumber = false})
      : super(key: key);

  @override
 _BasicInputFieldState createState()=>_BasicInputFieldState();

}
class _BasicInputFieldState extends State<BasicInputField>{
  FocusNode _myFocusNode;
  Key _basicInputKey;
  TextEditingController _textController;
  bool _changedFirstTimeFlag;

  @override
  void initState() {
    _basicInputKey = (widget.basicInputKey == null)
        ? Key('basic_input_field')
        : widget.basicInputKey;
    _myFocusNode = (widget.focusNode == null) ? FocusNode() : widget.focusNode;
    _textController = (widget.controller == null)
        ? TextEditingController()
        : widget.controller;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return   Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: TextFormField(
          textAlign: widget.textAlign ?? TextAlign.start,
          maxLength: widget.maxLength,
          cursorColor: Color(0xFFFB9393),
          key: _basicInputKey,
          textInputAction: widget.textInputAction,
          focusNode: _myFocusNode,
          controller: _textController,
          keyboardType: widget.keyboardType,
          autocorrect: false,
          validator: (val) {
            if (widget.validateEmptyString &&
                (val.isEmpty || val.trim().length == 0)) {
              return (widget.errorLabel ?? "please enter "+widget.labelText);
            }
            if (widget.validationMethod != null) {
              return widget.validationMethod(val);
            }
            return null;
          },

          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            errorMaxLines: 4,
            contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
            counterStyle: TextStyle(
              height: double.minPositive,
            ),
            suffixIcon: (widget.clearIcon &&
                widget.controller.text.isNotEmpty)
                ? GestureDetector(
              child: Icon(Icons.clear),
              onTap: () {
                setState(() {
                  widget.controller.clear();
                  if (widget.onChanged != null) widget.onChanged("");
                });
              },
            )
                : widget.suffixIcon != null
                ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [widget.suffixIcon],
            )
                : null,
            errorStyle: TextStyle(
              color: Colors.red,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular( 5),
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular( 20),
              borderSide: BorderSide(
                color: Color.fromRGBO(226, 222, 223, 1),
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular( 20),
              borderSide: BorderSide(
                color:  Color.fromRGBO(226, 222, 223, 1),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular( 20),
              borderSide: BorderSide(
                color: Color(0xFFFB9393),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Color.fromRGBO(226, 222, 223, 1),
              ),
            ),
            hintText: widget.labelText,
            hintStyle: TextStyle(color:Colors.grey[400]),

            alignLabelWithHint: true,
          ),
          onChanged: (val) {
            (widget.onChanged != null) ? widget.onChanged(val) : () {};
          },
        ),
      ),
    );
  }
  @override
  void dispose() {
    _myFocusNode.dispose();
    super.dispose();
  }
}