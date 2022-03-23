import 'package:demo_provider/data/models/person_skill_model.dart';
import 'package:demo_provider/domain/repositories/abstract_local_person_repository.dart';

class SetPersonSkill {
  final AbstractLocalPersonRepository _repository;

  SetPersonSkill({ required AbstractLocalPersonRepository repository} ) : _repository = repository;

  Future<bool> call(PersonSkillModel skill) async => await _repository.setPersonSkill(skill);
}