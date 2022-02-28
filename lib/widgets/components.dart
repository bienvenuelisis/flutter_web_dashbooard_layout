import 'package:flutter/material.dart';

import '../constants/colors.dart';

class IconTitleSubtitle extends StatelessWidget {
  final Function()? onTap;
  final String image;
  final String title;
  final String subtitle;
  final Color color;

  const IconTitleSubtitle({
    Key? key,
    this.onTap,
    required this.image,
    required this.title,
    required this.subtitle,
    this.color = primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(image),
                alignment: Alignment.center,
                height: 90,
                width: 90,
                fit: BoxFit.fill,
              ),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

enum ButtonType { PRIMARY, PLAIN }

class AppButton extends StatelessWidget {
  final ButtonType type;
  final VoidCallback? onPressed;
  final String text;

  const AppButton({
    Key? key,
    required this.type,
    @required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
          color: getButtonColor(context, type),
          borderRadius: BorderRadius.circular(4.0),
          boxShadow: const [
            BoxShadow(
                //color: Color.fromRGBO(169, 176, 185, 0.42),
                //spreadRadius: 0,
                //blurRadius: 3.0,
                //offset: Offset(0, 2),
                )
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: getTextColor(context, type),
                ),
          ),
        ),
      ),
    );
  }
}

Color getButtonColor(context, ButtonType type) {
  switch (type) {
    case ButtonType.PRIMARY:
      return Theme.of(context).buttonColor;
    case ButtonType.PLAIN:
      return Colors.white;
    default:
      return Theme.of(context).primaryColor;
  }
}

Color getTextColor(context, ButtonType type) {
  switch (type) {
    case ButtonType.PLAIN:
      return Theme.of(context).primaryColor;
    case ButtonType.PRIMARY:
      return Colors.white;
    default:
      return Theme.of(context).buttonColor;
  }
}

class InputWidget extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final Widget? prefixIcon;
  final double? height;
  final String topLabel;
  final bool obscureText;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final Key? kKey;
  final TextEditingController? kController;
  final String? kInitialValue;

  const InputWidget({
    this.hintText,
    this.prefixIcon,
    this.height = 48.0,
    this.topLabel = "",
    this.obscureText = false,
    this.onSaved,
    this.keyboardType,
    this.errorText,
    this.onChanged,
    this.validator,
    this.kKey,
    this.kController,
    this.kInitialValue,
  }) : super(key: kKey);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(topLabel),
        const SizedBox(height: 4.0),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: TextFormField(
            initialValue: kInitialValue,
            controller: kController,
            key: kKey,
            keyboardType: keyboardType,
            onSaved: onSaved,
            onChanged: onChanged,
            validator: validator,
            obscureText: obscureText,
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(74, 77, 84, 0.2),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                //gapPadding: 16,
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              errorStyle: const TextStyle(height: 0, color: Colors.transparent),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).errorColor,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                //gapPaddings: 16,
                borderSide: BorderSide(
                  color: Theme.of(context).errorColor,
                ),
              ),
              hintText: hintText,
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white54),
              errorText: errorText,
            ),
          ),
        )
      ],
    );
  }
}

class ContainerButton extends StatelessWidget {
  const ContainerButton({
    Key? key,
    this.onTap,
    this.padding = const EdgeInsets.all(8.0),
    this.width,
    this.height,
    this.color,
    required this.text,
    required this.icon,
    this.visible = true,
    this.emptyWidget = const SizedBox.shrink(),
  }) : super(key: key);

  final EdgeInsets padding;

  final bool visible;

  final Widget icon;

  final Widget emptyWidget;

  final void Function()? onTap;

  final double? width;

  final double? height;

  final Color? color;

  final String text;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return visible
        ? Container(
            height: height ?? size.height * 0.1,
            width: width ?? size.width * 0.9,
            padding: padding,
            child: InkWell(
              onTap: onTap,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      icon,
                      Text(
                        text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                elevation: 5,
                color: color ?? secondaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
          )
        : emptyWidget;
  }
}
