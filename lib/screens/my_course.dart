import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_course/theme/color.dart';
import 'package:online_course/utils/data.dart';
import 'package:online_course/widgets/icon_box.dart';
import 'package:online_course/widgets/my_course_item.dart';

class MyCoursePage extends StatefulWidget {
  const MyCoursePage({ Key? key }) : super(key: key);

  @override
  _MyCoursePageState createState() => _MyCoursePageState();
}

class _MyCoursePageState extends State<MyCoursePage> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          new SliverAppBar(
            backgroundColor: appBarColor,
            pinned: true,
            snap: true,
            floating: true,
            title: getAppBar(),
            bottom: TabBar(
              controller: tabController,
              indicatorColor: primary,
              indicatorWeight: 1,
              unselectedLabelColor: textColor,
              labelColor: primary,
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(
                  text: "Progress (${myProgressCourses.length})",
                ),
                Tab(
                  text: "Completed (${myCompleteCourses.length})",
                )
              ],
            ),
          ),
        ];
      },
      body: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: TabBarView(
          controller: tabController,
          children: <Widget>[
            getProgressCourses(),
            getCompleteCourses(),
          ],
        ),
      ),
    ));
  }

  Widget getAppBar(){
    return
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: 
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("My Course", style: TextStyle(color: textColor, fontSize: 24, fontWeight: FontWeight.w600),),
                ],
              )
            ),
            IconBox(child: SvgPicture.asset("assets/icons/filter.svg", width: 20, height: 20,), bgColor: appBarColor,)
          ],
        ),
      );
  }

  getProgressCourses(){
    return
    SingleChildScrollView(
      child: Column(
        children: List.generate(myProgressCourses.length, (index) => 
          Container(
            margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: MyCourseItem(
              data: myProgressCourses[index],
            ),
          ) 
        )
      ),
    );
  }

  getCompleteCourses(){
    return
    SingleChildScrollView(
      child: Column(
        children: List.generate(myCompleteCourses.length, (index) => 
          Container(
            margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: MyCourseItem(
              data: myCompleteCourses[index],
            ),
          ) 
        )
      ),
    );
  }


}