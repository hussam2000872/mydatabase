import 'package:flutter/material.dart';
import 'package:my_atabase/dbhelper.dart';
import 'package:my_atabase/model/course.dart';
class CourseUpdate extends StatefulWidget {
  Course course;
  CourseUpdate(this.course);

  @override
  State<CourseUpdate> createState() => _CourseUpdateState();
}

class _CourseUpdateState extends State<CourseUpdate> {
  TextEditingController teName = TextEditingController();
  TextEditingController teContent = TextEditingController();
  TextEditingController teHours = TextEditingController();
    TextEditingController teLevel = TextEditingController();
 late DBhelper helper;
  @override
  void initState() {
    
    super.initState();
    helper = DBhelper();
    teName.text =widget.course.name;
    teContent.text =widget.course.content;
    teLevel.text =widget.course.level;
    teHours.text =widget.course.hours.toString();

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(title: Text('course update'),),
      body:Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(children: [
          TextField(controller: teName,),
          TextField(maxLines: null, controller: teContent,),
          TextField(controller: teHours,),
          TextField(controller: teLevel,),
          ElevatedButton(onPressed: (){
            var updatedcourse = Course({
              'id' : widget.course.id,
              'name' : teName.text,
              'content' : teContent.text,
              'level' : teLevel.text,
              'hours' : int.parse(teHours.text),

            });
            helper.CourseUpdate(updatedcourse);
            Navigator.of(context).pop();
          }, child: Text('Save'))
        ],),
      ) ,
    );
  }
}