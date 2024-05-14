
import 'package:flutter/material.dart';
import 'package:my_atabase/dbhelper.dart';
import 'package:my_atabase/model/course.dart';
import 'package:my_atabase/pages/coursedetails.dart';
import 'package:my_atabase/pages/courseupdate.dart';
import 'package:my_atabase/pages/newcourse.dart';
class SQlite extends StatefulWidget {
 

  @override
  State<SQlite> createState() => __SQliteState();
}

class __SQliteState extends State<SQlite> {
late  DBhelper helper; 
TextEditingController teSearch = TextEditingController();
var allCourses = [];
var items =List();

  @override
  void initState() {
    super.initState();
    helper = DBhelper();
    helper.allcourses().then((courses){
      setState(() {
        allCourses = courses;
        items = allCourses;
      });
    });
    
    void filtersearch(String query ) async{
     var dumysearchList =allCourses;
     if(query.isNotEmpty) {
      var dumyListdata = List();
       dumysearchList.forEach((item){
        var course =  Course.fromMap(item); 
        if(course.name.toLowerCase().contains(query.toLowerCase())){
        dumyListdata.add(item);
        }

       });
       setState(() {
          items=[];
          items.addAll(dumyListdata);
       });
       return;
     }else{
      setState(() {
         items = [];
         items= allCourses;
      });

     }
    }

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('SQlite database '),
        actions: [IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> newcourse()  ));
        }, icon: Icon(Icons.add))],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextField(
          onChanged: (value) { 
            setState(() {
            filtersearch(value);
            });
          },
          controller: teSearch,
          decoration: InputDecoration(
            hintText:  'Search..',
            labelText: 'Search..',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
            )
          ),
          ),
        ),
        Expanded(child:ListView.builder(
              itemCount: items.length,
              itemBuilder:(context,i) {
                Course course = Course.fromMap(items[i]);
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(title: Text ('${course.name} -${course.hours} hours - ${course.level} '),
                  subtitle: Text(course.content.substring(0,180)),
                  trailing:Column(children: [
                    Expanded(
                    child: IconButton(onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CourseUpdate(course) ));
                     
                    }, icon:Icon(Icons.edit,color: Colors.green)),
                  ),
                  Expanded(
                    child: IconButton(onPressed: (){
                    setState(() {
                      helper.delete(course.id);
                    });
                    }, icon:Icon(Icons.delete,color: Colors.red,)),
                  ),
                  ],) ,
                  
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CourseDetails(course) ));
                  },
                   ),
                );


              }), )
      ],) 
    );
  }
}