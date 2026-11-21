import 'package:flutter_test/flutter_test.dart';
import 'package:gamerpower_app/models/giveaway.dart';

void main() {
  test('Giveaway parses the GamerPower response', () {
    final giveaway = Giveaway.fromJson({
      'id': 42,
      'title': 'Test Game',
      'worth': 'N/A',
      'thumbnail': 'https://example.com/thumb.jpg',
      'image': 'https://example.com/image.jpg',
      'description': 'Description',
      'instructions': 'Instructions',
      'open_giveaway_url': 'https://example.com/open',
      'published_date': '2026-11-20 10:00:00',
      'type': 'DLC',
      'platforms': 'PC, Steam',
      'end_date': '2026-12-01 23:59:00',
      'users': 1234,
      'status': 'Active',
    });

    expect(giveaway.id, 42);
    expect(giveaway.title, 'Test Game');
    expect(giveaway.displayWorth, 'Free');
    expect(giveaway.displayEndDate, '2026-12-01');
    expect(giveaway.giveawayUrl, 'https://example.com/open');
    expect(giveaway.users, 1234);
  });
}
