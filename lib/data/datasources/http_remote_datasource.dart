import 'dart:convert';

import 'package:http/http.dart' show Client;

import 'package:demo_provider/data/models/person_model.dart';
import 'package:demo_provider/data/datasources/abstract_remote_datasource.dart';

class HttpRemoteDatasource implements AbstractRemoteDatasource {

  HttpRemoteDatasource({
    required String url,
    required Client client,
  }) :  _url = url,
        _client = client;

  final String _url;
  final Client _client;

  @override
  Future<PersonModel> getPerson() async {
    try {
      final result = await _client.get(Uri.parse(_url));
      if( result.statusCode == 200) {
        final decode = json.decode(result.body);
        return PersonModel.fromJson(decode['results'].first);
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

}