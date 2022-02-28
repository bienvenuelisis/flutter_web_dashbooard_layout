import 'package:flutter/material.dart';
import 'package:flutter_web_dashbooard_layout/constants/colors.dart';

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

  final EdgeInsets? padding;

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
