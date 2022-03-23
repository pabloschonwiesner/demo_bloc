import 'package:demo_provider/ui/features/person/bloc/person_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app_colors.dart';


class AddButton extends StatelessWidget {
const AddButton ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final _personProvider = Provider.of<PersonProvider>(context, listen: false);
    final personBloc = BlocProvider.of<PersonBloc>(context);

    return Center(
      child: GestureDetector(
        child: Container(
          width: 120,
          height: 120,                
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary,
            boxShadow: [
              BoxShadow(offset: const Offset(0, 2), spreadRadius: 3, color: AppColors.primary.withOpacity(0.6), blurRadius: 2)
            ]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.person_add_alt_sharp, color: Colors.white, size: 36,),
              SizedBox( height:  5,),
              Text('Add', style: TextStyle(color: Colors.white, fontSize: 16),)
            ],
          ),
        ),
        onTap: () async => personBloc.add(PersonGetNewPersonEvent()) //await _personProvider.getNewPerson(),
      )
    );
  }
}