import 'package:demo_provider/ui/features/person/bloc/person_bloc.dart';
import 'package:demo_provider/ui/features/person/widgets/skill_person_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SkillsPerson extends StatelessWidget {
const SkillsPerson ({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonBloc, PersonState>(
      builder: (_, state) {
        return  Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 230,    
            child: Wrap(
              children: state.skillsPerson!.map((e) => SkillPersonItem(skill: e )).toList(),
              spacing: 6,
            )      
          ),
        );

      },
    );
  }
}