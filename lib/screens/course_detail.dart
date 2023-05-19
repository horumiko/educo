import 'package:flutter/material.dart';
import 'package:online_course/theme/color.dart';
import 'package:online_course/utils/data.dart';
import 'package:online_course/widgets/custom_button.dart';
import 'package:online_course/widgets/custom_image.dart';
import 'package:online_course/widgets/favorite_box.dart';
import 'package:online_course/widgets/lesson_item.dart';
import 'package:readmore/readmore.dart';

class CourseDetailPage extends StatefulWidget {
  CourseDetailPage({ Key? key, required this.data }) : super(key: key);
  final data;
  @override
  _CourseDetailPageState createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> with SingleTickerProviderStateMixin  {
  var data;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    data = widget.data;
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: getAppBar(),
      body: buildBody(),
      bottomNavigationBar: getBottom(),
    );
  }

  getLessons(){
    return
      ListView.builder(itemCount: lessons.length, itemBuilder: (context, index) {
        return LessonItem(data: lessons[index],);
      });
  }

  getAppBar(){
    return
      AppBar(
        iconTheme: IconThemeData(color: darker),
        backgroundColor: appBarColor,
        title: Text("Detail", style: TextStyle(color: textColor),),
        actions: [

        ],
      );
  }

  buildBody(){
    return
      SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: data["id"].toString() + data["image"],
                child: CustomImage(data["image"],
                  radius: 10,
                  width: double.infinity, height: 220,
                ),
              ),
              SizedBox(height: 15,),
              getInfo(),
              SizedBox(height: 5,),
              Divider(),
              getTabBar(),
              getTabBarPages()
            ],
          ),
        ),
      );
  }

  getTabBar(){
    return
      Container(
        child: TabBar(
          controller: tabController,
          labelColor: Colors.redAccent,
          isScrollable: false,
          indicatorColor: primary,
          tabs: [
            Tab(
              child: Container(
                child: Text(
                  "Lessons",
                    style: TextStyle(color: darker, fontSize: 16),
                ),
              ),
            ),
            Tab(
              child: Text(
                "Exercises",
                  style: TextStyle(color: darker, fontSize: 16),
              ),
            ),
          ],
        ),
      );
  }

  getTabBarPages(){
    return
    Container(
      constraints: BoxConstraints(
        minHeight: 150, maxHeight: 350
      ),
      width: double.infinity,
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
          getLessons(),
          Container(
            child: Center(
              child: Text("Coming Soon!", style: TextStyle(fontSize: 16),),
            )
          )
        ],
      ),
    );
  }

  getInfo(){
    return
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Row(
              children: [
                Expanded(child: 
                  Text(data["name"], maxLines: 2, overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  )
                ),
                FavoriteBox(
                  isFavorited: data["is_favorited"],
                  onTap: () {
                    setState(() {
                      data["is_favorited"] = !data["is_favorited"];
                    });
                  },
                )
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                getAttribute(Icons.play_circle_outlined, labelColor, data["session"]),
                SizedBox(width: 15,),
                getAttribute(Icons.schedule_rounded, labelColor, data["duration"]),
                SizedBox(width: 15,),
                getAttribute(Icons.star, yellow, data["review"]),
              ],
            ),
            SizedBox(height: 15,),
            Text("About Course", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
            SizedBox(height: 5,),
            ReadMoreText(
              data["description"],
              style: TextStyle(color: labelColor, height: 1.5),
              trimLines: 2,
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Show more',
              trimExpandedText: 'Show less',
              moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: red),
            ),
          ],
        ),
      );
  }

  getBottom(){
    return
      Container(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
        height: 80, width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Price", style: TextStyle(fontSize: 14, color: labelColor, fontWeight: FontWeight.w500),),
                SizedBox(height: 3,),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: data["price"], style: TextStyle(fontSize: 18, color: textColor, fontWeight: FontWeight.w600),),
                    ]
                  )
                )
              ],
            ),
            SizedBox(width: 30,),
            Expanded(
              child: CustomButton(
                radius: 10,
                title: "Buy Now",
                onTap: (){

              }),
            ),
          ],
        ),
      );
  }

  getAttribute(IconData icon, Color color, String info){
    return
      Row(
        children: [
          Icon(icon, size: 20, color: color,),
          SizedBox(width: 3,),
          Text(info, maxLines: 1, overflow: TextOverflow.ellipsis, 
            style: TextStyle(color: labelColor, fontSize: 14),
          ),
        ],
      );
  }
}