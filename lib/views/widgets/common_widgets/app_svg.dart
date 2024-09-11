import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stock_watchlist/utils/constants/ui_const.dart';
class CustomSvgIcon extends StatelessWidget {
  final String assetPath;
  final double width;
  final double height;
  final Color? color;
  final BlendMode blendMode;
  final VoidCallback? onTap;
  const CustomSvgIcon({
    super.key,
    required this.assetPath,
    this.width = 24.0,
    this.height = 24.0,
    this.color,
    this.onTap,
    this.blendMode = BlendMode.srcIn,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(assetPath,
          width:  width ,
          height: height ,
          colorFilter: ColorFilter.mode(
              color != null ? color! :kGreyColor,
              blendMode)),
    );
  }
}
