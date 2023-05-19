import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_course/screens/course_detail.dart';
import 'package:online_course/theme/color.dart';
import 'package:online_course/utils/data.dart';
import 'package:online_course/widgets/category_item.dart';
import 'package:online_course/widgets/course_item.dart';
import 'package:online_course/widgets/custom_textfield.dart';
import 'package:online_course/widgets/icon_box.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({ Key? key }) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: appBarColor,
            pinned: true,
            snap: true,
            floating: true,
            title: getAppBar(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => buildBody(),
              childCount: 1,
            ),
          )
        ],
      )
    );
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
                  Text("Explore", style: TextStyle(color: textColor, fontSize: 24, fontWeight: FontWeight.w600),),
                ],
              )
            ),
            // IconBox(child: SvgPicture.asset("assets/icons/search.svg", width: 20, height: 20,), bgColor: appBarColor,)
          ],
        ),
      );
  }

  buildBody(){
     return 
      SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextBox(hint: "Search", prefix: Icon(Icons.search, color: Colors.grey), )
                  ),
                  SizedBox(width: 10,),
                  IconBox(
                    child: SvgPicture.asset("assets/icons/filter.svg", color: Colors.white, width: 24, height: 24,), 
                    bgColor: primary, radius: 10,
                  )
                ],
              ),
            ),
            SizedBox(height: 10,),
            getCategories(),
            SizedBox(height: 10,),
            getCourses(),
          ],
        ),
      );
   }

  int selectedCategory = 0;
  getCategories(){
    return
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(bottom: 5, top: 5, left: 15),
        child: Row(
          children: List.generate(categories.length, 
            (index) => CategoryItem(
              data: categories[index],
              isSelected: selectedCategory == index,
              onTap: () {
                setState(() {
                  selectedCategory = index;
                });
              },
            )
          )
        ),
      );
  }

  getCourses(){
    return
      SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
        child: Column(
          children: List.generate(courses.length, 
            (index) =>  CourseItem(
              onTapFavorite: (){
                setState(() {
                  courses[index]["is_favorited"] = ! courses[index]["is_favorited"];
                });
              },
              onTap: (){
                Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => CourseDetailPage(data: courses[index],))
                );
              },
              data: courses[index],
              width: MediaQuery.of(context).size.width,
            )
          )
        ),
      );
  }

}