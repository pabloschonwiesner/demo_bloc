import 'package:demo_provider/data/models/person_model.dart';


abstract class AbstractRemoteDatasource {
  Future<PersonModel> getPerson();
}