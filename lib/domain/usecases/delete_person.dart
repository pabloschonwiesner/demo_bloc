import 'package:demo_provider/domain/repositories/abstract_local_person_repository.dart';

class DeletePerson {
  final AbstractLocalPersonRepository _repository;

  DeletePerson({ required AbstractLocalPersonRepository repository}) : _repository = repository;

  Future<bool> call(int personId) async => await _repository.deletePerson(personId);
}