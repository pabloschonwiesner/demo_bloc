part of 'home_bloc.dart';


abstract class HomeEvent {}
  
class SetIsLoadingEvent extends HomeEvent {
  final bool isLoading;
  SetIsLoadingEvent(this.isLoading);
}

class SetPersonsEvent extends HomeEvent {
  final List<PersonModel> persons;
  SetPersonsEvent(this.persons);
}


class GetListPersonEvent extends HomeEvent {}