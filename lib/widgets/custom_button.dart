import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final String title;

  final Color color;

  final Widget? icon;

  final Function()? onTap;

  final double? width;

  final double? fontSize;

  const CustomButton({
    Key? key,
    required this.title,
    required this.color,
    this.icon,
    this.onTap,
    this.width,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: onTap,
      child: Container(
        height: size.height * 0.06,
        width: width ?? size.height * 0.25,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
        child: FittedBox(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: fontSize ?? 17,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 8,),
                icon ?? const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
