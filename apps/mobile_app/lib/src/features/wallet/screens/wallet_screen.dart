import 'package:flutter/material.dart';
import 'package:mobile_app/l10n/app_localizations.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 8,
            shadowColor: Theme.of(context).primaryColor.withValues(alpha: 0.3),
            color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.tokenBalance,
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.stars, color: Colors.white, size: 36),
                      const SizedBox(width: 12),
                      Text(
                        '1,250',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            icon: const Icon(Icons.redeem),
            label: Text(AppLocalizations.of(context)!.redeemTokens), // Redeem Tokens
          ),
          const SizedBox(height: 40),
          Text(
            AppLocalizations.of(context)!.recentTransactions,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final isReward = index % 2 == 0;
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: isReward ? Colors.green.withValues(alpha: 0.1) : Colors.orange.withValues(alpha: 0.1),
                  child: Icon(
                    isReward ? Icons.add : Icons.remove,
                    color: isReward ? Colors.green : Colors.orange,
                  ),
                ),
                title: Text(isReward ? AppLocalizations.of(context)!.topUp : AppLocalizations.of(context)!.ridePayment),
                subtitle: const Text('May 08, 2026'),
                trailing: Text(
                  '${isReward ? "+" : "-"} ${isReward ? 50 : 200} ${AppLocalizations.of(context)!.tokens}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isReward ? Colors.green : Colors.orange,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
