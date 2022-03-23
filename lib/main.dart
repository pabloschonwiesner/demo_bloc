import 'package:demo_provider/ui/core/blocs/bloc/skills_bloc.dart';
import 'package:demo_provider/ui/features/app.dart';
import 'package:demo_provider/ui/features/home/bloc/home_bloc.dart';
import 'package:demo_provider/ui/features/person/bloc/person_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => HomeBloc() ),
      BlocProvider(create: (_) => PersonBloc() ),
      BlocProvider(create: (_) => SkillsBloc() )
    ],
    child: const App()
  ));
}



