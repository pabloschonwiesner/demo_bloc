import 'package:demo_provider/domain/entities/person_skill.dart';

class PersonSkillModel implements PersonSkill {
  @override
  int personId;

  @override
  int skillId;

  PersonSkillModel({required this.personId, required this.skillId});

  factory PersonSkillModel.fromJson(Map<String, dynamic> json) => PersonSkillModel(
    personId: json['personId'], 
    skillId: json['skillId']
  );

  Map<String, dynamic> toJson() => {
    'personId': personId,
    'skillId': skillId
  };
  
}