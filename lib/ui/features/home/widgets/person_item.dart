import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:demo_provider/data/models/person_model.dart';
import 'package:demo_provider/ui/features/person/bloc/person_bloc.dart';

class PersonItem extends StatelessWidget {
const PersonItem ({Key? key, required this.person}) : super(key: key);
final PersonModel person;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      leading: ClipOval(                
        child:  FadeInImage(
          fit: BoxFit.cover,
          placeholder: const AssetImage('assets/images/personPlaceholder.png'),
          image: NetworkImage(person.picture ?? ''),
        )
      ),
      title: Text('${person.name} ${person.lastName}', style: const TextStyle(fontSize: 17)),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[350], size: 17,),
      onTap: () {
        final personBloc = BlocProvider.of<PersonBloc>(context, listen: false);
        personBloc.add(PersonSetPersonEvent(person));
        // personBloc.add(PersonGetListSkillsEvent());
        Navigator.pushNamed(context, 'detail');
      },
    );
  }
}