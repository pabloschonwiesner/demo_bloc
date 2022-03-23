import 'package:demo_provider/data/models/skill_model.dart';
import 'package:demo_provider/domain/repositories/abstract_local_person_repository.dart';

class GetListSkills {
  final AbstractLocalPersonRepository _repository;

  GetListSkills({ required AbstractLocalPersonRepository repository} ) : _repository = repository;

  Future<List<SkillModel>> call() async => await _repository.getSkills();
}