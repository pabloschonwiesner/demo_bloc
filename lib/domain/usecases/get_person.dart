
import 'package:demo_provider/data/models/person_model.dart';
import 'package:demo_provider/domain/repositories/abstract_person_repository.dart';

class GetPerson {
  
  final AbstractPersonRepository _repository;

  GetPerson( { required AbstractPersonRepository repository } ) : _repository = repository;

  Future<PersonModel> call() async => await _repository.getPerson();
}