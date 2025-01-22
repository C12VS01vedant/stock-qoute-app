import 'package:flutter/material.dart';


abstract class AppInputStyles {

  static const EdgeInsets inputPadding = EdgeInsets.symmetric(
    vertical: 12.0,
    horizontal: 16.0,
  );

  
  static const BorderRadius inputBorderRadius = BorderRadius.all(
    Radius.circular(8.0),
  );


  static const OutlineInputBorder enabledBorder = OutlineInputBorder(
    borderRadius: inputBorderRadius,
    borderSide: BorderSide(
      color: Colors.grey,
      width: 1.0,
    ),
  );

  static const OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderRadius: inputBorderRadius,
    borderSide: BorderSide(
      color: Colors.blue,
      width: 2.0,
    ),
  );

  static const OutlineInputBorder errorBorder = OutlineInputBorder(
    borderRadius: inputBorderRadius,
    borderSide: BorderSide(
      color: Colors.red,
      width: 1.5,
    ),
  );

  static InputDecoration inputDecoration({
    required String hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      contentPadding: inputPadding,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      enabledBorder: enabledBorder,
      focusedBorder: focusedBorder,
      errorBorder: errorBorder,
      border: enabledBorder,
    );
  }


  static Widget textField({
    required String hintText,
    TextEditingController? controller,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Function(String)? onChanged,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: inputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }

  // Checkbox Style
  static Widget checkbox({
    required bool value,
    required Function(bool?) onChanged,
    required String label,
    Color activeColor = Colors.blue,
    Color checkColor = Colors.white,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: activeColor,
          checkColor: checkColor,
        ),
        Text(label, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
  static Widget dropdown<T>({
    required T? value,
    required List<DropdownMenuItem<T>> items,
    required Function(T?) onChanged,
    String? hint,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      decoration: inputDecoration(hintText: hint ?? ''),
    );
  }
}