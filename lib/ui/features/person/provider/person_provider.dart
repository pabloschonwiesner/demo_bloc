import 'package:demo_provider/data/datasources/http_remote_datasource.dart';
import 'package:demo_provider/data/datasources/sqflite_local_datasource.dart';
import 'package:demo_provider/data/models/person_model.dart';
import 'package:demo_provider/data/models/person_skill_model.dart';
import 'package:demo_provider/data/models/skill_model.dart';
import 'package:demo_provider/data/repositories/local_person_repository.dart';
import 'package:demo_provider/data/repositories/person_repository.dart';
import 'package:demo_provider/domain/usecases/delete_person.dart';
import 'package:demo_provider/domain/usecases/delete_person_skill.dart';
import 'package:demo_provider/domain/usecases/get_list_skills.dart';
import 'package:demo_provider/domain/usecases/get_list_skills_person.dart';
import 'package:demo_provider/domain/usecases/get_person.dart';
import 'package:demo_provider/domain/usecases/save_person.dart';
import 'package:demo_provider/domain/usecases/set_person_skill.dart';
import 'package:demo_provider/ui/core/environment_config.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;


class PersonProvider extends ChangeNotifier {

  late final PersonRepository _personRepository;
  late final LocalPersonRepository _localRepository;

  PersonProvider() {
    final _remoteDataSource = HttpRemoteDatasource(url: EnvironmentConfig.baseUrl, client: Client());
    _personRepository = PersonRepository(remoteDataSource: _remoteDataSource);    

    final _localDataSource = SqfliteLocalDatasource();
    _localRepository = LocalPersonRepository(localDatasourse: _localDataSource);
  }

  

  bool _isLoading = false;
  PersonModel _person = PersonModel();
  List<SkillModel> _skillsPerson = [];
  List<SkillModel> _skills = [];  


  bool get isLoading => _isLoading;
  PersonModel get person => _person;
  bool get isValidPerson => _person.name != null && _person.lastName != null && _person.picture != null;
  List<SkillModel> get skillsPerson => _skillsPerson;
  List<SkillModel> get skills => _skills;

  void setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void setPerson(PersonModel person) {
    _person = person;
    notifyListeners();
  }


  bool isSavedPerson() {
    return person.personId != null && person.personId! > 0 ? true : false;
  }

  Future<void> getNewPerson() async {
    setIsLoading(true);    
    setPerson(await GetPerson(repository: _personRepository)());
    setIsLoading(false);
  }

  Future<void> savePerson() async {
    await SavePersonLocal(repository: _localRepository)(person);
    
  }

  void setSkillsPerson(List<SkillModel> skillsPerson) {
    _skillsPerson = skillsPerson;
    notifyListeners();
  }

  Future<void> getListSkillsPerson() async {
    setSkillsPerson(await GetListSkillsPerson(repository: _localRepository).call(person.personId!));
  }

  Future<void> deletePerson() async {
    await DeletePerson(repository: _localRepository).call(person.personId!);
  }

  

  Future<bool> setPersonSkill(SkillModel skill) async {
    return await(SetPersonSkill(repository: _localRepository)(PersonSkillModel(personId: person.personId!, skillId: skill.skillId!)));
  }

  Future<bool> deletePersonSkill(int skillId) async {
    return await(DeletePersonSkill(repository: _localRepository)(person.personId!, skillId));
  }



  //skills

  Future<void> getSkills() async {
    setSkills(await GetListSkills(repository: _localRepository).call());
  }

  
  void setSkills(List<SkillModel> skills) {
    _skills = skills;
    notifyListeners();
  }
}