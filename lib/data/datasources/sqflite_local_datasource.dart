import 'package:demo_provider/data/models/person_model.dart';
import 'package:demo_provider/data/models/person_skill_model.dart';
import 'package:demo_provider/data/models/skill_model.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:demo_provider/data/datasources/abstract_local_datasource.dart';

class SqfliteLocalDatasource implements AbstractLocalDatasource {

  SqfliteLocalDatasource();
  Database? _database;

  Future<Database> get database async { 
    try {
      if(_database != null) return _database!;
      return await _initDb();
    } catch (e) { throw Exception(e); }
  }

  Future<Database> _initDb() async {
    try {
      final databasesPath = await getDatabasesPath();
      final path = join(databasesPath, 'demo.db');
      await Directory(databasesPath).create(recursive: true);
      return await openDatabase(
        path,
        version: 1,
        onCreate: onCreateDatabse
      );
    } catch (e) { throw Exception(e); }
  }

  Future<void> onCreateDatabse(Database database, int version) async {
    try {
      await database.execute('CREATE TABLE persons (personId INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, lastName TEXT, picture TEXT)');
      await database.execute('CREATE TABLE skills (skillId INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)');
      await database.execute('CREATE TABLE persons_skills (personId INTEGER, skillId INTEGER)');
      await database.transaction((txn) async {
        await txn.rawInsert("INSERT INTO skills (name) VALUES ('Dart'), ('Flutter'), ('Java'), ('Javascript'), ('Docker'), ('MongoDB'), ('SQL Server'), ('MySql'), ('C#'), ('.Net')");
      });
    } catch(e) { throw Exception(e); }
  }

  @override
  Future<bool> savePerson(PersonModel person) async {
    try {
      Database _db = await database;
      final PersonModel personModel = PersonModel.fromPerson(person);
      int result = await _db.insert('persons', personModel.toJson());
      return result > 0 ? true : false;
    } catch (e) { throw Exception(e); }
  }

  @override
  Future<List<PersonModel>> getListPersons() async{
    try {
      Database _db = await database;
      final result = await _db.query('persons');
      return result.map((e) => PersonModel.fromSqflite(e)).toList();
    } catch (e) { throw Exception(e); }
  }

  @override
  Future<PersonModel> getPerson(int personId) async{
    try {
      Database _db = await database;
      final result = await _db.query('persons', where: 'personId = ?', whereArgs: [personId] );
      return List.from(result).map((e) => PersonModel.fromJson(e)).toList()[0];
    } catch (e) { throw Exception(e); }
  }

  @override
  Future<List<SkillModel>> getSkills() async{
    try {
      Database _db = await database;
      final result = await _db.query('skills');
      return List.from(result).map((e) => SkillModel.fromJson(e)).toList();
    } catch (e) { throw Exception(e); }
  }

  @override
  Future<List<SkillModel>> getSkillsPerson(int personId) async {
    try {
      Database _db = await database;
      final result = await _db.rawQuery('SELECT S.* FROM persons_skills PS INNER JOIN skills S ON S.skillId = PS.skillId WHERE PS.personId = ?', [personId]);
      return List.from(result).map((e) => SkillModel.fromJson(e)).toList();
    } catch (e) { throw Exception(e); }
  }

  @override
  Future<bool> deletePerson(int personId) async {
    try {
      Database _db = await database;
      await _db.delete('persons', where: 'personId = ?', whereArgs: [personId]);
      return Future.value(true);
    } catch (e) { throw Exception(e); }
  }

  @override
  Future<bool> setPersonSkill(PersonSkillModel skill) async {
    try {
      Database _db = await database;
      int result = await _db.insert('persons_skills', skill.toJson());
      return result > 0 ? true : false;
    } catch (e) { throw Exception(e); }
  }

  @override
  Future<bool> deletePersonSkill(int personId, int skillId) async {
    try {
      Database _db = await database;
      int result = await _db.delete('persons_skills', where: ' personId = ? AND skillId = ?', whereArgs: [personId, skillId]);
      return result > 0 ? true : false;
    } catch (e) { throw Exception(e); }
  }


}