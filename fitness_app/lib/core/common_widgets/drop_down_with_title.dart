import 'package:flutter/material.dart';

class DropDownWithTitle extends StatelessWidget {
  final String title;
  final List<String> itemList;
  final String? selectedItem;
  final ValueChanged<String?>? onChanged;
  final String hint;

  const DropDownWithTitle(
      {required this.hint,
      required this.title,
      Key? key,
      required this.itemList,
      required this.selectedItem,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      isExpanded: false,
     // value: selectedItem,
      hint: Text(
        hint,
        style: const TextStyle(fontSize: 14,color: Colors.black26),
      ),
      icon: const Icon(
        Icons.keyboard_arrow_down,
        color: Colors.black26,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select sex';
        } else {
          return null;
        }
      },
      items: List.generate(
          itemList.length,
          (index) => DropdownMenuItem(
              value: itemList[index],
              child: Text(
                itemList[index],
                style: const TextStyle(fontSize: 14, color: Colors.black26),
              ))),
      onChanged: onChanged,
      decoration: InputDecoration(
        isDense: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
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
        focusedBorder:  OutlineInputBorder(
          borderSide:
          const BorderSide(color: Colors.blue, width: 1.0),
          borderRadius: BorderRadius.circular(15),
        ),
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.fromLTRB(15, 15, 10, 15),
      ),
    );
  }
}
