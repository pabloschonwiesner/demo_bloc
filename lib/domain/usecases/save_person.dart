import 'package:demo_provider/data/models/person_model.dart';
import 'package:demo_provider/domain/repositories/abstract_local_person_repository.dart';

class SavePersonLocal {
  
  final AbstractLocalPersonRepository _repository;

  SavePersonLocal( { required AbstractLocalPersonRepository repository } ) : _repository = repository;

  Future<bool> call(PersonModel person) async => await _repository.savePerson(person);
}