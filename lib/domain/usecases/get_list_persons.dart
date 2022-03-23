import 'package:demo_provider/data/models/person_model.dart';
import 'package:demo_provider/domain/repositories/abstract_local_person_repository.dart';

class GetListPersons {
  
  final AbstractLocalPersonRepository _repository;

  GetListPersons( { required AbstractLocalPersonRepository repository } ) : _repository = repository;

  Future<List<PersonModel>> call() async => await _repository.getListPersons();
}