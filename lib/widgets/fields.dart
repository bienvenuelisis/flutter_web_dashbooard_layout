import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    Key? key,
    this.onChanged,
    this.initialValue,
    this.width,
    this.hintText,
  }) : super(key: key);

  final ValueChanged<String>? onChanged;

  final String? initialValue;

  final double? width;

  final String? hintText;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.initialValue);
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        width: widget.width,
        child: TextField(
          controller: _controller,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            hintText: widget.hintText ?? "Search",
            filled: true,
            prefixIcon: const Icon(Icons.search),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ),
    );
  }
}

class UpperCaseTextFormatter implements TextInputFormatter {
  const UpperCaseTextFormatter();

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

const String virgule = ",";
const String point = ".";
const String plus = "+";
const String minus = "-";

class DoubleTextInputFormatter extends TextInputFormatter {
  final bool positive;

  DoubleTextInputFormatter({
    this.positive = false,
  });
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return ((newValue.text.isEmpty) ||
            (newValue.text.startsWith(plus) &&
                (newValue.text.length == 1 ||
                    validateDoubleValue(
                          newValue.text,
                          "...",
                          positive: positive,
                        ) ==
                        null)) ||
            (!positive &&
                newValue.text.startsWith(minus) &&
                (newValue.text.length == 1 ||
                    validateDoubleValue(
                          newValue.text,
                          "...",
                          positive: positive,
                        ) ==
                        null)) ||
            (validateDoubleValue(
                  newValue.text,
                  "...",
                  positive: positive,
                ) ==
                null))
        ? newValue
        : oldValue;
  }
}

class IntegerTextInputFormatter extends TextInputFormatter {
  final bool positive;

  IntegerTextInputFormatter({
    this.positive = false,
  });
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return ((newValue.text.isEmpty) ||
            (newValue.text.startsWith(plus) &&
                (newValue.text.length == 1 ||
                    validateIntValue(newValue.text, "...") == null)) ||
            (!positive &&
                newValue.text.startsWith(minus) &&
                (newValue.text.length == 1 ||
                    validateIntValue(newValue.text, "...") == null)) ||
            (validateIntValue(newValue.text, "...") == null))
        ? newValue
        : oldValue;
  }
}

class DoubleWithCommaTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return (!newValue.text.contains(point) &&
            (newValue.text.isEmpty ||
                validateDoubleValue(newValue.text, "...") == null))
        ? newValue
        : oldValue;
  }
}

class AlphabeticTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text.replaceAll("'", "").replaceAll(" ", "");
    return (newValue.text.isEmpty || (!RegExp(r'\d+').hasMatch(text)))
        ? newValue
        : oldValue;
  }
}

List<T> extractList<T>(
  Map<String, dynamic> data,
  String field,
  T Function(dynamic value) parse, [
  List<T>? defaults,
]) {
  if (data[field] != null && data[field].isNotEmpty) {
    if (data[field] is List<T>) {
      return data[field];
    } else if (data[field] is List<dynamic>) {
      return data[field]
          .cast<dynamic>()
          .map<T>((value) => parse(value))
          .toList();
    }
  }

  return defaults ?? [];
}

T? extractOne<T>(
  Map<String, dynamic> data,
  String field,
  T Function(dynamic value) parse,
) {
  if (data[field] != null) {
    if (data[field] is T) {
      return data[field];
    } else {
      return parse(data[field]);
    }
  }

  return null;
}

Widget buildTextField(
  String hint,
  TextEditingController controller,
  bool isNumber,
  String? Function(String?)? validate, {
  List<TextInputFormatter>? formatters,
}) {
  return Container(
    margin: const EdgeInsets.all(4),
    child: TextFormField(
      decoration: InputDecoration(
        labelText: hint,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
      ),
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      validator: validate,
      inputFormatters: formatters,
    ),
  );
}

String? validateDouble(TextEditingController fieldController, String errorMsg) {
  return validateDoubleValue(fieldController.text, errorMsg);
}

String? validateDoubleValue(
  String? value,
  String errorMsg, {
  bool positive: false,
}) {
  if ((value ?? "").isEmpty) {
    return errorMsg;
  } else {
    try {
      value = value!.replaceFirst(",", ".");
      double d = double.parse(value);
      return positive ? (d >= 0 ? null : errorMsg) : null;
    } catch (e) {
      return errorMsg;
    }
  }
}

String? validateIntValue(
  String value,
  String errorMsg, {
  bool positive: false,
}) {
  if (value.isNotEmpty) {
    try {
      int? i = int.tryParse(value);
      return i == null
          ? errorMsg
          : (positive ? (i > 0 ? null : errorMsg) : null);
    } catch (e) {
      return errorMsg;
    }
  } else {
    return null;
  }
}

typedef TimePickFunc = Future<void> Function(TimeOfDay);

typedef TimePickValidatorFunc = String Function(TimeOfDay);

typedef DatePickFunc = Future<void> Function(DateTime);

typedef DatePickValidatorFunc = String Function(DateTime);

