import 'package:demo_provider/data/datasources/abstract_remote_datasource.dart';
import 'package:demo_provider/data/models/person_model.dart';

import 'package:demo_provider/domain/repositories/abstract_person_repository.dart';

class PersonRepository extends AbstractPersonRepository {

  PersonRepository({
    required AbstractRemoteDatasource remoteDataSource
  }) :  _remoteDataSource = remoteDataSource;

  final AbstractRemoteDatasource _remoteDataSource;


  @override
  Future<PersonModel> getPerson() async {
    try {
      return await _remoteDataSource.getPerson();
    } catch (e) { throw Exception(e); }
  }

}