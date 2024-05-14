import 'package:my_atabase/model/course.dart';
import 'package:my_atabase/pages/courseupdate.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBhelper{
  static final DBhelper _instanse = DBhelper.internal();
  factory DBhelper() => _instanse;
   DBhelper.internal();
  late Database _db;

  Future<Database> createDatabase()async{
    if(_db != null){
      return _db;
    }
    String path = join(await getDatabasesPath(),'school.db');
  _db = await openDatabase(path, version: 2,onCreate:(Database db , int v){
    db.execute('create table courses (id integer primary key autoincrement , name varchar(50), content varchar(500),hours intger)' );
    },onUpgrade: (Database db, int oldV, int newV) async{
      if(oldV < newV) {
        await db.execute("alter table courses add column level varchar(50) ");
      }
    }  );
    return _db;
  }
  Future<int> createcourse(Course course) async{
    Database db =await createDatabase();
    return db.insert('courses', course.toMap());
  }
  Future<List> allcourses() async{
    Database db = await createDatabase();
    return db.query('courses');
  }
  Future<int> delete(int id) async{
    Database db = await createDatabase();
    return db.delete('courses',where: 'id = ?', whereArgs: [id]);
  }
  Future<int> CourseUpdate(Course course) async{
    Database db = await createDatabase();
    return await db.update('courses',course.toMap(),where:'id = ?',whereArgs: [course.id] );
  }
}