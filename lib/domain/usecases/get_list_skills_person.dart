import 'package:demo_provider/data/models/skill_model.dart';
import 'package:demo_provider/domain/repositories/abstract_local_person_repository.dart';

class GetListSkillsPerson {
  final AbstractLocalPersonRepository _repository;

  GetListSkillsPerson({required AbstractLocalPersonRepository repository}) : _repository = repository;

  Future<List<SkillModel>> call(int personId) async => await _repository.getListSkillsPerson(personId);
}