
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_course/theme/color.dart';

class FavoriteBox extends StatelessWidget {
  FavoriteBox({ Key? key, this.bgColor = Colors.white, this.onTap, this.isFavorited = false,
  this.borderColor = Colors.transparent, this.radius = 50, this.size = 22, this.padding = 8}) : super(key: key);
  final Color borderColor;
  final Color? bgColor;
  final bool isFavorited;
  final double radius;
  final double size;
  final double padding;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        padding: EdgeInsets.all(padding),
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: isFavorited ? primary : bgColor,
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: SvgPicture.asset("assets/icons/bookmark.svg", color: isFavorited ? Colors.white : primary, width: size, height: size,) 
      ),
    );
  }
}