class TimePickerFormField extends StatefulWidget {
  const TimePickerFormField({
    @required this.initialValue,
    this.validator,
    this.analogic = false,
    required this.label,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  final String label;

  final TimePickFunc onChanged;

  final TimeOfDay? initialValue;

  final bool analogic;

  final TimePickValidatorFunc? validator;

  @override
  _TimePickerFormFieldState createState() => _TimePickerFormFieldState();
}

class _TimePickerFormFieldState extends State<TimePickerFormField> {
  TextEditingController get controller => TextEditingController(
        text: DateFormat.Hm("fr_FR").format(
          DateTime(
            now.year,
            now.month,
            now.day,
            time.hour,
            time.minute,
          ),
        ),
      );

  late TimeOfDay time;

  DateTime get now => DateTime.now();

  @override
  void initState() {
    time = widget.initialValue ?? TimeOfDay.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller, // add this line.
      decoration: InputDecoration(
        labelText: widget.label,
      ),
      onTap: () async {
        //FocusScope.of(context).requestFocus(new FocusNode());

        TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime: time,
          initialEntryMode: widget.analogic
              ? TimePickerEntryMode.dial
              : TimePickerEntryMode.input,
        );
        if (picked != null && picked != time) {
          setState(() {
            time = picked;
          });

          widget.onChanged(picked);
        }
      },
      validator: widget.validator == null
          ? (_) {
              return null;
            }
          : (_) {
              return widget.validator!(time);
            },
    );
  }
}

class DatePickerFormField extends StatefulWidget {
  const DatePickerFormField({
    @required this.initialValue,
    @required this.validator,
    @required this.hintText,
    @required this.border,
    @required this.suffixIcon,
    required this.label,
    @required this.onChanged,
    required this.firstDate,
    required this.lastDate,
    Key? key,
  }) : super(key: key);

  final String label;

  final InputBorder? border;

  final Widget? suffixIcon;

  final String? hintText;

  final DatePickFunc? onChanged;

  final DateTime? initialValue;

  final DateTime firstDate;

  final DateTime lastDate;

  final DatePickValidatorFunc? validator;

  @override
  _DatePickerFormFieldState createState() => _DatePickerFormFieldState();
}

class _DatePickerFormFieldState extends State<DatePickerFormField> {
  TextEditingController get controller => TextEditingController(
        text: DateFormat.yMMMMEEEEd("fr_FR").format(
          DateTime(
            date.year,
            date.month,
            date.day,
            now.hour,
            now.minute,
          ),
        ),
      );

  late DateTime date;

  DateTime get now => DateTime.now();

  @override
  void initState() {
    date = widget.initialValue ?? now;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller, // add this line.
      decoration: InputDecoration(
        labelText: widget.label,
        border: widget.border,
        suffixIcon: widget.suffixIcon,
      ),
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
          initialDatePickerMode: DatePickerMode.day,
          initialEntryMode: DatePickerEntryMode.calendar,
          fieldHintText: widget.hintText,
          fieldLabelText: widget.label,
        );

        if (picked != null && picked != date) {
          setState(() {
            date = picked;
          });

          widget.onChanged!(picked);
        }
      },
      validator: (_) {
        return widget.validator == null ? null : widget.validator!(date);
      },
    );
  }
}

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField({
    required Widget title,
    Key? key,
    @required FormFieldSetter<bool>? onSaved,
    @required FormFieldValidator<bool>? validator,
    bool initialValue = false,
    bool autovalidate = false,
  }) : super(
          key: key,
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          builder: (FormFieldState<bool> state) {
            return CheckboxListTile(
              dense: state.hasError,
              title: title,
              value: state.value,
              onChanged: state.didChange,
              subtitle: state.hasError
                  ? Builder(
                      builder: (BuildContext context) => Text(
                        state.errorText ?? "",
                        style: TextStyle(color: Theme.of(context).errorColor),
                      ),
                    )
                  : null,
              controlAffinity: ListTileControlAffinity.leading,
            );
          },
        );
}

class MultiSelectChip extends StatefulWidget {
  final List<String> list;

  final Function(List<String>) onSelectionChanged;

  const MultiSelectChip(
    this.list, {
    Key? key,
    required this.onSelectionChanged,
  }) : super(key: key);
  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  List<String> selectedChoices = [];

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: widget.list
          .map(
            (item) => Container(
              padding: const EdgeInsets.all(2.0),
              child: ChoiceChip(
                label: Text(item),
                selected: selectedChoices.contains(item),
                onSelected: (selected) {
                  setState(() {
                    isSelected = selected;
                    selectedChoices.contains(item)
                        ? selectedChoices.remove(item)
                        : selectedChoices.add(item);
                    widget.onSelectionChanged(selectedChoices); // +added
                  });
                },
              ),
            ),
          )
          .toList(),
    );
  }
}

class MultiSelectField<T> extends StatefulWidget {
  final List<T> values;

  final Function(List<T>) onSelectionChanged;

  final String label;

  final String Function(T) name;

  final Color selectedColor;

  final TextStyle? labelStyle;

  const MultiSelectField(
    this.label,
    this.values, {
    required this.onSelectionChanged,
    required this.name,
    Key? key,
    @required this.labelStyle,
    this.selectedColor = Colors.blue,
  }) : super(key : key);
  @override
  _MultiSelectFieldState<T> createState() => _MultiSelectFieldState<T>();
}

class _MultiSelectFieldState<T> extends State<MultiSelectField> {
  List<T> selectedChoices = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.label,
            style: widget.labelStyle ?? const TextStyle(fontSize: 18),
          ),
        ),
        Wrap(
          children: widget.values
              .map(
                (item) => Container(
                  padding: const EdgeInsets.all(2.0),
                  child: ChoiceChip(
                    label: Text(widget.name(item)),
                    selected: selectedChoices.contains(item),
                    selectedColor: widget.selectedColor,
                    onSelected: (selected) {
                      setState(
                        () {
                          selectedChoices.contains(item)
                              ? selectedChoices.remove(item)
                              : selectedChoices.add(item);
                          widget.onSelectionChanged(selectedChoices); // +added
                        },
                      );
                    },
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
