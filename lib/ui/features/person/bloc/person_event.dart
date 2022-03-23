part of 'person_bloc.dart';

@immutable
abstract class PersonEvent {}

class PersonIsLoadingEvent extends PersonEvent {}

class PersonIsLoadedEvent extends PersonEvent {}

class PersonGetNewPersonEvent extends PersonEvent {}

class PersonSetPersonEvent extends PersonEvent {
  final PersonModel person;
  PersonSetPersonEvent(this.person);
}

class PersonGetListSkillsEvent extends PersonEvent {}

class PersonSetSkillEvent extends PersonEvent {
  final SkillModel newSkill;
  PersonSetSkillEvent(this.newSkill);
}

class PersonDeletePersonEvent extends PersonEvent {}

class PersonDeletePersonSkillEvent extends PersonEvent {
  final int skillId;
  PersonDeletePersonSkillEvent(this.skillId);
}

class PersonSavePersonEvent extends PersonEvent {}

class PersonClearEvent extends PersonEvent {}

