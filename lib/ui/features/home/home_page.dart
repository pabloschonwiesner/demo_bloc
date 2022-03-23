import 'package:demo_provider/data/models/person_model.dart';
import 'package:demo_provider/ui/features/person/bloc/person_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:demo_provider/ui/core/app_colors.dart';
import 'package:demo_provider/ui/features/home/bloc/home_bloc.dart';
import 'package:demo_provider/ui/features/home/widgets/person_list.dart';
import 'package:demo_provider/ui/features/person/detail_page.dart';

class HomePage extends StatelessWidget {
const HomePage ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (_, state) {
          if ( state.isLoading ) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary,)
            );
          } else {
            return SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: state.persons.isEmpty
                  ? const Text('No hay personas guardadas')
                  : const PersonList()
              )
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          // para bloc no lo uso -- BORRAR
          // Provider.of<PersonProvider>(context, listen: false).setPerson(PersonModel());
          BlocProvider.of<PersonBloc>(context, listen: false).add(PersonIsLoadingEvent());
          BlocProvider.of<PersonBloc>(context, listen: false).add(PersonSetPersonEvent(PersonModel(name: '', lastName: '', picture: '', personId: null)));
          await Navigator.push<bool>(context, MaterialPageRoute(builder: (context) => const DetailPage()));
        }
      ),
    );
  }

}