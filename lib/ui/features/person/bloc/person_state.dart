part of 'person_bloc.dart';

@immutable
abstract class PersonState {
  final bool isValidPerson;
  final bool isSavedPerson;
  final PersonModel? person;
  final List<SkillModel>? skillsPerson;

  const PersonState({
    this.isValidPerson = false, 
    this.isSavedPerson = false, 
    this.person, 
    this.skillsPerson}
  ); 

}

class PersonInitialState extends PersonState {
  const PersonInitialState() : super(isValidPerson: false, isSavedPerson: false, person: null, skillsPerson: const []);
}

class PersonIsLoadingState extends PersonState {}

class PersonIsLoadedState extends PersonState {}

class PersonIsSaved extends PersonState {}

class PersonPersonState extends PersonState {
  final PersonModel newPerson;
  final List<SkillModel> newSkillsPerson;
  final bool localIsValidPerson;
  final bool localIsSavedPerson;

  const PersonPersonState({required this.newPerson, required this.localIsValidPerson, required this.localIsSavedPerson, required this.newSkillsPerson}) :
    super( isValidPerson: localIsValidPerson, isSavedPerson: localIsSavedPerson, person: newPerson, skillsPerson: newSkillsPerson );
}

class PersonSaved extends PersonState {}

