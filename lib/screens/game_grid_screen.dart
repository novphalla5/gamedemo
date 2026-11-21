import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/giveaway.dart';
import '../services/giveaway_repository.dart';
import '../widgets/giveaway_card.dart';
import 'giveaway_detail_screen.dart';

class GameGridScreen extends StatefulWidget {
  const GameGridScreen({super.key, required this.repository});

  final GiveawayRepository repository;

  @override
  State<GameGridScreen> createState() => _GameGridScreenState();
}

class _GameGridScreenState extends State<GameGridScreen> {
  late Future<List<Giveaway>> _giveaways;

  @override
  void initState() {
    super.initState();
    _giveaways = widget.repository.fetchGiveaways();
  }

  Future<void> _refresh() async {
    final next = widget.repository.fetchGiveaways();
    setState(() => _giveaways = next);
    await next;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Free Games'),
            Text(
              'Powered by GamerPower',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Refresh giveaways',
            onPressed: _refresh,
            icon: const Icon(Icons.refresh),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: FutureBuilder<List<Giveaway>>(
        future: _giveaways,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return _ErrorState(onRetry: _refresh);
          }

          final giveaways = snapshot.data ?? const <Giveaway>[];
          if (giveaways.isEmpty) {
            return const _EmptyState();
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              // Keep each card wide enough for its labels on phones and
              // resizable desktop windows. A fixed two-column minimum caused
              // RenderFlex overflow when the Windows window was narrow.
              final availableWidth = constraints.maxWidth - 32;
              final columns = math.min(
                5,
                math.max(1, (availableWidth / 220).floor()),
              );

              return RefreshIndicator(
                onRefresh: _refresh,
                child: GridView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                  physics: const AlwaysScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    mainAxisExtent: 300,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: giveaways.length,
                  itemBuilder: (context, index) {
                    final giveaway = giveaways[index];
                    return GiveawayCard(
                      giveaway: giveaway,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) =>
                              GiveawayDetailScreen(giveaway: giveaway),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.onRetry});

  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.cloud_off_rounded,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'Could not load giveaways',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text(
              'Check your internet connection and try again.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Text('There are no active giveaways right now.'),
      ),
    );
  }
}
