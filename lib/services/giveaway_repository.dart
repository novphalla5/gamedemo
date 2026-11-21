import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/giveaway.dart';

abstract interface class GiveawayRepository {
  Future<List<Giveaway>> fetchGiveaways();
}

class ApiGiveawayRepository implements GiveawayRepository {
  ApiGiveawayRepository({http.Client? client})
    : _client = client ?? http.Client();

  static final Uri _endpoint = Uri.parse(
    'https://www.gamerpower.com/api/giveaways',
  );

  final http.Client _client;

  @override
  Future<List<Giveaway>> fetchGiveaways() async {
    final response = await _client
        .get(_endpoint, headers: const {'Accept': 'application/json'})
        .timeout(const Duration(seconds: 15));

    if (response.statusCode != 200) {
      throw GiveawayException(
        'The server returned status ${response.statusCode}.',
      );
    }

    final decoded = jsonDecode(response.body);
    if (decoded is! List) {
      throw const GiveawayException('The server returned invalid data.');
    }

    return decoded
        .whereType<Map<String, dynamic>>()
        .map(Giveaway.fromJson)
        .toList(growable: false);
  }
}

class GiveawayException implements Exception {
  const GiveawayException(this.message);

  final String message;

  @override
  String toString() => message;
}
