import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:demo_provider/data/models/person_model.dart';
import 'package:demo_provider/ui/core/app_colors.dart';
import 'package:demo_provider/ui/features/home/bloc/home_bloc.dart';
import 'package:demo_provider/ui/features/person/bloc/person_bloc.dart';
import 'package:demo_provider/ui/features/person/widgets/skills_person.dart';


class PersonDetail extends StatelessWidget {
  const PersonDetail ({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    const TextStyle _textStyleName =  TextStyle(fontSize: 32, fontWeight: FontWeight.bold); 
  
    return BlocBuilder<PersonBloc, PersonState>(
      builder: ( context , state) {
        if(state is PersonIsLoadingState) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary)
          );
        } else {
          PersonModel person = state.person!;
          final personBloc = BlocProvider.of<PersonBloc>(context, listen: false);

          return SingleChildScrollView(
            child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 50, width: double.infinity,),
              ClipOval(              
                child: FadeInImage(
                  height: 160,
                  width: 160,          
                  fit: BoxFit.contain,    
                  placeholder: const AssetImage('assets/images/personPlaceholder.png'), 
                  image: NetworkImage(person.picture!) 
                ),
              ),
              const SizedBox(height: 10),
              Text(person.name!, style: _textStyleName),
              const SizedBox(height: 10),
              Text(person.lastName!, style: _textStyleName),
              const SizedBox(height: 10),
              if (person.personId == null) 
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: const Text('Other'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(AppColors.accent),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),                  
                        ))
                      ),
                      onPressed: () async {
                        personBloc.add(PersonGetNewPersonEvent());
                      }
                    ),
                    const SizedBox(width: 10,),
                    ElevatedButton(
                      child: const Text('Save'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(AppColors.success),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),                  
                        ))
                      ),
                      onPressed: () async { 
                        personBloc.add(PersonSavePersonEvent()); //await personProvider.savePerson();                      
                        personBloc.add(PersonClearEvent());                    
                        BlocProvider.of<HomeBloc>(context, listen: false).add(GetListPersonEvent()); //Provider.of<HomeProvider>(context, listen: false).getListPerson();
                        Navigator.pop(context, true);
                      },
                    ),
                  ],
                )
              else  
                const SkillsPerson()
            ]),
          );
        }
      }
      
    );
      
  }
}