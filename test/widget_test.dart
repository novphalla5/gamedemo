import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gamerpower_app/app.dart';
import 'package:gamerpower_app/models/giveaway.dart';
import 'package:gamerpower_app/services/giveaway_repository.dart';

void main() {
  testWidgets('shows games, opens details, and changes theme', (tester) async {
    tester.view.physicalSize = const Size(360, 720);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(GamerPowerApp(repository: _FakeRepository()));
    await tester.pumpAndSettle();

    expect(find.text('Free Games'), findsOneWidget);
    expect(find.text('Sample Giveaway'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Sample Giveaway'));
    await tester.pumpAndSettle();
    expect(find.text('Description'), findsOneWidget);
    expect(find.text('How to claim'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.tune_outlined));
    await tester.pumpAndSettle();

    expect(find.text('Dark mode'), findsOneWidget);
    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    final context = tester.element(find.text('Dark mode'));
    expect(Theme.of(context).brightness, Brightness.dark);
  });
}

class _FakeRepository implements GiveawayRepository {
  @override
  Future<List<Giveaway>> fetchGiveaways() async => const [
    Giveaway(
      id: 1,
      title: 'Sample Giveaway',
      worth: r'$9.99',
      thumbnail: '',
      image: '',
      description: 'A sample game description.',
      instructions: 'Follow the instructions.',
      giveawayUrl: '',
      publishedDate: '2026-11-20 10:00:00',
      type: 'Game',
      platforms: 'PC',
      endDate: '2026-11-30 23:59:00',
      users: 100,
      status: 'Active',
    ),
  ];
}
