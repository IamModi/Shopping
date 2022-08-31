import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget {
  final VoidCallback? onTapPrefix;
  final VoidCallback? onTapSuffix;
  final String? title;
  final bool? prefixShow;
  final bool? suffixShow;
  final IconData? prefixIcon;
  final Color? iconColor;
  final IconData? suffixIcon;

  CommonAppBar(
      {this.onTapPrefix,
      this.onTapSuffix,
      this.title,
      this.prefixShow = true,
      this.suffixShow = true,
      this.prefixIcon,
      this.iconColor,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[700],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          prefixShow!
              ? InkWell(
                  onTap: onTapPrefix,
                  child: Container(
                    margin: EdgeInsets.only(top: 15, bottom: 15, left: 8),
                    child: Icon(
                      prefixIcon,
                      size: 25,
                      color: iconColor ?? Colors.black,
                    ),
                  ),
                )
              : Container(),
          Text(
            title ?? "Shopping Mall",
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
          suffixShow!
              ? InkWell(
                  onTap: onTapSuffix,
                  child: Container(
                    margin: EdgeInsets.only(top: 15, bottom: 15, right: 8),
                    // alignment: Alignment.center,
                    child: Icon(
                      suffixIcon,
                      size: 25,
                      color: iconColor ?? Colors.black,
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
