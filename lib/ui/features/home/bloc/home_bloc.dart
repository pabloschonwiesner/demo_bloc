import 'package:bloc/bloc.dart';
import 'package:demo_provider/data/datasources/sqflite_local_datasource.dart';
import 'package:demo_provider/data/models/person_model.dart';
import 'package:demo_provider/data/repositories/local_person_repository.dart';
import 'package:demo_provider/domain/usecases/get_list_persons.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late final LocalPersonRepository _localRepository;
  
  HomeBloc() : super(const HomeInitialState()) {
    final _localDataSource = SqfliteLocalDatasource();
    _localRepository = LocalPersonRepository(localDatasourse: _localDataSource);



    on<SetIsLoadingEvent>( (event, emit) => { emit(const HomeIsLoading())});
    
    on<GetListPersonEvent>( (event, emit) async {
      final listPersons = await GetListPersons(repository: _localRepository).call();
      emit(HomePersons(listPersons));
    });
  }
  
}