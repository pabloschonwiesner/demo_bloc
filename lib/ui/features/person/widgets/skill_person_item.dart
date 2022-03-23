import 'package:demo_provider/data/models/skill_model.dart';
import 'package:demo_provider/ui/core/app_colors.dart';
import 'package:demo_provider/ui/features/person/bloc/person_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SkillPersonItem extends StatelessWidget {
  const SkillPersonItem ({Key? key, required this.skill}) : super(key: key);
  final SkillModel skill;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(skill.name), 
      backgroundColor: AppColors.accent,
      padding: const EdgeInsets.all(0),

      onDeleted: () async {
        // final _personProvider = Provider.of<PersonProvider>(context, listen: false);
        // await _personProvider.deletePersonSkill(skill.skillId!);
        // await _personProvider.getListSkillsPerson();

        final personBloc = BlocProvider.of<PersonBloc>(context, listen: false);
        personBloc.add(PersonDeletePersonSkillEvent(skill.skillId!));
        personBloc.add(PersonGetListSkillsEvent());
      },
    );
  }
}