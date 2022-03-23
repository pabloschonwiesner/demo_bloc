part of 'skills_bloc.dart';

@immutable
abstract class SkillsState {
  final List<SkillModel>? skills;

  const SkillsState({required this.skills});

}

class SkillsInitialState extends SkillsState {
  const SkillsInitialState() : super(skills: const []);
}

class SkillsSkillsState extends SkillsState {
  final List<SkillModel>? listSkills;
  const SkillsSkillsState(this.listSkills) : super(skills: listSkills);
}


