import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testing/core/utils/constants.dart';

class TextFieldCustom extends StatelessWidget {
  final TextEditingController controller;
  final String? placeholder;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final int? maxLength;
  final bool readOnly;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChange;
  final Function()? onSubmitted;
  const TextFieldCustom(
      {super.key,
      required this.controller,
      required this.placeholder,
      this.prefixIcon,
      this.suffixIcon,
      this.maxLength,
      this.keyboardType,
      this.maxLines = 1,
      this.obscureText = false,
      this.readOnly = false,
      this.validator,
      this.inputFormatters,
      this.onChange,
      this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        maxLength: maxLength,
        maxLines: maxLines,
        textCapitalization: TextCapitalization.words,
        readOnly: readOnly,
        style: TextStyle(color: readOnly ? Colors.grey : Colors.black87),
        keyboardType: keyboardType ?? TextInputType.text,
        decoration: InputDecoration(
          focusColor: Colors.white,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            borderSide: BorderSide(
              color: blackColor10,
              width: 1,
            ),
          ),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            borderSide: BorderSide(
                color: blackColor10),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(8.0),
            ),
            borderSide: BorderSide(color: Colors.red.withOpacity(.6)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(8.0),
            ),
            borderSide: BorderSide(color: Colors.red.withOpacity(.6)),
          ),
          hintText: placeholder,
          fillColor: blackColor10,
          filled: true,
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 12.0),
        ),
        onChanged: onChange,
        onTap: onSubmitted,
        validator: validator,
        obscureText: obscureText,
        inputFormatters: inputFormatters,
      ),
    );
  }
}
