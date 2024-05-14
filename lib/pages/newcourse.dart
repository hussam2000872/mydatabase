import 'package:flutter/material.dart';
import 'package:my_atabase/dbhelper.dart';
import 'package:my_atabase/model/course.dart';

class newcourse extends StatefulWidget {
  const newcourse({super.key});

  @override
  State<newcourse> createState() => _newcourseState();
}

class _newcourseState extends State<newcourse> {
   late String name,content;
    late int hours;
   late DBhelper helper;

   @override
  void initState() {
    super.initState();
    helper = DBhelper();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('new course'),
      ),
      body:Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter course name'
                ),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              
              ),
              SizedBox(height: 15.0,),
              TextFormField(
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: 'Enter course content'
                ),
                onChanged: (value) {
                  setState(() {
                    content = value;
                  });
                },
               
              ),
              SizedBox(height: 15.0,),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter course hours'
                ),
                onChanged: (value) {
                  setState(() {
                    hours = int.parse(value) ;
                  });
                },
        
              ),
               SizedBox(height: 15.0,),
              ElevatedButton(child: Text('save'), onPressed: () async{
                var course = Course({'name':name,'content' : content,'hours':hours});
                int id = await helper.createcourse(course);
                Navigator.of(context).pop();
              },)
            ],
          ),),
      ),
    );
  }
}