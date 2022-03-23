import 'package:bloc/bloc.dart';
import 'package:demo_provider/data/datasources/sqflite_local_datasource.dart';
import 'package:demo_provider/data/models/skill_model.dart';
import 'package:demo_provider/data/repositories/local_person_repository.dart';
import 'package:demo_provider/domain/usecases/get_list_skills.dart';
import 'package:meta/meta.dart';

part 'skills_event.dart';
part 'skills_state.dart';

class SkillsBloc extends Bloc<SkillsEvent, SkillsState> {

  late final LocalPersonRepository _localRepository;


  SkillsBloc() : super(const SkillsInitialState()) {
    final _localDatasource = SqfliteLocalDatasource();
    _localRepository = LocalPersonRepository(localDatasourse: _localDatasource);


    on<SkillsEvent>((event, emit) {
      on((event, emit) async {
        final listSkills = await GetListSkills(repository: _localRepository).call();
        emit(SkillsSkillsState(listSkills));
      });
    });
  }
}
