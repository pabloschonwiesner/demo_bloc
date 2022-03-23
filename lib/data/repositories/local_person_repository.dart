import 'package:demo_provider/data/datasources/abstract_local_datasource.dart';
import 'package:demo_provider/data/models/person_model.dart';
import 'package:demo_provider/data/models/person_skill_model.dart';
import 'package:demo_provider/data/models/skill_model.dart';
import 'package:demo_provider/domain/repositories/abstract_local_person_repository.dart';

class LocalPersonRepository implements AbstractLocalPersonRepository {

  LocalPersonRepository({
    required AbstractLocalDatasource localDatasourse
  }) : _localDatasourse = localDatasourse;

  final AbstractLocalDatasource _localDatasourse;

  @override
  Future<bool> savePerson(PersonModel person) async {
    try {
      return await _localDatasourse.savePerson(person);
    } catch (e)  { throw Exception(e); }
  }

  @override
  Future<List<PersonModel>> getListPersons() async {
    try {
      return await _localDatasourse.getListPersons();
    } catch (e)  { throw Exception(e); }
  }

  @override
  Future<List<SkillModel>> getListSkillsPerson(int personId) async {
    try {
      return await _localDatasourse.getSkillsPerson(personId);
    } catch (e)  { throw Exception(e); }
  }

  @override
  Future<List<SkillModel>> getSkills() async {
    try {
      return await _localDatasourse.getSkills();
    } catch (e)  { throw Exception(e); }
  }

  @override
  Future<bool> deletePerson(int personId) async {
    try {
      return await _localDatasourse.deletePerson(personId);
    } catch (e) { throw Exception(e); }
  }

  @override
  Future<bool> setPersonSkill(PersonSkillModel skill) async {
    try {
      return await _localDatasourse.setPersonSkill(skill);
    } catch(e) { throw Exception(e); }
  }

  @override
  Future<bool> deletePersonSkill(int personId, int skillId) async {
    try {
      return await _localDatasourse.deletePersonSkill(personId, skillId);
    } catch (e) { throw Exception(e); }
  }
}