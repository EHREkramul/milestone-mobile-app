import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/rank.dart';
import '../services/timer_service.dart';

class RankScreen extends StatelessWidget {
  const RankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D1A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white70),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Ranks',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<TimerService>(
        builder: (context, timer, _) {
          final currentRank = Rank.getRankForDays(timer.days);

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: Rank.ranks.length,
            itemBuilder: (context, index) {
              final rank = Rank.ranks[index];
              final isUnlocked = timer.days >= rank.minDays;
              final isCurrent = rank == currentRank;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  gradient: isCurrent
                      ? const LinearGradient(
                          colors: [Color(0xFF7B2FF7), Color(0xFF00E5FF)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: isCurrent ? null : Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isCurrent
                        ? Colors.transparent
                        : isUnlocked
                        ? Colors.white24
                        : Colors.white10,
                  ),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  leading: Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: isUnlocked
                          ? Colors.white.withOpacity(0.15)
                          : Colors.white.withOpacity(0.05),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        isUnlocked ? rank.emoji : '🔒',
                        style: TextStyle(
                          fontSize: 24,
                          color: isUnlocked ? null : Colors.white24,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    rank.title,
                    style: TextStyle(
                      color: isUnlocked ? Colors.white : Colors.white38,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 2),
                      Text(
                        rank.description,
                        style: TextStyle(
                          color: isUnlocked ? Colors.white70 : Colors.white24,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        rank.maxDays >= 99999
                            ? '${rank.minDays}+ days'
                            : '${rank.minDays} – ${rank.maxDays} days',
                        style: TextStyle(
                          color: isUnlocked ? Colors.white54 : Colors.white24,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  trailing: isCurrent
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'CURRENT',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        )
                      : isUnlocked
                      ? const Icon(
                          Icons.check_circle,
                          color: Colors.white54,
                          size: 20,
                        )
                      : null,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
