import 'package:flutter/material.dart';
import 'package:online_course/theme/color.dart';

import 'custom_image.dart';

class LessonItem extends StatelessWidget {
  LessonItem({ Key? key, required this.data }) : super(key: key);
  final data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(1, 1), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          CustomImage(data["image"],
            radius: 10,
            height: 70, width: 70,
          ),
          SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data["name"], maxLines: 1, overflow: TextOverflow.ellipsis, 
                  style: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Icon(Icons.schedule_rounded, color: labelColor, size: 14,), 
                    SizedBox(width: 2,),
                    Text(data["duration"], style: TextStyle(fontSize: 13, color: labelColor),),
                  ],
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios_outlined, color: labelColor, size: 15,), 
        ],
      )
    );
  }
}