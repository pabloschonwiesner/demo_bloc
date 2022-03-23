

part of 'home_bloc.dart';


abstract class HomeState {
  final List<PersonModel> persons;
  final bool isLoading;

  const HomeState({this.persons = const [], this.isLoading = false});

}

class HomeInitialState extends HomeState {
  const HomeInitialState() : super(persons: const [], isLoading: false);
}

class HomePersons extends HomeState {
  
  final List<PersonModel> listPersons;
  const HomePersons(this.listPersons) : super(
    isLoading: false, 
    persons: listPersons 
  );
}

class HomeIsLoading extends HomeState {
  const HomeIsLoading() : super(isLoading: true, persons: const []);
}