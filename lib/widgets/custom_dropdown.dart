import 'package:flutter/material.dart';
import 'package:flutter_web_dashbooard_layout/constants/colors.dart';

class CustomDropdown extends StatefulWidget {
  final String? initialValue;

  final List<DropdownMenuItem<String>>? items;

  const CustomDropdown({
    Key? key,
    this.items,
    this.initialValue,
  }) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late String _value;

  String get value => _value;

  @override
  void initState() {
    _value = widget.initialValue ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: primaryColor, width: 2),
          borderRadius: BorderRadius.circular(5),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      validator: (value) => value == null ? "Choisir" : null,
      dropdownColor: Colors.white,
      value: value,
      onChanged: (String? value) {
        if (value != null) {
          setState(() {
            _value = value;
          });
        }
      },
      items: widget.items,
    );
  }
}
