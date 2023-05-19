import 'package:flutter/material.dart';
import 'package:online_course/theme/color.dart';
import 'custom_image.dart';

class MyCourseItem extends StatelessWidget {
  MyCourseItem({ required this.data, Key? key, this.progressColor = blue, this.completedPercent = 0.0 }) : super(key: key);
  final data;
  final Color progressColor;
  final double completedPercent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
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
                      style: TextStyle(color: textColor, fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(data["completed"], style: TextStyle(color: progressColor),),
                        Visibility(
                          visible: data["complete_percent"] < 1,
                          child: Text(data["progress"], style: TextStyle(color: labelColor))
                        ),
                      ],
                    ),
                    SizedBox(height: 7,),
                    Container(
                      alignment: Alignment.topCenter,
                      child: LinearProgressIndicator(
                        value: data["complete_percent"].toDouble() ?? 0.0,
                        backgroundColor: progressColor.withOpacity(.2),
                        valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                      )
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}