import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/giveaway.dart';

class GiveawayDetailScreen extends StatelessWidget {
  const GiveawayDetailScreen({super.key, required this.giveaway});

  final Giveaway giveaway;

  Future<void> _copyGiveawayLink(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: giveaway.giveawayUrl));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Giveaway link copied.')));
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = giveaway.image.isNotEmpty
        ? giveaway.image
        : giveaway.thumbnail;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 260,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'giveaway-${giveaway.id}',
                child: imageUrl.isEmpty
                    ? const ColoredBox(color: Colors.black12)
                    : Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => const ColoredBox(
                          color: Colors.black12,
                          child: Icon(Icons.image_not_supported_outlined),
                        ),
                      ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
            sliver: SliverList.list(
              children: [
                Text(
                  giveaway.title,
                  style: Theme.of(context).textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _InfoChip(
                      icon: Icons.redeem_outlined,
                      label: giveaway.displayWorth,
                    ),
                    _InfoChip(
                      icon: Icons.category_outlined,
                      label: giveaway.type,
                    ),
                    _InfoChip(
                      icon: Icons.event_outlined,
                      label: giveaway.displayEndDate,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _LabelValue(
                  icon: Icons.devices_outlined,
                  label: 'Platforms',
                  value: giveaway.platforms,
                ),
                if (giveaway.users > 0) ...[
                  const SizedBox(height: 10),
                  _LabelValue(
                    icon: Icons.people_outline,
                    label: 'GamerPower users',
                    value: '${giveaway.users}',
                  ),
                ],
                const Divider(height: 32),
                const _SectionTitle('Description'),
                const SizedBox(height: 8),
                Text(giveaway.description),
                const SizedBox(height: 24),
                const _SectionTitle('How to claim'),
                const SizedBox(height: 8),
                Text(giveaway.instructions),
                if (giveaway.giveawayUrl.isNotEmpty) ...[
                  const SizedBox(height: 28),
                  FilledButton.icon(
                    onPressed: () => _copyGiveawayLink(context),
                    icon: const Icon(Icons.copy),
                    label: const Text('Copy giveaway link'),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      side: BorderSide.none,
    );
  }
}

class _LabelValue extends StatelessWidget {
  const _LabelValue({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 10),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '$label: ',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleLarge
          ?.copyWith(fontWeight: FontWeight.w700),
    );
  }
}
