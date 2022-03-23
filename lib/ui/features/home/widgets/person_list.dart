import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:demo_provider/ui/features/home/bloc/home_bloc.dart';
import 'package:demo_provider/ui/features/home/widgets/person_item.dart';

class PersonList extends StatelessWidget {
const PersonList ({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (_, state ) {
        return ListView.separated(
          padding: const EdgeInsets.only(top: 60),
          separatorBuilder: (_, int i) => const Divider(),
          itemCount: state.persons.length,
          itemBuilder: (BuildContext context, int i) => PersonItem(person: state.persons[i]) 
        );

      },
    );
  }
}