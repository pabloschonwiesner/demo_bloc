import 'package:demo_provider/data/datasources/sqflite_local_datasource.dart';
import 'package:demo_provider/data/models/person_model.dart';
import 'package:demo_provider/data/repositories/local_person_repository.dart';
import 'package:demo_provider/domain/usecases/get_list_persons.dart';
import 'package:flutter/foundation.dart';

class HomeProvider extends ChangeNotifier {

  late final LocalPersonRepository _localRepository;

  HomeProvider() {
    final _localDataSource = SqfliteLocalDatasource();
    _localRepository = LocalPersonRepository(localDatasourse: _localDataSource);
    getListPerson();
  }

  List<PersonModel> _persons = [];
  bool _isLoading = false;

  List<PersonModel> get persons => _persons;
  bool get isLoading => _isLoading;

  void setPersons(List<PersonModel> persons) {
    _persons = persons;
    notifyListeners();
  }

  void setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  Future<void> getListPerson() async {
    setIsLoading(true);
    final listPersons = await GetListPersons(repository: _localRepository).call();
    setIsLoading(false);
    setPersons(listPersons);
  }
}