import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final Widget? textfieldIcon;
  final String? initialValue;
  final bool? readonly;
  final bool isNumber;
  final bool autofocus;
  final TextEditingController? controller;

  final List<TextInputFormatter>? formatters;

  final String? Function(String?)? validate;

  final TextInputType? keyboardType;

  const CustomTextFormField({
    Key? key,
    required this.label,
    @required this.textfieldIcon,
    this.initialValue,
    this.readonly,
    this.isNumber = false,
    this.autofocus = false,
    this.controller,
    this.keyboardType,
    this.formatters,
    @required this.validate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      autofocus: autofocus,
      readOnly: readonly ?? false,
      keyboardType: keyboardType ??
          (isNumber ? TextInputType.number : TextInputType.text),
      validator: validate,
      decoration: InputDecoration(
        labelText: this.label,
        border: OutlineInputBorder(),
        suffixIcon: textfieldIcon,
      ),
      inputFormatters: formatters,
    );
  }
}
