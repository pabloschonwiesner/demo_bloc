import 'package:demo_provider/domain/entities/skill.dart';

class SkillModel implements Skill {

  SkillModel({required this.name, this.skillId = 0});

  @override
  String name;

  @override
  int? skillId;

  factory SkillModel.fromJson(Map<String, dynamic> json) => SkillModel(
    skillId: json['skillId'],
    name: json['name']
  );

  Map<String, dynamic> toJson() => {
    'name': name
  };
}