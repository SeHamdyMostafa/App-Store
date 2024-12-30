import 'package:flutter/material.dart';

class TextField_Design extends StatelessWidget {
  const TextField_Design({
    super.key,
    required this.hintname,
    required this.ontap,
    this.initialValue = '',
    this.keyboardType = TextInputType.text,
    this.errorMessage = 'This field cannot be empty',
    this.obscureText = false,
    this.helperText,
  });

  final String hintname;
  final Function(String) ontap;
  final String initialValue;
  final TextInputType keyboardType;
  final String errorMessage;
  final bool obscureText;
  final String? helperText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue: initialValue,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintname,
          helperText: helperText,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.orange),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.orange),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        onChanged: ontap,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return errorMessage;
          }
          return null;
        },
      ),
    );
  }
}
