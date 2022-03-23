import 'package:demo_provider/data/models/person_model.dart';
import 'package:demo_provider/data/models/person_skill_model.dart';
import 'package:demo_provider/data/models/skill_model.dart';

abstract class AbstractLocalPersonRepository {
  Future<bool> savePerson(PersonModel person);
  Future<List<PersonModel>> getListPersons();
  Future<List<SkillModel>> getListSkillsPerson(int personId);
  Future<bool> deletePerson(int personId);
  Future<List<SkillModel>> getSkills();
  Future<bool> setPersonSkill(PersonSkillModel skill);
  Future<bool> deletePersonSkill(int personId, int skillId);
}