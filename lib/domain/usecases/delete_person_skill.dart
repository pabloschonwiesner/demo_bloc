import 'package:demo_provider/domain/repositories/abstract_local_person_repository.dart';

class DeletePersonSkill {
  final AbstractLocalPersonRepository _repository;

  DeletePersonSkill({ required AbstractLocalPersonRepository repository}) : _repository = repository;

  Future<bool> call(int personId, int skillId) async => await _repository.deletePersonSkill(personId, skillId);
}