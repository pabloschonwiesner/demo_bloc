import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' show Client;

import 'package:demo_provider/data/datasources/http_remote_datasource.dart';
import 'package:demo_provider/data/datasources/sqflite_local_datasource.dart';
import 'package:demo_provider/data/models/person_model.dart';
import 'package:demo_provider/data/models/person_skill_model.dart';
import 'package:demo_provider/data/models/skill_model.dart';
import 'package:demo_provider/data/repositories/local_person_repository.dart';
import 'package:demo_provider/data/repositories/person_repository.dart';
import 'package:demo_provider/domain/usecases/delete_person.dart';
import 'package:demo_provider/domain/usecases/get_list_skills_person.dart';
import 'package:demo_provider/domain/usecases/get_person.dart';
import 'package:demo_provider/domain/usecases/save_person.dart';
import 'package:demo_provider/domain/usecases/set_person_skill.dart';
import 'package:demo_provider/ui/core/environment_config.dart';

part 'person_event.dart';
part 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  late final PersonRepository _remoteRepository;
  late final LocalPersonRepository _localRepository;
  
  PersonBloc() : super(const PersonInitialState()) {
    final _remoteDataSource = HttpRemoteDatasource(url: EnvironmentConfig.baseUrl, client: Client());
    final _localDataSource = SqfliteLocalDatasource();
    _remoteRepository = PersonRepository(remoteDataSource: _remoteDataSource);
    _localRepository = LocalPersonRepository(localDatasourse: _localDataSource);

    on<PersonIsLoadingEvent>((event, emit) {
      on((event, emit) => emit(PersonIsLoadingState()));
    });

    on<PersonIsLoadedEvent>((event, emit) {
      on((event, emit) => emit(PersonIsLoadedState()));
    });

    on<PersonClearEvent>((event, emit) {
      on((event, emit) => emit(
        PersonPersonState(
          newPerson: PersonModel(
            lastName: '', 
            name: '', 
            personId: null, 
            picture: ''
          ), 
          localIsSavedPerson: false, 
          localIsValidPerson: false, 
          
          newSkillsPerson: const []
        )
      ));
    });

    on<PersonGetNewPersonEvent>((event, emit) async {
      emit(PersonIsLoadingState());
      final newPerson = await GetPerson(repository: _remoteRepository)();
      emit(PersonPersonState(newPerson: newPerson, localIsSavedPerson: false, localIsValidPerson: true, newSkillsPerson: const []));
      emit(PersonIsLoadedState());
    });

    on<PersonSetPersonEvent>((event, emit) async {
      emit(PersonIsLoadingState());
      emit(PersonPersonState(newPerson: event.person, localIsValidPerson: true, localIsSavedPerson: true, newSkillsPerson: const []));
      emit(PersonIsLoadedState());
    });

    on<PersonGetListSkillsEvent>((event, emit) async {
      final listSkillsPerson = await GetListSkillsPerson(repository: _localRepository).call(state.person!.personId!);
      emit(PersonPersonState(newPerson: state.person!, localIsValidPerson: true, localIsSavedPerson: true, newSkillsPerson: listSkillsPerson));
    });

    on<PersonSetSkillEvent>((event, emit) async {
      await SetPersonSkill(repository: _localRepository)(PersonSkillModel(personId: state.person!.personId!, skillId: event.newSkill.skillId!));      
    });

    on<PersonDeletePersonEvent>((event, emit) async {
      await DeletePerson(repository: _localRepository)(state.person!.personId!);
    });

    on<PersonDeletePersonSkillEvent>((event, emit) async {
      await DeletePerson(repository: _localRepository)(event.skillId);
    });

    on<PersonSavePersonEvent>((event, emit) async {
      await SavePersonLocal(repository: _localRepository)(state.person!);
    });
  }
}
