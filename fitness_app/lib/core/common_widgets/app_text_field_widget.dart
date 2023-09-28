import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef FieldValidator<T> = String? Function(T? value);

class AppTextFieldWidget extends StatefulWidget {
  final String? labelText;
  final EdgeInsetsGeometry? labelTextPadding;
  final String? hintText;
  final String? errorText;
  final bool isPasswordTextField;
  final TextEditingController textFieldController;
  final Widget? suffixIconWidget;
  final Widget? prefixIconWidget;
  final TextStyle? textStyle;
  final EdgeInsets margin;
  final FormFieldValidator<String>? validator;
  final bool isEnabled;
  final bool readOnly;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldSetter<String>? onSaved;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final FloatingLabelBehavior floatingLabelBehavior;
  final TextStyle? labelTextStyle;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final bool autoFocus;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final EdgeInsets? contentPadding;
  final bool isExpand;
  final String autoFillHint;
  final bool? disableFocusBorder;

  const AppTextFieldWidget({
    Key? key,
    this.labelText,
    this.labelTextPadding,
    this.hintText,
    this.isPasswordTextField = false,
    required this.textFieldController,
    this.errorText,
    this.prefixIconWidget,
    this.suffixIconWidget,
    this.textStyle,
    this.margin = const EdgeInsets.all(0.0),
    this.validator,
    this.isEnabled = true,
    this.readOnly = false,
    this.inputFormatters,
    this.autoFocus = false,
    this.onTap,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.maxLength,
    this.maxLines = 1,
    this.minLines,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.labelTextStyle,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.isExpand = false,
    this.disableFocusBorder = false,
    this.contentPadding,
    this.textCapitalization = TextCapitalization.none,
    this.autoFillHint = '',
  }) : super(key: key);

  @override
  AppTextFieldWidgetState createState() => AppTextFieldWidgetState();
}

class AppTextFieldWidgetState extends State<AppTextFieldWidget> {
  bool isShowPassword = true;
  bool isErrorShow = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      alignment: Alignment.center,
      child: widget.isExpand
          ? IntrinsicHeight(child: mainTextFieldWidget())
          : mainTextFieldWidget(),
    );
  }

  Widget mainTextFieldWidget() {
    return Theme(
        data: Theme.of(context).copyWith(
      primaryColor: Colors.black26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.labelText != null)
            Padding(
              padding:
                  widget.labelTextPadding ?? const EdgeInsets.only(bottom: 2.0),
              child: Text(
                widget.labelText!,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ),
          TextFormField(
            autofocus: widget.autoFocus,
            style: widget.textStyle ??
                TextStyle(fontSize: 14, color: Colors.black26),
            enabled: widget.isEnabled,
            maxLength: widget.maxLength,
            readOnly: widget.readOnly,
            onTap: widget.onTap,
            expands: widget.isExpand,
            minLines: widget.isExpand ? null : widget.minLines,
            maxLines: widget.isExpand ? null : widget.maxLines,
            onChanged: widget.onChanged,
            keyboardType: widget.keyboardType,
            onEditingComplete: widget.onEditingComplete,
            onFieldSubmitted: widget.onFieldSubmitted,
            onSaved: widget.onSaved,
            textCapitalization: widget.textCapitalization,
            controller: widget.textFieldController,
            obscureText: widget.isPasswordTextField ? isShowPassword : false,
            validator: (v) {
              if (widget.validator == null) {
                return null;
              }
              if (widget.validator!.call(v) != null) {
                setState(() {
                  isErrorShow = true;
                });
              } else {
                setState(() {
                  isErrorShow = false;
                });
              }
              return widget.validator!.call(v);
            },
            inputFormatters: widget.inputFormatters,
            textInputAction: widget.textInputAction,
            focusNode: widget.focusNode,
            cursorColor: Colors.blue,
            autofillHints: widget.autoFillHint.isNotEmpty
                ? [
                    widget.autoFillHint,
                  ]
                : null,
            decoration: InputDecoration(
              isDense: true,
              floatingLabelBehavior: widget.floatingLabelBehavior,
              errorText: widget.errorText,
              //errorStyle: AppThemeData.errorTextFieldStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Colors.blue,
                  width: 1,
                  style: BorderStyle.none,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue, width: 1.0),
                borderRadius: BorderRadius.circular(15),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              focusedBorder: widget.disableFocusBorder == true
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    )
                  : OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 1.0),
                      borderRadius: BorderRadius.circular(15),
                    ),
              fillColor: Colors.white,
              filled: true,
              prefixIcon: widget.prefixIconWidget,
              suffixIcon: widget.suffixIconWidget ??
                  (widget.isPasswordTextField
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  if (widget.focusNode != null) {
                                    widget.focusNode!.unfocus();
                                    widget.focusNode!.canRequestFocus = false;
                                  }
                                  setState(() {
                                    isShowPassword = !isShowPassword;
                                  });
                                  if (widget.focusNode != null) {
                                    Future.delayed(
                                        const Duration(milliseconds: 100), () {
                                      widget.focusNode!.canRequestFocus = true;
                                    });
                                  }
                                },
                                child: Icon(
                                  isShowPassword
                                      ? Icons.visibility_off_rounded
                                      : Icons.visibility_rounded,
                                  size: 20,
                                  color: Colors.black26,
                                ),
                              ),
                            ),
                          ],
                        )
                      : null),
              hintText: widget.hintText,
              hintStyle: TextStyle(fontSize: 14,color: Colors.black26),
              contentPadding:
                  widget.contentPadding ?? EdgeInsets.fromLTRB(10, 20, 10, 20),
            ),
          ),
        ],
      ),
   );
  }
}
