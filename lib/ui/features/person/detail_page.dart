import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:demo_provider/ui/core/blocs/bloc/skills_bloc.dart';
import 'package:demo_provider/ui/features/home/bloc/home_bloc.dart';
import 'package:demo_provider/ui/features/person/bloc/person_bloc.dart';
import 'package:demo_provider/ui/features/person/widgets/search_skills.dart';

import 'package:demo_provider/ui/features/person/widgets/add_button.dart';
import 'package:demo_provider/ui/features/person/widgets/person_detail.dart';
import 'package:demo_provider/ui/core/app_colors.dart';
import 'package:demo_provider/ui/core/dialogs.dart';


class DetailPage extends StatefulWidget {
const DetailPage ({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final GlobalKey<ScaffoldState> _globalKeyDetail = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final personBloc = BlocProvider.of<PersonBloc>(context);
    final homeBloc = BlocProvider.of<HomeBloc>(context, listen: false);
    final skillsBloc = BlocProvider.of<SkillsBloc>(context, listen: false);
    
    return Scaffold(
      key: _globalKeyDetail,
      appBar: AppBar(
        title: const Text('DetailPage'),
        actions: [ 
          if(personBloc.state.isSavedPerson)
            PopupMenuButton(
              onSelected: (value) async {
                if(value == 'eliminar') {
                  bool response = await Dialogs.confirm(context, title: 'Confirmar', message: '¿Quiere eliminar esta persona?');
                  if(response == true) {
                    // await Provider.of<PersonProvider>(context, listen: false).deletePerson(); 
                    personBloc.add(PersonDeletePersonEvent());
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Persona eliminada')));
                    // await Provider.of<HomeProvider>(context, listen: false).getListPerson();
                    homeBloc.add(GetListPersonEvent());
                    Navigator.of(context).pop();
                  }
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  child: Text('Eliminar persona'),
                  value: 'eliminar'
                )
              ]
            )
        ],
      ),
      body: BlocBuilder<PersonBloc, PersonState>(
        builder: (_, state) {
          if ( state is PersonIsLoadingState ) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary,)
            );
          } else {
            if ( state.isValidPerson ) {
              return const PersonDetail();
            } else {
              return const AddButton();
            }
          }

        },
      ),
      floatingActionButton: personBloc.state.isSavedPerson
        ? FloatingActionButton(
            child: const Icon(Icons.workspace_premium),
            onPressed: () async {
              // await Provider.of<PersonProvider>(context, listen: false).getSkills();
              skillsBloc.add(GetSkillsEvent());
              showSearch(context: context, delegate: SearchSkills());
            },
          ) : null,
    );
  }
}